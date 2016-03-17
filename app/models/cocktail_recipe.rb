class CocktailRecipe < ActiveRecord::Base
  has_many :cocktail_recipe_parts, inverse_of: :cocktail_recipe
  accepts_nested_attributes_for :cocktail_recipe_parts, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true, uniqueness: true
end
