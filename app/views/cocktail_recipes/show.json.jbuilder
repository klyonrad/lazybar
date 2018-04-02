# frozen_string_literal: true

json.extract! @cocktail_recipe,
              :id,
              :name,
              :cocktail_recipe_parts,
              :cost,
              :selling_price,
              :description,
              :created_at,
              :updated_at
