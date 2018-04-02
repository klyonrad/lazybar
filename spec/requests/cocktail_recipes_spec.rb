# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CocktailRecipes', type: :request do
  describe 'GET /cocktail_recipes' do
    it 'works! (now write some real specs)' do
      get cocktail_recipes_path
      expect(response).to have_http_status(200)
    end
  end
end
