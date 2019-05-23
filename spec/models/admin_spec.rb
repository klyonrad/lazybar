# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin do
  subject { create :admin }

  describe 'validations' do
    context 'with valid attributes' do
      subject { build_stubbed :admin }

      it { is_expected.to be_valid }
    end

    context 'without an email' do
      subject { build_stubbed :user, email: nil }

      it { is_expected.not_to be_valid }
    end
  end
end
