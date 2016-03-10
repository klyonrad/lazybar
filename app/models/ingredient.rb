# ingredients from which the cocktails are made
class Ingredient < ActiveRecord::Base
  belongs_to :ingredient_category
  validates :name, presence: true, uniqueness: true
  validates :price_per_cl, presence: true
  validates :ingredient_category_id, presence: true
end
