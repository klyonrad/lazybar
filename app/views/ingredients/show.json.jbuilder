# frozen_string_literal: true

json.extract! @ingredient,
              :id,
              :ingredient_category_id,
              :name,
              :price_per_cl,
              :available,
              :comment,
              :created_at,
              :updated_at
