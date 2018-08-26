# frozen_string_literal: true

class CreateIngredientCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :ingredient_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
