# frozen_string_literal: true

class CocktailRecipeComponent < ViewComponent::Base
  def initialize(recipe:, admin_signed_in:)
    @cocktail_recipe = recipe
    @admin_signed_in = admin_signed_in
  end

  def name
    @cocktail_recipe.name
  end

  def price
    number_to_currency(@cocktail_recipe.selling_price, unit: '€')
  end

  def edit_button
    EditCocktailRecipeButtonComponent.new(record: @cocktail_recipe, admin: @admin_signed_in)
  end
end
