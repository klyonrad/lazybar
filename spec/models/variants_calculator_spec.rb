# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantsCalculator do
  describe '#cocktail_combinations' do
    let(:calculator) { described_class.new(given_parts) }

    let(:given_parts) do
      [
        instance_double('CocktailRecipePart',
                        strict?: true, strict: true, amount: 20,
                        ingredient: lime_juice,
                        ingredient_category: lime_juice.category,
                        ingredient_alternatives: [lime_juice]),
        instance_double('CocktailRecipePart',
                        strict?: false, strict: false, amount: 30,
                        ingredient: monkey_gin,
                        ingredient_category: monkey_gin.category,
                        ingredient_alternatives: [monkey_gin])
      ]
    end
    let(:lime_juice) { build_stubbed(:ingredient, name: 'Lime Juice') }
    let(:monkey_gin) { build_stubbed(:ingredient, name: 'Monkey 47 Gin') }

    it 'returns combinations in correct order' do
      expect(calculator.ingredient_combinations).to eq([[monkey_gin, lime_juice]])
    end

    it 'returns collection of recipes' do
      expect(calculator.cocktail_combinations.map(&:name)).to match_array(['Monkey 47 Gin, Lime Juice'])
    end
  end
end
