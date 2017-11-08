require 'rails_helper'

RSpec.describe UserCocktailLike, type: :model do
  subject do
    create(:user_cocktail_like)
  end

  it 'is valid with valid content' do
    expect(subject).to be_valid
  end

  it 'gets deleted when cocktail is deleted' do
    subject.cocktail_recipe.destroy
    expect(UserCocktailLike.all).to be_empty
  end

  it 'gets deleted when user is deleted' do
    subject.user.destroy
    expect(UserCocktailLike.all).to be_empty
  end
end
