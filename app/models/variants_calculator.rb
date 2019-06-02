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
    part_ingrediant_variants.map do |variant|
      CocktailRecipe.new name: variant.map(&:ingredient).map(&:name).join(', '), parts: variant
    end
  end

  def combinations_and_price
    part_ingrediant_variants.each do |variant|
      in_memory_recipe = CocktailRecipe.new
      in_memory_recipe.parts = variant
      puts "#{in_memory_recipe.selling_price}€ for #{variant.map(&:ingredient).map(&:name).join(', ')}"
    end
  end

  def part_ingrediant_variants
    parts_combinations = []

    ingredient_combinations.each do |ingredient_combination|
      new_parts = []
      ingredient_combination.each do |ingredient|
        part_to_replace = cocktail_recipe_parts.select { |part| part.ingredient_category == ingredient.category }.first
        new_parts << CocktailRecipePart.new(amount: part_to_replace.amount,
                                            strict: part_to_replace.strict,
                                            ingredient: ingredient,
                                            ingredient_category: ingredient.category)
      end
      parts_combinations << new_parts
    end
    parts_combinations
  end

  def ingredient_combinations
    arrays = []
    relevant_categories.each do |category|
      arrays << category.ingredients.to_a
    end
    strict_ingredients.each do |ingredient|
      arrays << [ingredient]
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
end
