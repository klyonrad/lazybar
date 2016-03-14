class CocktailRecipe < ActiveRecord::Base
  has_many :cocktail_recipe_parts
  accepts_nested_attributes_for :cocktail_recipe_parts
  validates :name, presence: true, uniqueness: true
end
