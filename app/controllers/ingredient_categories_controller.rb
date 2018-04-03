# frozen_string_literal: true

class IngredientCategoriesController < ApplicationController
  before_action :set_ingredient_category, only: %i[show]

  # GET /ingredient_categories
  # GET /ingredient_categories.json
  def index
    @ingredient_categories = IngredientCategory.all
  end

  # GET /ingredient_categories/1
  # GET /ingredient_categories/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ingredient_category
    @ingredient_category = IngredientCategory.find(params[:id])
  end
end
