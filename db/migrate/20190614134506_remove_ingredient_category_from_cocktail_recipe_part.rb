# frozen_string_literal: true

class RemoveIngredientCategoryFromCocktailRecipePart < ActiveRecord::Migration[5.2]
  def change
    remove_column :cocktail_recipe_parts, :ingredient_category_id, :integer
  end
end
