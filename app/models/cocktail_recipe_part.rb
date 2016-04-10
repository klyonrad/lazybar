class CocktailRecipePart < ActiveRecord::Base
  belongs_to :cocktail_recipe, inverse_of: :cocktail_recipe_parts
  belongs_to :ingredient_category
  belongs_to :ingredient # The Default ingredient

  validates :cocktail_recipe, presence: true
  validates :ingredient_category, presence: true
  validates :ingredient, presence: true
  validate :ingredient_needs_to_match_category

  private

  def ingredient_needs_to_match_category
    if ingredient.ingredient_category != ingredient_category
      errors.add(:ingredient, "Default Ingredient is not category #{ingredient_category}")
    end
  end
end
