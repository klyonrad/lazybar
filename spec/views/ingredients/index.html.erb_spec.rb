require 'rails_helper'

RSpec.describe "ingredients/index", type: :view do
  before(:each) do
    assign(:ingredients, [
      Ingredient.create!(
        :ingredient_category => nil,
        :name => "Name",
        :price_per_cl => "",
        :price_per_cl => "",
        :available => false,
        :comment => "Comment"
      ),
      Ingredient.create!(
        :ingredient_category => nil,
        :name => "Name",
        :price_per_cl => "",
        :price_per_cl => "",
        :available => false,
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of ingredients" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
