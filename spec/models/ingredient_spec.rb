# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient do
  subject(:ingredient) { build(:ingredient) }

  context 'with valid attributes' do
    subject { build_stubbed :ingredient }

    it { is_expected.to be_valid }
  end

  describe 'presence validations' do
    context 'without a name' do
      subject { build_stubbed :ingredient, name: nil }

      it { is_expected.not_to be_valid }
    end

    context 'without a category' do
      subject { build_stubbed :ingredient, ingredient_category: nil }

      it { is_expected.not_to be_valid }
    end

    context 'without a price' do
      subject { build_stubbed :ingredient, price_per_cl: nil }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'other validations' do
    describe 'price validations' do
      context 'with negative price' do
        subject { build_stubbed :ingredient, price_per_cl: -0.01 }

        it { is_expected.not_to be_valid }
      end

      context 'with price of zero' do
        subject { build_stubbed :ingredient, price_per_cl: 0 }

        it { is_expected.to be_valid }
      end
    end

    it 'is valid with different names' do
      ingredient.save
      ingredients = build_list(:ingredient, 3)

      expect(ingredients).to all(be_valid)
    end

    it 'is not valid with same name' do
      ingredient.name = 'Hipster Gin'
      ingredient.save
      not_unique = build(:ingredient, name: 'Hipster Gin')
      expect(not_unique).not_to be_valid
    end
  end

  describe 'defaults' do
    it 'is available by default' do
      expect(ingredient.available).to be_truthy
    end

    it 'has no comment by default' do
      expect(ingredient.comment).to be_nil
    end
  end
end
