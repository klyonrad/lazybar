# frozen_string_literal: true

class VariantsCalculator
  def initialize(parts)
    @parts = parts
  end

  # @return [Array] Cartesian product of the alternatives
  def part_combinations
    all_alternatives.first.product(*all_alternatives.drop(1))
  end

  private

  attr_reader :parts

  def all_alternatives
    unstrict_recipe_parts.map(&:alternatives) + strict_recipe_parts.map(&:alternatives)
  end

  def unstrict_recipe_parts
    parts.reject(&:strict?)
  end

  def strict_recipe_parts
    parts.select(&:strict?)
  end
end
