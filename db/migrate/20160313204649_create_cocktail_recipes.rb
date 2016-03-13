class CreateCocktailRecipes < ActiveRecord::Migration
  def change
    create_table :cocktail_recipes do |t|
      t.string :name
      t.decimal :cost, precision: 20, scale: 4
      t.decimal :selling_price, precision: 20, scale: 4
      t.string :description

      t.timestamps null: false
    end
    add_index :cocktail_recipes, :name, unique: true
  end
end
