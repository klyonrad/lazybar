# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    email { 'test@example.com' }
    password { 'battery horse staple' }
  end

  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'battery horse staple' }
  end

  factory :ingredient_category do
    sequence(:name) { |n| "Category #{n}" }
  end

  factory :ingredient do
    sequence(:name) { |n| "Hipster Gin #{n}" }
    association :ingredient_category
    price_per_cl { 0.255 }

    trait :unavailable do
      available { false }
    end
  end

  factory :cocktail_recipe_part do
    amount { 60 }
    ingredient { nil }
    ingredient_category { nil }

    before(:create) do |recipe_part, _|
      if recipe_part.ingredient
        recipe_part.ingredient_category = recipe_part.ingredient.category
        recipe_part.cocktail_recipe = create(:cocktail_recipe)
      else
        ingredient = create :ingredient
        recipe_part.cocktail_recipe = create(:cocktail_recipe)
        recipe_part.ingredient = ingredient
        recipe_part.ingredient_category = ingredient.category
      end
    end

    trait :flexible do
      strict { false }
    end

    trait :strict do
      strict { true }
    end
  end

  factory :cocktail_recipe do
    sequence(:name) { |n| "Super Mix #{n}" }
    transient do
      recipe_parts_count { 2 } # size of the cocktail recipe
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

  factory :user_cocktail_like do
    association :user
    association :cocktail_recipe
  end
end
