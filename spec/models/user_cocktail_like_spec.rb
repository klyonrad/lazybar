# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCocktailLike do
  subject(:cocktail_like_entry) { create :user_cocktail_like }

  it 'is valid with valid content' do
    expect(cocktail_like_entry).to be_valid
  end

  it 'gets deleted when cocktail is deleted' do
    cocktail_like_entry.cocktail_recipe.destroy
    expect(described_class.all).to be_empty
  end

  it 'gets deleted when user is deleted' do
    cocktail_like_entry.user.destroy
    expect(described_class.all).to be_empty
  end
end
