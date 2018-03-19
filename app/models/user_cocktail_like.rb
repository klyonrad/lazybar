# Model that connects users with cocktails that they can like
class UserCocktailLike < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :cocktail_recipe, required: true

  validates :cocktail_recipe, uniqueness: { scope: :user }
end
