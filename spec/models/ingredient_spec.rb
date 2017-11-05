require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject do
    build(:ingredient)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  describe 'presence validations' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a category' do
      subject.ingredient_category = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a price' do
      subject.price_per_cl = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'other validations' do
    it 'is valid with different names' do
      subject.save
      ingredients = build_list(:ingredient, 3)
      ingredients.each { |ingr| expect(ingr).to be_valid }
    end

    it 'is not valid with same name' do
      subject.name = 'Hipster Gin'
      subject.save
      not_unique = build(:ingredient, name: 'Hipster Gin')
      expect(not_unique).not_to be_valid
    end
  end

  describe 'defaults' do
    it 'is available by default' do
      expect(subject.available).to be_truthy
    end

    it 'has no comment by default' do
      expect(subject.comment).to be_nil
    end
  end
end
