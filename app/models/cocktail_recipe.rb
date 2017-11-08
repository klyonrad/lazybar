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
class CocktailRecipe < ActiveRecord::Base
  ## cocktail_recipe_parts association
  alias_attribute :parts, :cocktail_recipe_parts
  has_many :cocktail_recipe_parts, dependent: :destroy
  accepts_nested_attributes_for :cocktail_recipe_parts, reject_if: :all_blank, allow_destroy: true

  ## associations
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

  ## methods

  def cost
    sum = 0
    cocktail_recipe_parts.each do |part|
      sum += (part.ingredient.price_per_cl / 10) * part.amount
    end
    sprintf('%.3g', sum).to_f # rubocop:disable Style/FormatString
  end

  # Increase cost by a profit margin
  def selling_price
    sprintf('%.3g', cost * 1.03).to_f # rubocop:disable Style/FormatString
  end

  def likes
    user_cocktail_likes.count
  end
end
