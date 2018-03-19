require 'rails_helper'

RSpec.describe 'Ingredients', type: :request do
  let(:user) { create :user }
  let(:admin) { create :admin }
  let(:ingredient) { create :ingredient }
  let(:category_id) { create(:ingredient_category).id }
  let(:valid_attributes) do
    { name: Faker::Food.ingredient,
      price_per_cl: 0.25, # Faker::Number.decimal(1, 7).to_s
      ingredient_category_id: category_id }
  end

  describe 'GET Requests' do
    describe '#index' do
      it 'shows ingredient list with correct content' do
        ingredient
        get ingredients_path
        expect(response).to be_successful
        expect(response.body).to include ingredient.name
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

    describe '#new' do
      context 'when no ingredient_category present' do
        it 'shows error for create form' do
          sign_in admin
          get new_ingredient_path
          expect(response).to be_successful # user will get error when attempting to save
        end
      end

      context 'when ingredient_category present' do
        let!(:ingredient_category) { create :ingredient_category }

        it 'loads the ingredient create form with an ingredient category' do
          sign_in admin
          get new_ingredient_path
          expect(response).to be_successful
          expect(response.body).to include ingredient_category.name
          expect(response.body).to include ingredient_category.id.to_s
        end

        it 'does not show ingredient create form without login' do
          get new_ingredient_path
          expect(response).to redirect_to new_admin_session_path
        end

        it 'does not show ingredient create form without admin login' do
          sign_in user
          get new_ingredient_path
          expect(response).to redirect_to new_admin_session_path
        end
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      context 'with admin login' do
        before { sign_in admin }

        it 'creates a new Ingredient' do
          post ingredients_path ingredient: valid_attributes
          expect(Ingredient.count).to eql 1
        end

        it 'redirects to the created ingredient' do
          post ingredients_path ingredient: valid_attributes
          expect(response).to redirect_to(Ingredient.last)
        end
      end

      context 'without login' do
        it 'does not create anything' do
          post ingredients_path ingredient: valid_attributes
          expect(Ingredient.all).to be_empty
        end

        it 'redirects to the created ingredient' do
          post ingredients_path ingredient: valid_attributes
          expect(response).to redirect_to(new_admin_session_path)
        end

        it 'returns status code forbidden' do
          post ingredients_path ingredient: valid_attributes
          expect(response.status).to eql 302
        end
      end
    end

    describe 'with invalid params' do
      let(:invalid_attributes) { { name: nil, price_per_cl: 2, ingredient_category_id: nil } }
      let(:valid_attributes) do
        { name: Faker::Food.ingredient,
          price_per_cl: 0.25, # Faker::Number.decimal(1, 7).to_s
          ingredient_category_id: category_id }
      end
      let(:out_of_bound_category_param) do
        category = create(:ingredient_category)
        { name: Faker::Food.ingredient, price_per_cl: 2, ingredient_category_id: (category.id + 20) }
      end

      context 'with admin login' do
        before { sign_in admin }

        context 'Ingredient Category present' do
          it 'does not create a new Ingredient' do
            post ingredients_path ingredient: invalid_attributes
            expect(Ingredient.all).to be_empty
          end

          it 'does not create a new Ingredient with too high category ID' do
            post ingredients_path ingredient: out_of_bound_category_param
            expect(Ingredient.all).to be_empty
          end

          it 'returns correct status code' do
            post ingredients_path ingredient: invalid_attributes
            expect(response).to be_successful
          end

          it "re-renders the 'new' template" do
            post ingredients_path ingredient: invalid_attributes
            expect(response).to render_template('new')
          end
        end

        describe 'with non_unique name' do
          let(:duplicate_name_attributes) do
            ingredient = create(:ingredient, valid_attributes)
            { name: ingredient.name, price_per_cl: 0.135, ingredient_category_id: ingredient.ingredient_category_id }
          end

          it "re-renders the 'new' template" do
            post ingredients_path(ingredient: duplicate_name_attributes)
            expect(response).to render_template('new')
          end
        end
      end
    end

    context 'no Ingredient Category present' do
      it 'shows error for create form' do
        sign_in admin
        post ingredients_path(ingredient: { name: Faker::Food.ingredient, price_per_cl: 0.25, ingredient_category_id: 1 })
        expect(response.body).to match('category must exist')
      end
    end
  end

  describe 'PUT #update' do
    describe 'with valid params' do
      context 'with admin login' do
        before { sign_in admin }

        it 'updates the price' do
          new_price = 0.5
          patch ingredient_path(ingredient), params: { ingredient: { price_per_cl: new_price.to_s } }
          expect(response.status).to eql 302
          expect(ingredient.reload.price_per_cl).to eq new_price
        end

        it 'redirects to the ingredient' do
          put ingredient_path(ingredient), params: { ingredient: valid_attributes }
          expect(response).to redirect_to(ingredient)
        end
      end

      context 'without login' do
        # TODO
      end

      context 'with user login' do
        # TODO
      end
    end

    describe 'with invalid params' do
      context 'with admin login' do
        before { sign_in admin }

        it "re-renders the 'edit' template" do
          put ingredient_path(ingredient), params: { ingredient: { name: '' } }
          expect(response).to render_template('edit')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with admin login' do
      before { sign_in admin }

      it 'destroys the requested ingredient' do
        ingr = ingredient
        expect do
          sign_in admin
          delete ingredient_path(ingr)
        end.to change(Ingredient, :count).by(-1)
        expect(response).to have_http_status(:found)
      end
    end

    it 'does not destroy the ingredient' do
      ingr = ingredient
      expect { delete ingredient_path(ingr) }.to change(Ingredient, :count).by(0)
    end

    it 'redirects to the ingredients list' do
      delete ingredient_path(ingredient)
      expect(response).to redirect_to new_admin_session_path
    end
  end
end
