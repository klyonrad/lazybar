# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CocktailRecipes', type: :request do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:cocktail_recipe) { create :cocktail_recipe }

  describe 'GET /cocktail_recipes' do
    context 'without any login (public)' do
      context 'without any CocktailRecipe' do
        before { get cocktail_recipes_path }

        it 'works' do
          expect(response).to have_http_status(200)
        end

        it 'does not shows link to new form' do
          expect(response).to be_successful
          expect(response.body).to have_tag("a[href=\"#{new_cocktail_recipe_path}\"]", count: 0)
        end
      end

      context 'with one CocktailRecipe' do
        let!(:cocktail_recipe) { create :cocktail_recipe }
        before { get cocktail_recipes_path }

        it 'works and shows CocktailRecipe' do
          expect(response).to be_successful
          expect(response.body).to include(cocktail_recipe.name)
        end

        it 'shows the ingredients of the CocktailRecipe' do
          expect(response).to be_successful
          expect(response.body).to include(cocktail_recipe.parts.first.ingredient.name)
          expect(response.body).to include(cocktail_recipe.parts.second.ingredient.name)
        end

        it 'does not show EDIT button for any existing recipe' do
          expect(response).to be_successful
          expect(response.body).to have_tag("a[href=\"#{edit_cocktail_recipe_path(cocktail_recipe)}\"]", count: 0)
        end

        it 'does not show DELETE button for any existing recipe' do
          expect(response).to be_successful
          expect(response.body).to have_tag(
            "a[href=\"#{cocktail_recipe_path(cocktail_recipe)}\"]" + '[data-method="delete"]',
            count: 0, text: 'Destroy'
          )
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
        expect(response.body).to have_tag("a[href=\"#{new_cocktail_recipe_path}\"]", count: 1)
      end

      context 'with one cocktail recipe' do
        let!(:cocktail_recipe) { create :cocktail_recipe }
        before { get cocktail_recipes_path }

        it 'shows EDIT button for any existing recipe' do
          expect(response).to be_successful
          expect(response.body).to have_tag("a[href=\"#{edit_cocktail_recipe_path(cocktail_recipe)}\"]", count: 1)
        end

        it 'shows DELETE button for any existing recipe' do
          expect(response).to be_successful
          expect(response.body).to have_tag(
            "a[href=\"#{cocktail_recipe_path(cocktail_recipe)}\"]" + '[data-method="delete"]',
            count: 1, text: 'Destroy'
          )
        end
      end
    end
  end

  describe 'GET /show' do
    before { get cocktail_recipe_path(cocktail_recipe) }
    let(:result) { response.body }

    it 'successfully shows the CocktailRecipe' do
      expect(response).to be_successful
      expect(result).to have_tag('h1', text: cocktail_recipe.name)
      expect(result).to have_tag('td', text: cocktail_recipe.parts.first.ingredient.name)
      expect(result).to have_tag('td', text: cocktail_recipe.parts.second.ingredient.name)
      expect(result).to have_tag('.uk-description-list',
                                 text: ['Cost', '3.06',
                                        'Selling price', '3.15',
                                        'Description'].join("\n\n"))
    end

    context 'without any login (public)' do
      it 'does not show EDIT button for any existing recipe' do
        expect(response).to be_successful
        expect(response.body).to have_tag("a[href=\"#{edit_cocktail_recipe_path(cocktail_recipe)}\"]", count: 0)
      end
    end
  end

  describe 'GET /edit' do
    context 'with admin login' do
      before { sign_in admin }

      it 'works' do
        get edit_cocktail_recipe_path(cocktail_recipe)
        expect(response).to be_successful
        expect(response.body).to have_tag('input#cocktail_recipe_name', value: cocktail_recipe.name)
      end
    end

    context 'without any login(public)' do
      it 'does not work' do
        get edit_cocktail_recipe_path(cocktail_recipe)
        expect(response).to redirect_to(new_admin_session_path)
        follow_redirect!
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /new' do
    context 'with admin login' do
      before { sign_in admin }

      it 'works' do
        get new_cocktail_recipe_path
        expect(response).to be_successful
        expect(response.body).to have_tag('input#cocktail_recipe_name', value: '')
      end
    end

    context 'without any login(public)' do
      it 'does not work' do
        get new_cocktail_recipe_path
        expect(response).to redirect_to(new_admin_session_path)
        follow_redirect!
        expect(response).to be_successful
      end
    end
  end
end
