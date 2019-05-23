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
end
