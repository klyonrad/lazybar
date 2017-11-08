require 'rails_helper'

RSpec.describe CocktailRecipe, type: :model do
  subject do
    create(:cocktail_recipe)
  end

  it 'is valid with valid content' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without any ingredients' do
      subject.parts = []
      expect(subject).not_to be_valid
    end

    it 'is not valid with only one ingredient' do
      subject.parts.first.destroy
      subject.reload
      expect(subject).not_to be_valid
    end
  end

  describe 'defaults' do
    it 'has no description by default' do
      expect(subject.description).to be_nil
    end
  end

  # high-priority method - this *must* be correct
  describe 'cost and price calculations' do
    it 'calculates the correct cost' do
      subject.parts.each do |part|
        part.ingredient.price_per_cl = 0.35
        part.amount = 50
      end
      expect(subject.cost).to eq 3.5
    end

    it 'rounds up the cost nicely' do
      subject.parts.each do |part|
        part.ingredient.price_per_cl = 0.177
        part.amount = 55
      end
      expect(subject.cost).to eq 1.95 # instead of 1,947
    end

    it 'gives the correct selling price, nicely rounded' do
      subject.parts.each do |part|
        part.ingredient.price_per_cl = 0.35
        part.amount = 50
      end
      expect(subject.selling_price).to eq 3.60 # cost is 3,5, selling price is 3,605
    end
  end

  describe 'methods about liking' do
    it 'can show the users that like it' do
      users = create_pair(:user)
      users.each { |usr| usr.like_cocktail(subject) }
      subject.liking_users.each_with_index { |liking_user, i| expect(liking_user).to eq users[i] }
    end

    context 'many users have liked cocktails' do
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

      it 'can list cocktails that are liked' do
        liked_cocktails = CocktailRecipe.liked
        expect(liked_cocktails.size).to eq 2
        expect(liked_cocktails.include?(cocktails[0])).to be_truthy
        expect(liked_cocktails.include?(cocktails[1])).to be_truthy
        expect(liked_cocktails.include?(cocktails[2])).to be_falsey
      end

      it 'can list liked cocktails, ordered by popularity' do
        liked_cocktails = CocktailRecipe.liked_sorted
        expect(liked_cocktails.first).to eq cocktails[1]
        expect(liked_cocktails.second).to eq cocktails[0]
        expect(liked_cocktails.include?(cocktails[2])).to be_falsey
      end
    end
  end
end
