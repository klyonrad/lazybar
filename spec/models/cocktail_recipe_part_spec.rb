# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CocktailRecipePart do
  subject(:cocktail_recipe_part) { create(:cocktail_recipe_part) }

  it 'is valid with valid content' do
    expect(cocktail_recipe_part).to be_valid
  end

  describe 'validations' do
    context 'without recipe association' do
      before { cocktail_recipe_part.cocktail_recipe = nil }

      it { is_expected.not_to be_valid }
    end

    context 'without a ingredient_category' do
      before { cocktail_recipe_part.ingredient_category = nil }

      it { is_expected.not_to be_valid }
    end

    context 'without an ingredient' do
      before { cocktail_recipe_part.ingredient = nil }

      it { is_expected.not_to be_valid }
    end

    context 'without an amount' do
      before { cocktail_recipe_part.amount = nil }

      it { is_expected.not_to be_valid }
    end

    context 'with negative amount' do
      before { cocktail_recipe_part.amount = -30 }

      it { is_expected.not_to be_valid }
    end

    context 'with zero amount' do
      before { cocktail_recipe_part.amount = 0 }

      it { is_expected.not_to be_valid }
    end

    context 'when ingredient and category mismatch' do
      before { cocktail_recipe_part.ingredient_category = different_category }

      let(:different_category) { create :ingredient_category }

      it { is_expected.not_to be_valid }
    end
  end

  describe '#alternatives' do
    let(:alternative_ingredients) { recipe_part.alternatives.map(&:ingredient) } # easier "test subject"

    let!(:ingredient_category_for_part) { create :ingredient_category }
    let(:ingredient_for_part) { create :ingredient, category: ingredient_category_for_part }

    context 'when marked as strict' do
      context 'when other available ingredients of the category exist' do
        subject(:recipe_part) { create(:cocktail_recipe_part, :strict, ingredient: ingredient_for_part) }

        let(:ingredient_for_part) { possible_ingredients.first }
        let!(:possible_ingredients) { create_list(:ingredient, 3, category: ingredient_category_for_part) }

        it 'the other angredients and itself in a similar way' do
          expect(alternative_ingredients).not_to match_array(possible_ingredients)
        end
      end
    end

    context 'when not marked as strict' do
      context 'when other available ingredients of the category exist' do
        subject(:recipe_part) { create(:cocktail_recipe_part, :flexible, ingredient: ingredient_for_part) }

        let(:ingredient_for_part) { possible_ingredients.first }
        let!(:possible_ingredients) { create_list(:ingredient, 3, category: ingredient_category_for_part) }

        it 'returns all those ingredients' do
          expect(alternative_ingredients).to match_array(possible_ingredients)
        end
      end

      context 'when no other ingredients of the category exist' do
        subject(:recipe_part) { create(:cocktail_recipe_part, :flexible, ingredient: ingredient_for_part) }

        it 'returns only one item' do
          expect(recipe_part.alternatives).to have_exactly(1).items
        end
        it 'returns itself with the same ingredient' do
          expect(alternative_ingredients).to eq([recipe_part.ingredient])
        end
      end

      context 'when other ingredient exists but it is not available' do
        subject(:recipe_part) { create(:cocktail_recipe_part, :flexible, ingredient: ingredient_for_part) }

        before { create :ingredient, :unavailable, ingredient_category: ingredient_category_for_part }

        it 'returns itself with the same ingredient' do
          expect(alternative_ingredients).to match_array([recipe_part.ingredient])
        end
      end

      context 'when one available and one unavailable ingredient exist' do
        subject(:recipe_part) { create(:cocktail_recipe_part, :flexible, ingredient: ingredient_for_part) }

        let!(:unavailable_ingredient) { create :ingredient, :unavailable, category: ingredient_category_for_part }
        let!(:other_ingredient) { create :ingredient, category: ingredient_category_for_part }

        it 'does not return the unavailable ingredient' do
          expect(alternative_ingredients).not_to include(unavailable_ingredient)
        end
        it 'returns itself and the available ingredient' do
          expect(alternative_ingredients).to match_array([other_ingredient, recipe_part.ingredient])
        end
      end
    end
  end
end
