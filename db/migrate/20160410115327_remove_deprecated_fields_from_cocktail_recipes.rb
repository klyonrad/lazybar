# frozen_string_literal: true

class RemoveDeprecatedFieldsFromCocktailRecipes < ActiveRecord::Migration
  def change
    remove_column :cocktail_recipes, :cost, :decimal
    remove_column :cocktail_recipes, :selling_price, :decimal
  end
end
