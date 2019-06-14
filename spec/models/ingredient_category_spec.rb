# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientCategory do
  subject { build_stubbed :ingredient_category }

  context 'with valid attributes' do
    subject { build_stubbed :ingredient_category }

    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
