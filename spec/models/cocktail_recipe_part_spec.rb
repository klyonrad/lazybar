# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CocktailRecipePart, type: :model do
  subject do
    create(:cocktail_recipe_part)
  end

  it 'is valid with valid content' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    it 'is not valid without recipe association' do
      subject.cocktail_recipe = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a ingredient_category' do
      subject.ingredient_category = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without an ingredient' do
      subject.ingredient = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without an amount' do
      subject.amount = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with negative amount' do
      subject.amount = -30
      expect(subject).not_to be_valid
    end

    it 'is not valid with zero amount' do
      subject.amount = 0
      expect(subject).not_to be_valid
    end

    it 'is not valid when ingredient and category mismatch' do
      subject.ingredient_category = create :ingredient_category
      expect(subject).not_to be_valid
    end
  end
end
