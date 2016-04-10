# This Model represents a Cocktail Recipe
# name
# cocktail_recipe_parts
class CocktailRecipe < ActiveRecord::Base
  has_many :cocktail_recipe_parts, inverse_of: :cocktail_recipe
  accepts_nested_attributes_for :cocktail_recipe_parts, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true, uniqueness: true

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
end
