require 'rails_helper'

RSpec.describe "cocktail_recipes/index", type: :view do
  before(:each) do
    assign(:cocktail_recipes, [
      CocktailRecipe.create!(
        :name => "Name",
        :cost => "9.99",
        :selling_price => "9.99",
        :description => "Description"
      ),
      CocktailRecipe.create!(
        :name => "Name",
        :cost => "9.99",
        :selling_price => "9.99",
        :description => "Description"
      )
    ])
  end

  it "renders a list of cocktail_recipes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
