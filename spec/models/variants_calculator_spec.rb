# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantsCalculator do
  describe '#cocktail_combinations' do
    let(:calculator) { described_class.new(given_parts) }

    let(:given_parts) do
      [
        instance_double('CocktailRecipePart',
                        strict?: true,
                        alternatives: [build_stubbed(:cocktail_recipe_part,
                                                     ingredient: lime_juice)]),
        instance_double('CocktailRecipePart',
                        strict?: false,
                        alternatives: [build_stubbed(:cocktail_recipe_part,
                                                     ingredient: monkey_gin)]),
      ]
    end
    let(:lime_juice) { build_stubbed(:ingredient, name: 'Lime Juice') }
    let(:monkey_gin) { build_stubbed(:ingredient, name: 'Monkey 47 Gin') }

    it 'returns collection of recipes' do
      expect(calculator.cocktail_combinations.map(&:name)).to match_array(['Monkey 47 Gin, Lime Juice'])
    end
  end
end
