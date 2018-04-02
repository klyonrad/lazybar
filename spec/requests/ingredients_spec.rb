# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ingredients', type: :request do
  let(:ingredient) { create :ingredient }

  describe 'GET Requests' do
    describe '#index' do
      it 'shows ingredient list with correct content' do
        ingredient
        get ingredients_path
        expect(response).to be_successful
        expect(response.body).to include ingredient.name
      end

      it 'shows ingredient list with empty content' do
        get ingredients_path
        expect(response).to be_successful
        expect(response.body).not_to include ingredient.name
      end
    end

    describe '#show' do
      it 'successfully shows the ingredient' do
        get ingredient_path(ingredient)
        expect(response).to be_successful
        expect(response.body).to include ingredient.name
        expect(response.body).to include ingredient.ingredient_category.name
        expect(response.body).to include ingredient.price_per_cl.to_s
      end
    end
  end
end
