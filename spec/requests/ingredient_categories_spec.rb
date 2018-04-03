# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'IngredientCategories', type: :request do
  let(:ingredient_category) { create :ingredient_category }

  describe 'GET Requests' do
    describe '#index' do
      it 'shows ingredient categories list with correct content' do
        ingredient_category
        get ingredient_categories_path
        expect(response).to be_successful
        expect(response.body).to include ingredient_category.name
      end

      it 'shows ingredient categories list with empty content' do
        get ingredient_categories_path
        expect(response).to be_successful
        expect(response.body).not_to include ingredient_category.name
      end
    end

    describe '#show' do
      it 'successfully shows the ingredient category' do
        get ingredient_category_path(ingredient_category)
        expect(response).to be_successful
        expect(response.body).to include ingredient_category.name
      end
    end
  end
end
