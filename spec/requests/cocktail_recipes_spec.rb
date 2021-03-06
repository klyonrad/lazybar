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
          expect(response).to have_http_status(:ok)
        end

        it 'does not shows link to new form' do
          expect(response).to be_successful
          assert_select("a[href=\"#{new_cocktail_recipe_path}\"]", count: 0)
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
          assert_select("a[href=\"#{edit_cocktail_recipe_path(cocktail_recipe)}\"]", count: 0)
        end

        it 'does not show DELETE button for any existing recipe' do
          expect(response).to be_successful
          assert_select(
            "a[href=\"#{cocktail_recipe_path(cocktail_recipe)}\"][data-method=\"delete\"]",
            count: 0, text: 'Destroy'
          )
        end
      end
    end

    context 'with admin login' do
      before { sign_in admin }

      it 'shows link to new form' do
        get cocktail_recipes_path
        expect(response).to be_successful
        assert_select("a[href=\"#{new_cocktail_recipe_path}\"]", count: 1)
      end

      context 'with one cocktail recipe' do
        let!(:cocktail_recipe) { create :cocktail_recipe }

        before { get cocktail_recipes_path }

        it 'shows EDIT button for any existing recipe' do
          expect(response).to be_successful
          assert_select("a[href=\"#{edit_cocktail_recipe_path(cocktail_recipe)}\"]", count: 1)
        end

        it 'shows DELETE button for any existing recipe' do
          expect(response).to be_successful
          assert_select(
            "a[href=\"#{cocktail_recipe_path(cocktail_recipe)}\"][data-method=\"delete\"]",
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
      assert_select('h1', text: cocktail_recipe.name)
      assert_select('td', text: cocktail_recipe.parts.first.ingredient.name)
      assert_select('td', text: cocktail_recipe.parts.second.ingredient.name)
      assert_select('.uk-description-list',
                    text: ['Selling price', '€3.20',
                           'Cost', '3.06',
                           'Description'].join("\n\n"))
    end

    context 'without any login (public)' do
      it 'does not show EDIT button for any existing recipe' do
        expect(response).to be_successful
        assert_select("a[href=\"#{edit_cocktail_recipe_path(cocktail_recipe)}\"]", count: 0)
      end
    end
  end

  describe 'GET /edit' do
    context 'with admin login' do
      before { sign_in admin }

      it 'works' do
        get edit_cocktail_recipe_path(cocktail_recipe)
        expect(response).to be_successful
        assert_select('input#cocktail_recipe_name', value: cocktail_recipe.name)
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
        assert_select('input#cocktail_recipe_name', value: '')
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

  describe 'POST /create' do
    let(:first_ingredient) { create :ingredient }
    let(:second_ingredient) { create :ingredient }
    let(:first_part_params) { { ingredient_id: first_ingredient.id, amount: '20' } }
    let(:second_part_params) { { ingredient_id: second_ingredient.id, amount: '15' } }
    let :valid_params do
      { cocktail_recipe: { name: 'foo',
                           cocktail_recipe_parts_attributes: {
                             '0': first_part_params,
                             '1': second_part_params
                           } } }
    end
    let :invalid_params do
      { cocktail_recipe: { name: 'foo',
                           cocktail_recipe_parts_attributes: {
                             '0': first_part_params
                           } } }
    end
    let(:last_cocktail) { CocktailRecipe.last }

    context 'with admin login' do
      before { sign_in admin }

      it 'saves the recipe in database upon receiving correct parameters' do
        post cocktail_recipes_path, params: valid_params

        expect(CocktailRecipe.all).not_to be_empty
        expect(last_cocktail.name).to eq('foo')
        expect(last_cocktail.parts).to have(2).items
        expect(response).to redirect_to(cocktail_recipe_path(last_cocktail))
        follow_redirect!
      end

      it 'does not save the recipe with invalid params and re-renders' do
        post cocktail_recipes_path, params: invalid_params

        expect(CocktailRecipe.all).to be_empty
        expect(response.body).to match('Cocktail recipe parts is too short')
      end
    end
  end

  describe 'POST /update' do
    context 'with admin login' do
      before { sign_in admin }

      let(:first_ingredient) { create :ingredient }
      let(:second_ingredient) { create :ingredient }
      let(:first_part_params) { { ingredient_id: first_ingredient.id, amount: '20' } }
      let(:second_part_params) { { ingredient_id: second_ingredient.id, amount: '15' } }

      context 'with new valid parameters' do
        let :params do
          { cocktail_recipe: { name: 'foo',
                               cocktail_recipe_parts_attributes: {
                                 '0': first_part_params,
                                 '1': second_part_params
                               } } }
        end

        it 'changes the cocktail recipe' do
          put cocktail_recipe_path(cocktail_recipe), params: params
          cocktail_recipe.reload

          expect(cocktail_recipe.name).to eq('foo')
          expect(response).to redirect_to(cocktail_recipe_path(cocktail_recipe))
          follow_redirect!
        end
      end

      context 'with invalid parameters' do
        let(:recipe_second_part_destroy_params) { { id: cocktail_recipe.parts.second.id, _destroy: '1' } }
        let :params do
          { cocktail_recipe: { name: 'foo',
                               cocktail_recipe_parts_attributes: {
                                 '0': recipe_second_part_destroy_params
                               } } }
        end

        it 'does not change the cocktail recipe' do
          put cocktail_recipe_path(cocktail_recipe), params: params
          cocktail_recipe.reload

          expect(cocktail_recipe.name).not_to eq('foo')
          expect(response).to be_successful
        end
      end
    end
  end

  describe 'POST /destroy' do
    let!(:cocktail_recipe) { create :cocktail_recipe }
    let(:recipe_delete_action) { delete(cocktail_recipe_path(cocktail_recipe)) }

    context 'with admin login' do
      before { sign_in admin }

      it 'works' do
        expect { recipe_delete_action }.to change { CocktailRecipe.all.count }.from(1).to(0)

        expect(response).to redirect_to(cocktail_recipes_path)
        follow_redirect!
        expect(response).to be_successful
      end
    end

    context 'without any login(public)' do
      it 'does not destroy the recipe' do
        expect { recipe_delete_action }.not_to(change { CocktailRecipe.all.count })

        expect(response).to redirect_to(new_admin_session_path)
        follow_redirect!
        expect(response).to be_successful
      end
    end
  end
end
