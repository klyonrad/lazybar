require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
  let(:test_admin) {
    #Admin.create email: 'test@example.com', password: 'battery horse staple'
    create :admin
  }

  # This should return the minimal set of attributes required to create a valid
  # Ingredient. As you add validations to Ingredient, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    category_id = IngredientCategory.create!(name: 'Category').id # to make a corresponding Foreign Key
    { name: 'Name', price_per_cl: 0.214, ingredient_category_id: category_id }
  }

  let(:invalid_attributes) {
    { name: nil, price_per_cl: 2, ingredient_category_id: nil }
  }

  # Test uniquness validation
  let(:duplicate_name_attributes) {
    ingredient = Ingredient.create! valid_attributes
    { name: ingredient.name, price_per_cl: 0.135, ingredient_category_id: ingredient.ingredient_category_id }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # IngredientsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  let(:admin_session) {
    sign_in test_admin
  }



  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        skip('Add a hash of attributes valid for your model')
      }

      it 'updates the requested ingredient' do
        ingredient = Ingredient.create! valid_attributes
        put :update, { :id => ingredient.to_param, :ingredient => new_attributes }, admin_session
        ingredient.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested ingredient as @ingredient' do
        ingredient = Ingredient.create! valid_attributes
        put :update, { :id => ingredient.to_param, :ingredient => valid_attributes }, admin_session
        expect(assigns(:ingredient)).to eq(ingredient)
      end

      it 'redirects to the ingredient' do
        ingredient = Ingredient.create! valid_attributes
        put :update, { :id => ingredient.to_param, :ingredient => valid_attributes }, admin_session
        expect(response).to redirect_to(ingredient)
      end
    end

    context 'with invalid params' do
      it 'assigns the ingredient as @ingredient' do
        ingredient = Ingredient.create! valid_attributes
        put :update, { :id => ingredient.to_param, :ingredient => invalid_attributes }, admin_session
        expect(assigns(:ingredient)).to eq(ingredient)
      end

      it "re-renders the 'edit' template" do
        ingredient = Ingredient.create! valid_attributes
        put :update, { :id => ingredient.to_param, :ingredient => invalid_attributes }, admin_session
        expect(response).to render_template('edit')
      end
    end

    context 'with non-unique name' do
      it "re-renders the 'edit' template" do
        first_ingredient  = Ingredient.create! valid_attributes
        second_ingredient = Ingredient.create!(
          name:                   'Other Name',
          price_per_cl:           first_ingredient.price_per_cl,
          ingredient_category_id: first_ingredient.ingredient_category_id
        )
        put :update, {
          id:         second_ingredient.to_param, # try to edit the first element with the name of the second element
          ingredient: { # maybe put this in a seperate method
                        name:                   first_ingredient.name,
                        price_per_cl:           0.123,
                        ingredient_category_id: first_ingredient.ingredient_category_id
          }
        }, admin_session
        expect(response).to render_template('edit')
      end
    end
  end

end
