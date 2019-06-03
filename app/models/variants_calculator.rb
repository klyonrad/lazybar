# frozen_string_literal: true

class VariantsCalculator
  def initialize(parts)
    @parts = parts
  end

  def cocktail_recipe_parts
    @parts
  end

  # @return [Array] Collection of (unpersisted) CocktailRecipe objects
  def cocktail_combinations
    part_combinations.map do |variant|
      CocktailRecipe.new name: variant.map(&:ingredient).map(&:name).join(', '), parts: variant
    end
  end

  def combinations_and_price
    part_combinations.each do |variant|
      in_memory_recipe = CocktailRecipe.new
      in_memory_recipe.parts = variant
      puts "#{in_memory_recipe.selling_price}€ for #{variant.map(&:ingredient).map(&:name).join(', ')}"
    end
  end

  def part_combinations
    arrays = []
    unstrict_recipe_parts.each do |recipe_part|
      arrays << recipe_part.alternatives
    end
    strict_recipe_parts.each do |recipe_part|
      arrays << recipe_part.alternatives
    end

    arrays.first.product(*arrays.drop(1))
  end

  def relevant_categories
    unstrict_recipe_parts.map(&:ingredient_category)
  end

  def strict_ingredients
    cocktail_recipe_parts
      .select(&:strict?)
      .map(&:ingredient)
  end

  def unstrict_recipe_parts
    cocktail_recipe_parts.reject(&:strict?)
  end

  private

  def strict_recipe_parts
    cocktail_recipe_parts.select(&:strict?)
  end
end
