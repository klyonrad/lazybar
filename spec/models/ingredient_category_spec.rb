# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientCategory do
  subject { build_stubbed :ingredient_category }

  context 'with valid attributes' do
    subject { build_stubbed :ingredient_category }

    it { is_expected.to be_valid }
  end

  describe 'presence validations' do
    context 'without a name' do
      subject { build_stubbed :ingredient_category, name: nil }

      it { is_expected.not_to be_valid }
    end
  end
end
