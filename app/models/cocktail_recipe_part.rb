# frozen_string_literal: true

# This model represents an individual part of a Cocktail Recipe
#   - cocktail_recipe_id
#   - ingredient_category_id
#   - ingredient_id (the default ingredient)
#   - amount: the amount in millilitre
#   - strict: boolean that sets if we want the specific brand / ingredient and not allow others
class CocktailRecipePart < ApplicationRecord
  belongs_to :cocktail_recipe, inverse_of: :cocktail_recipe_parts
  belongs_to :ingredient
  has_one :ingredient_category, through: :ingredient

  validates :amount, numericality: { greater_than: 0 }, presence: true

  delegate :name, to: :ingredient, prefix: true

  def category_name
    ingredient_category.name
  end

  def cost
    ingredient.price_per_cl / 10 * amount
  end

  def alternatives
    if strict?
      readonly!
      return [self]
    end

    ingredient_category.available_ingredients.map do |possible_ingredient|
      replace_ingredient_with(possible_ingredient)
    end
  end

  private

  def replace_ingredient_with(replacement)
    self_copy = dup
    self_copy.ingredient = replacement
    self_copy
  end
end
