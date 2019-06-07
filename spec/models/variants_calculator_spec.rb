# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VariantsCalculator do
  let(:calculator) { described_class.new(given_parts) }

  let(:given_parts) do
    [
      instance_double('CocktailRecipePart',
                      strict?: true,
                      alternatives: [build_stubbed(:cocktail_recipe_part, ingredient: lime_juice)]),
      instance_double('CocktailRecipePart',
                      strict?: false,
                      alternatives: [build_stubbed(:cocktail_recipe_part, ingredient: monkey_gin)])
    ]
  end
  let(:lime_juice) { build_stubbed(:ingredient, name: 'Lime Juice') }
  let(:monkey_gin) { build_stubbed(:ingredient, name: 'Monkey 47 Gin', ingredient_category: category) }
  let(:bombay_gin) { build_stubbed(:ingredient, name: 'Bombay Saphire', ingredient_category: category) }
  let(:category) { build :ingredient_category }

  describe '#parts_combinations' do
    it 'returns an array of arrays' do
      expect(calculator.part_combinations).to all(be_a Array)
    end

    it 'returns cocktail recipe part arrays' do
      calculator.part_combinations.each do |combination| # rubocop:disable RSpec/IteratedExpectation
        expect(combination).to all(be_a CocktailRecipePart)
      end
    end

    context 'with one strict and one part with two alternatives' do
      let(:given_parts) do
        [
          instance_double('CocktailRecipePart',
                          strict?: true,
                          alternatives: [build_stubbed(:cocktail_recipe_part, ingredient: lime_juice)]),
          instance_double('CocktailRecipePart',
                          strict?: false,
                          alternatives: [build_stubbed(:cocktail_recipe_part, ingredient: monkey_gin),
                                         build_stubbed(:cocktail_recipe_part, ingredient: bombay_gin)])
        ]
      end

      it('returns two combinations') { expect(calculator.part_combinations.length).to eq(2) }

      it 'returns combinations with two parts' do
        expect(calculator.part_combinations).to all(have(2).items)
      end

      it 'puts the alternatives of strict recipe part in the front' do
        first_combination = calculator.part_combinations.first

        expect(first_combination.first.ingredient.category).to eq(category)
        expect(first_combination.last.ingredient).to eq(lime_juice)
      end
    end

    context 'with one strict part and two flexible with two alternatives' do
      let(:given_parts) do
        [instance_double('CocktailRecipePart', strict?: true, alternatives: ['Campari']),
         instance_double('CocktailRecipePart',
                         strict?: false, alternatives: ['Martini Rosso', 'Belsazar Rose']),
         instance_double('CocktailRecipePart', strict?: false, alternatives: %w[Bombay Tanqueray])]
      end

      it('returns four combinations') { expect(calculator.part_combinations.length).to eq(4) }

      it 'combines the alternatives to cartesian product' do
        expect(calculator.part_combinations)
          .to(match_array([
                            ['Belsazar Rose', 'Bombay', 'Campari'],
                            ['Belsazar Rose', 'Tanqueray', 'Campari'],
                            ['Martini Rosso', 'Bombay', 'Campari'],
                            ['Martini Rosso', 'Tanqueray', 'Campari']
                          ]))
      end
    end
  end
end
