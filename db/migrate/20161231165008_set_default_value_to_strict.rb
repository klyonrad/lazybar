class SetDefaultValueToStrict < ActiveRecord::Migration[5.0]
  def change
    change_column :cocktail_recipe_parts, :strict, :boolean, default: true
  end
end
