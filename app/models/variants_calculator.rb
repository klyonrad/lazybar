# frozen_string_literal: true

class VariantsCalculator
  def initialize(parts)
    @parts = parts
  end

  # @return [Array] Cartesian product of the alternatives
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

  private

  attr_reader :parts

  def unstrict_recipe_parts
    parts.reject(&:strict?)
  end

  def strict_recipe_parts
    parts.select(&:strict?)
  end
end
