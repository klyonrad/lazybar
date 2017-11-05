require 'rails_helper'

RSpec.describe Admin, type: :model do
  subject do
    create(:admin)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).not_to be_valid
  end
end
