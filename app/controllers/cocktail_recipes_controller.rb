# frozen_string_literal: true

class CocktailRecipesController < ApplicationController
  before_action :set_cocktail_recipe, only: %i[show edit update destroy like unlike]
  before_action :authenticate_admin!, only: %i[new create edit update destroy]

  def index
    @cocktail_recipes =
      CocktailRecipe.includes(cocktail_recipe_parts: %i[ingredient ingredient_category]).all
  end

  def show; end

  def new
    @cocktail_recipe = CocktailRecipe.new
  end

  def edit; end

  def create
    @cocktail_recipe = CocktailRecipe.new(cocktail_recipe_params)

    respond_to do |format|
      if @cocktail_recipe.save
        format.html { redirect_to @cocktail_recipe, notice: 'Cocktail recipe was successfully created.' }
        format.json { render :show, status: :created, location: @cocktail_recipe }
      else
        format.html { render :new }
        format.json { render json: @cocktail_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cocktail_recipe.update(cocktail_recipe_params)
        format.html { redirect_to @cocktail_recipe, notice: 'Cocktail recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @cocktail_recipe }
      else
        format.html { render :edit }
        format.json { render json: @cocktail_recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cocktail_recipe.destroy
    respond_to do |format|
      format.html { redirect_to cocktail_recipes_url, notice: 'Cocktail recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    respond_to do |format|
      if current_user.like_cocktail(@cocktail_recipe).persisted?
        format.html { redirect_to @cocktail_recipe, notice: 'Liked that cocktail!' }
        format.json { render :show, status: :ok, location: @cocktail_recipe }
      else
        format.html { render :show, status: :internal_server_error, notice: 'went wrong' }
        format.json { render json: @cocktail_recipe.errors, status: :internal_server_error }
      end
    end
  end

  def unlike
    respond_to do |format|
      if current_user.unlike_cocktail(@cocktail_recipe).persisted?
        format.html { redirect_to @cocktail_recipe, notice: 'Liked that cocktail!' }
        format.json { render :show, status: :ok, location: @cocktail_recipe }
      else
        format.html { render :show, status: :internal_server_error, notice: 'went wrong' }
        format.json { render json: @cocktail_recipe.errors, status: :internal_server_error }
      end
    end
  end

  private

  def set_cocktail_recipe
    @cocktail_recipe = CocktailRecipe.find(params[:id])
  end

  def cocktail_recipe_params
    params.require(:cocktail_recipe).permit(
      :name,
      :description,
      cocktail_recipe_parts_attributes: %i[id ingredient_id strict amount _destroy]
    )
  end
end
