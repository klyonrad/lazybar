# frozen_string_literal: true

# Class for Simple Users
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :trackable, and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :timeoutable

  has_many :user_cocktail_likes, dependent: :destroy
  has_many :cocktail_recipes, through: :user_cocktail_likes
  alias_attribute :cocktail_likes, :user_cocktail_likes
  alias_attribute :liked_cocktails, :cocktail_recipes

  def like_cocktail(cocktail)
    cocktail_likes.create(cocktail_recipe: cocktail)
  end

  def unlike_cocktail(cocktail)
    cocktail_likes.find_by(cocktail_recipe: cocktail).destroy
  end

  def likes_cocktail?(cocktail)
    cocktail_likes.any? { |like| like.cocktail_recipe == cocktail }
  end
end
