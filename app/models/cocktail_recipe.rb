# from http://stackoverflow.com/a/36134208/1796645
class CollectionLengthValidator < ActiveModel::Validations::LengthValidator
  def validate_each(record, attribute, value)
    value = value.respond_to?(:reject) ? value.reject(&:marked_for_destruction?) : value
    super(record, attribute, value)
  end
end

# This Model represents a Cocktail Recipe
# name
# cocktail_recipe_parts
class CocktailRecipe < ActiveRecord::Base
  has_many :cocktail_recipe_parts, inverse_of: :cocktail_recipe, dependent: :destroy
  accepts_nested_attributes_for :cocktail_recipe_parts, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true, uniqueness: true
  validates :cocktail_recipe_parts, collection_length: { minimum: 2 }

  def cost
    sum = 0
    cocktail_recipe_parts.each do |part|
      sum += (part.ingredient.price_per_cl / 10) * part.amount
    end
    sprintf('%.3g', sum).to_f # rubocop:disable Style/FormatString
  end

  # Increase cost by a profit margin
  def selling_price
    sprintf('%.3g', cost * 1.03).to_f # rubocop:disable Style/FormatString
  end
end
