# frozen_string_literal: true

# Model that connects users with cocktails that they can like
class UserCocktailLike < ApplicationRecord
  belongs_to :user
  belongs_to :cocktail_recipe

  validates :cocktail_recipe, uniqueness: { scope: :user }
end
