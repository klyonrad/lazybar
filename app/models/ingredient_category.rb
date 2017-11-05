# This model represents the category of ingredients. Every ingredient needs to have one
class IngredientCategory < ActiveRecord::Base
  has_many :ingredients

  validates :name, presence: true, uniqueness: true
end
