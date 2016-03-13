require 'rails_helper'

RSpec.describe "cocktail_recipes/edit", type: :view do
  before(:each) do
    @cocktail_recipe = assign(:cocktail_recipe, CocktailRecipe.create!(
      :name => "MyString",
      :cost => "9.99",
      :selling_price => "9.99",
      :description => "MyString"
    ))
  end

  it "renders the edit cocktail_recipe form" do
    render

    assert_select "form[action=?][method=?]", cocktail_recipe_path(@cocktail_recipe), "post" do

      assert_select "input#cocktail_recipe_name[name=?]", "cocktail_recipe[name]"

      assert_select "input#cocktail_recipe_cost[name=?]", "cocktail_recipe[cost]"

      assert_select "input#cocktail_recipe_selling_price[name=?]", "cocktail_recipe[selling_price]"

      assert_select "input#cocktail_recipe_description[name=?]", "cocktail_recipe[description]"
    end
  end
end
