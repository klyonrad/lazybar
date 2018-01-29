require 'rails_helper'

RSpec.describe CocktailRecipesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # CocktailRecipe. As you add validations to CocktailRecipe, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CocktailRecipesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all cocktail_recipes as @cocktail_recipes" do
      cocktail_recipe = CocktailRecipe.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:cocktail_recipes)).to eq([cocktail_recipe])
    end
  end

  describe "GET #show" do
    it "assigns the requested cocktail_recipe as @cocktail_recipe" do
      cocktail_recipe = CocktailRecipe.create! valid_attributes
      get :show, {:id => cocktail_recipe.to_param}, valid_session
      expect(assigns(:cocktail_recipe)).to eq(cocktail_recipe)
    end
  end

  describe "GET #new" do
    it "assigns a new cocktail_recipe as @cocktail_recipe" do
      get :new, {}, valid_session
      expect(assigns(:cocktail_recipe)).to be_a_new(CocktailRecipe)
    end
  end

  describe "GET #edit" do
    it "assigns the requested cocktail_recipe as @cocktail_recipe" do
      cocktail_recipe = CocktailRecipe.create! valid_attributes
      get :edit, {:id => cocktail_recipe.to_param}, valid_session
      expect(assigns(:cocktail_recipe)).to eq(cocktail_recipe)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new CocktailRecipe" do
        expect {
          post :create, {:cocktail_recipe => valid_attributes}, valid_session
        }.to change(CocktailRecipe, :count).by(1)
      end

      it "assigns a newly created cocktail_recipe as @cocktail_recipe" do
        post :create, {:cocktail_recipe => valid_attributes}, valid_session
        expect(assigns(:cocktail_recipe)).to be_a(CocktailRecipe)
        expect(assigns(:cocktail_recipe)).to be_persisted
      end

      it "redirects to the created cocktail_recipe" do
        post :create, {:cocktail_recipe => valid_attributes}, valid_session
        expect(response).to redirect_to(CocktailRecipe.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved cocktail_recipe as @cocktail_recipe" do
        post :create, {:cocktail_recipe => invalid_attributes}, valid_session
        expect(assigns(:cocktail_recipe)).to be_a_new(CocktailRecipe)
      end

      it "re-renders the 'new' template" do
        post :create, {:cocktail_recipe => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested cocktail_recipe" do
        cocktail_recipe = CocktailRecipe.create! valid_attributes
        put :update, {:id => cocktail_recipe.to_param, :cocktail_recipe => new_attributes}, valid_session
        cocktail_recipe.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested cocktail_recipe as @cocktail_recipe" do
        cocktail_recipe = CocktailRecipe.create! valid_attributes
        put :update, {:id => cocktail_recipe.to_param, :cocktail_recipe => valid_attributes}, valid_session
        expect(assigns(:cocktail_recipe)).to eq(cocktail_recipe)
      end

      it "redirects to the cocktail_recipe" do
        cocktail_recipe = CocktailRecipe.create! valid_attributes
        put :update, {:id => cocktail_recipe.to_param, :cocktail_recipe => valid_attributes}, valid_session
        expect(response).to redirect_to(cocktail_recipe)
      end
    end

    context "with invalid params" do
      it "assigns the cocktail_recipe as @cocktail_recipe" do
        cocktail_recipe = CocktailRecipe.create! valid_attributes
        put :update, {:id => cocktail_recipe.to_param, :cocktail_recipe => invalid_attributes}, valid_session
        expect(assigns(:cocktail_recipe)).to eq(cocktail_recipe)
      end

      it "re-renders the 'edit' template" do
        cocktail_recipe = CocktailRecipe.create! valid_attributes
        put :update, {:id => cocktail_recipe.to_param, :cocktail_recipe => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested cocktail_recipe" do
      cocktail_recipe = CocktailRecipe.create! valid_attributes
      expect {
        delete :destroy, {:id => cocktail_recipe.to_param}, valid_session
      }.to change(CocktailRecipe, :count).by(-1)
    end

    it "redirects to the cocktail_recipes list" do
      cocktail_recipe = CocktailRecipe.create! valid_attributes
      delete :destroy, {:id => cocktail_recipe.to_param}, valid_session
      expect(response).to redirect_to(cocktail_recipes_url)
    end
  end

end
