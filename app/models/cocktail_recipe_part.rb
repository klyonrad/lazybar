# frozen_string_literal: true

# This model represents an individual part of a Cocktail Recipe
#   - cocktail_recipe_id
#   - ingredient_category_id
#   - ingredient_id (the default ingredient)
#   - amount: the amount in millilitre
#   - strict: boolean that sets if we want the specific brand / ingredient and not allow others
class CocktailRecipePart < ApplicationRecord
  belongs_to :cocktail_recipe, inverse_of: :cocktail_recipe_parts, optional: false
  belongs_to :ingredient_category
  belongs_to :ingredient

  validates :amount, numericality: { greater_than: 0 }, presence: true
  validate :ingredient_needs_to_match_category

  def cost
    ingredient.price_per_cl / 10 * amount
  end

  def ingredient_alternatives
    return Array.new(1, ingredient) if strict?

    ingredient_category.ingredients.to_a
  end

  private

  def ingredient_needs_to_match_category
    return if ingredient&.ingredient_category == ingredient_category

    errors.add(:ingredient, "Default Ingredient is not category #{ingredient_category&.name}")
  end
end
