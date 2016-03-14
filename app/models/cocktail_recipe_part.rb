class CocktailRecipePart < ActiveRecord::Base
  belongs_to :cocktail_recipe
  belongs_to :ingredient_category
  belongs_to :ingredient # The Default ingredient

  validates :cocktail_recipe, presence: true
  validates :ingredient_category, presence: true
end
