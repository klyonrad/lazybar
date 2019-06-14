# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ingredient do
  subject(:ingredient) { build(:ingredient) }

  context 'with valid attributes' do
    subject { build_stubbed :ingredient }

    it { is_expected.to be_valid }
  end

  describe 'assocations' do
    it { is_expected.to belong_to(:ingredient_category) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price_per_cl) }
    it { is_expected.to validate_numericality_of(:price_per_cl).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_uniqueness_of(:name) }
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
