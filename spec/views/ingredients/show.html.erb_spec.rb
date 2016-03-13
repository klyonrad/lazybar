require 'rails_helper'

RSpec.describe "ingredients/show", type: :view do
  before(:each) do
    assign(:ingredient_category, [
      IngredientCategory.create!(name: 'Category1'),
      IngredientCategory.create!(name: 'Category2')
    ])
    @ingredient = assign(:ingredient, Ingredient.create!(
      :ingredient_category => IngredientCategory.find_by_name('Category1'),
      :name => "Name",
      :price_per_cl => "0.22",
      :available => false,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Category1/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/0.22/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Comment/)
  end
end
