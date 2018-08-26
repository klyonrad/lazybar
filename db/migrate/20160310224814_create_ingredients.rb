# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[4.2]
  def change
    create_table :ingredients do |t|
      t.references :ingredient_category, index: true, foreign_key: true
      t.string :name, null: false
      t.decimal :price_per_cl, precision: 14, scale: 4, null: false
      t.boolean :available, default: true, null: false
      t.string :comment

      t.timestamps null: false
    end
    add_index :ingredients, :name, unique: true # https://robots.thoughtbot.com/the-perils-of-uniqueness-validations
  end
end
