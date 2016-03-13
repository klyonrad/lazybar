require "rails_helper"

RSpec.describe CocktailRecipesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cocktail_recipes").to route_to("cocktail_recipes#index")
    end

    it "routes to #new" do
      expect(:get => "/cocktail_recipes/new").to route_to("cocktail_recipes#new")
    end

    it "routes to #show" do
      expect(:get => "/cocktail_recipes/1").to route_to("cocktail_recipes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cocktail_recipes/1/edit").to route_to("cocktail_recipes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cocktail_recipes").to route_to("cocktail_recipes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cocktail_recipes/1").to route_to("cocktail_recipes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cocktail_recipes/1").to route_to("cocktail_recipes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cocktail_recipes/1").to route_to("cocktail_recipes#destroy", :id => "1")
    end

  end
end
