# Model that connects users with cocktails that they can like
class UserCocktailLike < ApplicationRecord
  belongs_to :user
  belongs_to :cocktail_recipe

  validates :cocktail_recipe, presence: true, uniqueness: { scope: :user }
  validates :user, presence: true
end
