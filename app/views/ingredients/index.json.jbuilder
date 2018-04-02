# frozen_string_literal: true

json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :ingredient_category_id, :name, :price_per_cl, :available, :comment
  json.url ingredient_url(ingredient, format: :json)
end
