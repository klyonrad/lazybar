# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantsCalculator do
  describe '#cocktail_combinations' do
    let(:calculator) { described_class.new(given_parts) }

    let(:given_parts) do
      [
        instance_double('CocktailRecipePart',
                        strict?: true, ingredient: lime_juice, ingredient_category: lime_juice.category),
        instance_double('CocktailRecipePart',
                        strict?: false, ingredient: monkey_gin, ingredient_category: monkey_gin.category)
      ]
    end
    let(:lime_juice) { build_stubbed(:ingredient, name: 'Lime Juice') }
    let(:monkey_gin) { build_stubbed(:ingredient, name: 'Monkey 47 Gin') }

    it 'returns lime juice' do
      expect(calculator.strict_ingredients).to eq([lime_juice])
    end
  end
end
