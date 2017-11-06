# ingredients from which the cocktails are made
class Ingredient < ActiveRecord::Base
  alias_attribute :category, :ingredient_category
  belongs_to :ingredient_category
  validates :name, presence: true, uniqueness: true
  validates :price_per_cl, presence: true
  validates :price_per_cl, numericality: { greater_than_or_equal_to: 0 }
  validates :ingredient_category_id, presence: true
end
