# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'can like a cocktail' do
    cocktail = create :cocktail_recipe
    subject.like_cocktail cocktail
    expect(UserCocktailLike.first.cocktail_recipe).to eq cocktail
  end

  it 'can unlike a cocktail' do
    cocktail = create :cocktail_recipe
    subject.like_cocktail cocktail
    subject.unlike_cocktail cocktail
    expect(UserCocktailLike.all).to be_empty
  end

  it 'can like a cocktail only one time' do
    cocktail = create :cocktail_recipe
    2.times { subject.like_cocktail cocktail }
    expect(UserCocktailLike.count).to eq 1
  end

  it 'can list liked cocktails' do
    cocktails = create_list(:cocktail_recipe, 3)
    cocktails.each { |cktl| subject.like_cocktail cktl }
    liked_cocktails = subject.liked_cocktails
    expect(liked_cocktails[0]).to eq(cocktails[0])
  end

  it 'shows that user likes a specific cocktail' do
    cocktail = create :cocktail_recipe
    subject.like_cocktail cocktail
    expect(subject.likes_cocktail?(cocktail)).to be_truthy
  end

  it 'shows that user does not like a specific cocktail' do
    cocktail = create :cocktail_recipe
    expect(subject.likes_cocktail?(cocktail)).to be_falsey
  end
end
