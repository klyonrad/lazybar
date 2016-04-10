json.array!(@cocktail_recipes) do |cocktail_recipe|
  json.extract! cocktail_recipe, :id, :name, :cocktail_recipe_parts, :cost, :selling_price, :description
  json.url cocktail_recipe_url(cocktail_recipe, format: :json)
end
