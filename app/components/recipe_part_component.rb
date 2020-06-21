# frozen_string_literal: true

class RecipePartComponent < ViewComponent::Base
  def initialize(recipe_part:)
    @recipe_part = recipe_part
  end

  def simplified_amount
    sprintf('%.2g', @recipe_part.amount / 10)
  end

  def ingredient
    return @recipe_part.ingredient_name if @recipe_part.strict

    @recipe_part.category_name
  end
end
