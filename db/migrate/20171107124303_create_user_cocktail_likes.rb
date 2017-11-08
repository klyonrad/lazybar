class CreateUserCocktailLikes < ActiveRecord::Migration[5.1]
  def up
    create_table :user_cocktail_likes do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :cocktail_recipe, index: true, foreign_key: true, null: false
      t.timestamps
    end
  end

  def down
    drop_table :user_cocktail_likes
  end
end
