class CocktailRecipesController < ApplicationController
  before_action :set_cocktail_recipe, only: [:show, :edit, :update, :destroy]

  # GET /cocktail_recipes
  # GET /cocktail_recipes.json
  def index
    @cocktail_recipes = CocktailRecipe.all
  end

  # GET /cocktail_recipes/1
  # GET /cocktail_recipes/1.json
  def show
  end

  # GET /cocktail_recipes/new
  def new
    @cocktail_recipe = CocktailRecipe.new
  end

  # GET /cocktail_recipes/1/edit
  def edit
  end

  # POST /cocktail_recipes
  # POST /cocktail_recipes.json
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

  # PATCH/PUT /cocktail_recipes/1
  # PATCH/PUT /cocktail_recipes/1.json
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

  # DELETE /cocktail_recipes/1
  # DELETE /cocktail_recipes/1.json
  def destroy
    @cocktail_recipe.destroy
    respond_to do |format|
      format.html { redirect_to cocktail_recipes_url, notice: 'Cocktail recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cocktail_recipe
    @cocktail_recipe = CocktailRecipe.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def cocktail_recipe_params
    params.require(:cocktail_recipe).permit(:name, :cost, :selling_price, :description)
  end
end
