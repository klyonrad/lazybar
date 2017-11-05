require 'rails_helper'

RSpec.describe CocktailRecipe, type: :model do
  subject do
    create(:cocktail_recipe)
  end
  it 'is valid with valid content' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without any ingredients' do
      subject.parts = []
      expect(subject).not_to be_valid
    end

    it 'is not valid with only one ingredient' do
      subject.parts.first.destroy
      subject.reload
      expect(subject).not_to be_valid
    end
  end

  describe 'defaults' do
    it 'has no description by default' do
      expect(subject.description).to be_nil
    end
  end

  # high-priority method - this *must* be correct
  describe 'cost and price calculations' do
    it 'calculates the correct cost' do
      subject.parts.each do |part|
        part.ingredient.price_per_cl = 0.35
        part.amount = 50
      end
      expect(subject.cost).to eq 3.5
    end

    it 'rounds up the cost nicely' do
      subject.parts.each do |part|
        part.ingredient.price_per_cl = 0.177
        part.amount = 55
      end
      expect(subject.cost).to eq 1.95 # instead of 1,947
    end

    it 'gives the correct selling price, nicely rounded' do
      subject.parts.each do |part|
        part.ingredient.price_per_cl = 0.35
        part.amount = 50
      end
      expect(subject.selling_price).to eq 3.60 # cost is 3,5, selling price is 3,605
    end
  end
end
