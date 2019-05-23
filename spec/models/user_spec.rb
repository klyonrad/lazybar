# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { create :user }

  describe 'validations' do
    context 'with valid attributes' do
      it { is_expected.to be_valid }
    end

    context 'without an email' do
      subject { build_stubbed :user, email: nil }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'cocktail liking feature' do
    let(:cocktail) { create :cocktail_recipe }

    it 'can like a cocktail' do
      user.like_cocktail cocktail
      expect(UserCocktailLike.first.cocktail_recipe).to eq cocktail
    end

    context 'when cocktail is already liked' do
      before do
        user.like_cocktail cocktail
      end

      it 'can unlike a cocktail' do
        user.unlike_cocktail cocktail

        expect(UserCocktailLike.all).to be_empty
      end

      it 'can like a cocktail only one time' do
        user.like_cocktail cocktail

        expect(UserCocktailLike.count).to eq 1
      end
    end

    describe '#likes_cocktail?' do
      subject { user.likes_cocktail? cocktail }

      context 'when cocktail has no like yet' do
        it 'shows that user does not like a specific cocktail' do
          expect(user).not_to be_likes_cocktail(cocktail)
        end

        it { is_expected.to be false }
      end

      context 'when cocktail is liked already' do
        before do
          user.like_cocktail cocktail
        end

        it { is_expected.to be true }
      end
    end

    it 'can list liked cocktails' do
      cocktails = create_list(:cocktail_recipe, 3)
      cocktails.each { |cktl| user.like_cocktail cktl }
      liked_cocktails = user.liked_cocktails
      expect(liked_cocktails[0]).to eq(cocktails[0])
    end
  end
end
