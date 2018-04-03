# frozen_string_literal: true

class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show]

  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient.includes(:ingredient_category).all
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ingredient
    @ingredient = Ingredient.find params[:id]
  end
end
