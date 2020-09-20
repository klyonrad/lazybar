# frozen_string_literal: true

class EditCocktailRecipeButtonComponent < ViewComponent::Base
  def initialize(record:, content: 'Edit', admin: false)
    @record = record
    @content = content
    @admin = admin
  end

  def render?
    @admin
  end

  def call
    link_to @content, edit_cocktail_recipe_path(@record), class: 'uk-button uk-button-primary'
  end
end
