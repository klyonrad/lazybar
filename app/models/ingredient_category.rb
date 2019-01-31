# frozen_string_literal: true

# This model represents the category of ingredients. Every ingredient needs to have one
class IngredientCategory < ApplicationRecord
  has_many :ingredients, dependent: :restrict_with_exception

  validates :name, presence: true, uniqueness: true
end
