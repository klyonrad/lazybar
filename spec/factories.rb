FactoryBot.define do
  factory :admin do
    email 'test@example.com'
    password 'battery horse staple'
  end

  factory :user do
    email 'test@example.com'
    password 'battery horse staple'
  end

  factory :ingredient_category do
    sequence(:name) { |n| "Category #{n}" }
  end

  factory :ingredient do
    sequence(:name) { |n| "Hipster Gin #{n}" }
    association :ingredient_category
    price_per_cl 0.255
  end

  factory :cocktail_recipe_part do
    amount 60

    before(:create) do |recipe_part, _|
      ingredient = create :ingredient
      recipe_part.cocktail_recipe = create(:cocktail_recipe)
      recipe_part.ingredient = ingredient
      recipe_part.ingredient_category = ingredient.category
    end
  end

  factory :cocktail_recipe do
    sequence(:name) { |n| "Super Mix #{n}" }
    transient do
      recipe_parts_count 2 # size of the cocktail recipe
    end

    # build recipe with it's parts. Only using build is not necessary,
    # you must hit the database because of the circular association
    before(:create) do |cocktail_recipe, evaluator|
      size = evaluator.recipe_parts_count
      ingrs = create_list(:ingredient, size)
      cocktail_parts = Array.new(size) do |i|
        build(:cocktail_recipe_part, ingredient: ingrs[i], ingredient_category: ingrs[i].category,
                                     cocktail_recipe: cocktail_recipe)
      end
      cocktail_recipe.cocktail_recipe_parts = cocktail_parts
    end
  end
end
