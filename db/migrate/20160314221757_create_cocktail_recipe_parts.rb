# frozen_string_literal: true

class CreateCocktailRecipeParts < ActiveRecord::Migration[4.2]
  def change
    create_table :cocktail_recipe_parts do |t|
      t.references :cocktail_recipe, index: true, foreign_key: true, null: false
      t.references :ingredient_category, index: true, foreign_key: true, null: false
      t.references :ingredient, index: true, foreign_key: true, null: true
      t.decimal :amount, precision: 15, scale: 9
      t.boolean :strict

      t.timestamps null: false
    end
  end
end
