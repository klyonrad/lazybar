class CocktailRecipe < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
