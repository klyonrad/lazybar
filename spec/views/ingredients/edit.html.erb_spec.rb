require 'rails_helper'

RSpec.describe "ingredients/edit", type: :view do
  before(:each) do
    @category = assign(:ingredient_category, IngredientCategory.create!(name: 'Category'))
    @ingredient = assign(:ingredient, Ingredient.create!(
      :ingredient_category => @category,
      :name => "MyString",
      :price_per_cl => "0.22",
      :available => false,
      :comment => "MyString"
    ))
  end

  it "renders the edit ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredient_path(@ingredient), "post" do

      assert_select "input#ingredient_ingredient_category_id[name=?]", "ingredient[ingredient_category_id]"

      assert_select "input#ingredient_name[name=?]", "ingredient[name]"

      assert_select "input#ingredient_price_per_cl[name=?]", "ingredient[price_per_cl]"

      assert_select "input#ingredient_price_per_cl[name=?]", "ingredient[price_per_cl]"

      assert_select "input#ingredient_available[name=?]", "ingredient[available]"

      assert_select "input#ingredient_comment[name=?]", "ingredient[comment]"
    end
  end
end
