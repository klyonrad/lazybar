json.array!(@ingredient_categories) do |ingredient_category|
  json.extract! ingredient_category, :id, :name
  json.url ingredient_category_url(ingredient_category, format: :json)
end
