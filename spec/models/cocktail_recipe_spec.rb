# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CocktailRecipe do
  subject(:cocktail_recipe) { create :cocktail_recipe }

  describe 'validations' do
    it { is_expected.to be_valid }

    it 'is not valid without a name' do
      cocktail_recipe.name = nil
      expect(cocktail_recipe).not_to be_valid
    end

    it 'is not valid without any ingredients' do
      cocktail_recipe.parts = []
      expect(cocktail_recipe).not_to be_valid
    end

    it 'is not valid with only one ingredient' do
      cocktail_recipe.parts.first.destroy
      cocktail_recipe.reload
      expect(cocktail_recipe).not_to be_valid
    end
  end

  describe 'defaults' do
    it 'has no description by default' do
      expect(cocktail_recipe.description).to be_nil
    end
  end

  # high-priority method - this *must* be correct
  describe 'cost and price calculations' do
    it 'calculates the correct cost' do
      cocktail_recipe.parts.each do |part|
        part.ingredient.price_per_cl = 0.35
        part.amount = 50
      end
      expect(cocktail_recipe.cost).to eq 3.5
    end

    it 'rounds up the cost nicely' do
      cocktail_recipe.parts.each do |part|
        part.ingredient.price_per_cl = 0.177
        part.amount = 55
      end
      expect(cocktail_recipe.cost).to eq 1.95 # instead of 1,947
    end

    it 'gives the correct selling price, nicely rounded down' do
      cocktail_recipe.parts.each do |part|
        part.ingredient.price_per_cl = 0.35
        part.amount = 50
      end
      expect(cocktail_recipe.selling_price).to eq 3.60 # cost is 3,5, selling price is 3,605
    end

    it 'gives the correct selling price, nicely rounded up' do
      cocktail_recipe.parts.each do |part|
        part.ingredient.price_per_cl = 0.355
        part.amount = 50
      end
      expect(cocktail_recipe.selling_price).to eq 3.70 # cost is 3,55. selling price is 3,6565
    end
  end

  describe '#alternatives' do
    context 'with one unstrict and one strict part' do
      subject(:cocktail_recipe) do
        firt_part = build_stubbed :cocktail_recipe_part, strict: false
        second_part = build_stubbed :cocktail_recipe_part, strict: true
      end
    end
  end

  describe 'methods about liking' do
    it 'can show the users that like it' do
      users = create_pair(:user)
      users.each { |usr| usr.like_cocktail(cocktail_recipe) }
      cocktail_recipe.liking_users.each_with_index { |liking_user, i| expect(liking_user).to eq users[i] }
    end

    context 'when many users have liked cocktails' do
      let(:users) { create_list(:user, 3) }
      let(:cocktails) { create_list(:cocktail_recipe, 3) }

      before do
        users.each { |usr| usr.like_cocktail(cocktails[1]) }
        users[0..1].each { |usr| usr.like_cocktail(cocktails[0]) }
        # cocktail[2] is not liked
      end

      it 'says the amount of likes' do
        expect(cocktails[0].likes).to eq 2
        expect(cocktails[1].likes).to eq 3
        expect(cocktails[2].likes).to eq 0
      end

      describe 'listing liked cocktails that are liked' do
        subject(:liked_cocktails) { described_class.liked }

        it { is_expected.to have(2).items }
        it { is_expected.to include(cocktails[0]) }
        it { is_expected.to include(cocktails[1]) }
        it { is_expected.not_to include(cocktails[2]) }
      end

      describe 'listing liked cocktails, ordered by popularity' do
        subject(:liked_cocktails) { described_class.liked_sorted }

        it 'shows cocktail with 3 likes first' do
          expect(liked_cocktails.first).to eq cocktails[1]
        end

        it 'shows cocktail with 2 like second' do
          expect(liked_cocktails.second).to eq cocktails[0]
        end

        it { is_expected.not_to include(cocktails[2]) }
      end
    end
  end
end
