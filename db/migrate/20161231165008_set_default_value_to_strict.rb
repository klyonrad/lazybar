# frozen_string_literal: true

class SetDefaultValueToStrict < ActiveRecord::Migration[5.0]
  def change
    change_column :cocktail_recipe_parts, :strict, :boolean, default: true # rubocop:disable Rails/ReversibleMigration
  end
end
