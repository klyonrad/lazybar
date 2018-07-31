# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CocktailRecipes', type: :request do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:cocktail_recipe) { create :cocktail_recipe }

  describe 'GET /cocktail_recipes' do
    context 'without any login (public)' do
      context 'without any CocktailRecipe' do
        it 'works' do
          get cocktail_recipes_path
          expect(response).to have_http_status(200)
        end
      end

      context 'with one CocktailRecipe' do
        let!(:cocktail_recipe) { create :cocktail_recipe }

        it 'works and shows CocktailRecipe' do
          get cocktail_recipes_path
          expect(response).to be_successful
          expect(response.body).to include(cocktail_recipe.name)
        end

        it 'shows the ingredients of the CocktailRecipe' do
          get cocktail_recipes_path
          expect(response).to be_successful
          expect(response.body).to include(cocktail_recipe.parts.first.ingredient.name)
          expect(response.body).to include(cocktail_recipe.parts.second.ingredient.name)
        end
      end
    end

    context 'with user login' do
      # TODO: show LIKE button
    end

    context 'with admin login' do
      before { sign_in admin }

      it 'shows link to new form' do
        get cocktail_recipes_path
        expect(response).to be_successful
        expect(response.body).to include(new_cocktail_recipe_path)
      end

      it 'shows EDIT button for any existing recipe' do
        cocktail_recipe
        get cocktail_recipes_path
        expect(response).to be_successful
        expect(response.body).to include(edit_cocktail_recipe_path(cocktail_recipe))
      end

      it 'shows DELETE button for any existing recipe' do
        cocktail_recipe
        get cocktail_recipes_path
        expect(response).to be_successful
        expect(response.body).to include(cocktail_recipe_path(cocktail_recipe))
        expect(response.body).to include('Destroy')
        expect(response.body).to include('data-method="delete" href="/cocktail_recipes/')
      end
    end
  end

  describe 'GET /show' do
    context 'without any login (public)' do
      it 'successfully shows the CocktailRecipe' do
        get cocktail_recipe_path(cocktail_recipe)
        expect(response).to be_successful
        expect(response.body).to include cocktail_recipe.name
        expect(response.body).to include cocktail_recipe.parts.first.ingredient.name
        expect(response.body).to include cocktail_recipe.parts.second.ingredient.name
        expect(response.body).to include cocktail_recipe.selling_price.to_s
      end
    end
  end
end
