require 'rails_helper'

RSpec.describe "cocktail_recipes/show", type: :view do
  before(:each) do
    @cocktail_recipe = assign(:cocktail_recipe, CocktailRecipe.create!(
      :name => "Name",
      :cost => "9.99",
      :selling_price => "9.99",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Description/)
  end
end
