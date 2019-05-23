# frozen_string_literal: true

# from http://stackoverflow.com/a/36134208/1796645
class CollectionLengthValidator < ActiveModel::Validations::LengthValidator
  def validate_each(record, attribute, value)
    value = value.respond_to?(:reject) ? value.reject(&:marked_for_destruction?) : value
    super(record, attribute, value)
  end
end

# This Model represents a Cocktail Recipe
# name
# cocktail_recipe_parts
class CocktailRecipe < ApplicationRecord
  PROFIT_MARGIN = 1.03

  alias_attribute :parts, :cocktail_recipe_parts
  has_many :cocktail_recipe_parts, dependent: :destroy
  accepts_nested_attributes_for :cocktail_recipe_parts, reject_if: :all_blank, allow_destroy: true

  has_many :user_cocktail_likes, dependent: :destroy
  has_many :users, through: :user_cocktail_likes

  alias_attribute :liking_users, :users

  ## validations
  validates :name, presence: true, uniqueness: true
  validates :cocktail_recipe_parts, collection_length: { minimum: 2 }

  ## scopes
  scope :liked, -> { joins(:user_cocktail_likes).distinct }
  scope :liked_sorted, lambda {
    # inspired from https://stackoverflow.com/a/22235146/1796645
    select('cocktail_recipes.*, COUNT(user_cocktail_likes.id) vote_count')
      .joins(:user_cocktail_likes)
      .group('cocktail_recipes.id')
      .order('vote_count DESC')
  }

  def cost
    cocktail_recipe_parts.sum(&:cost).round(2)
  end

  def selling_price
    (cost * PROFIT_MARGIN).round(1)
  end

  def likes
    user_cocktail_likes.count
  end

  def alternatives
    part_to_change = cocktail_recipe_parts.reject(&:strict?).first
    category = part_to_change.ingredient_category

    alternative_ingredients_for_unstrict = category.ingredients.reject do |ingredient_possibility|
      ingredient_possibility == part_to_change.ingredient
    end
    return none if alternative_ingredients_for_unstrict.empty?

    array = []
    alternative_ingredients_for_unstrict.each do |alternative_ingredient|
      in_memory_recipe = deep_clone
      in_memory_recipe.cocktail_recipe_parts.reject(&:strict?).first.ingredient = alternative_ingredient
      array << in_memory_recipe
    end
    array
  end

  private

  def deep_clone
    duplicate = dup
    duplicate.parts = parts.map(&:dup)
    duplicate
  end
end
