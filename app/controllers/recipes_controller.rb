class RecipesController < ApplicationController
  include RecipesHelper
  before_action :set_recipe, only: [:show, :update, :destroy]
  protect_from_forgery :except => [:create, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound do |e|
    raise_error("Object not found", :not_found)
  end

  def index
    @recipes = RecipeReference.all
    render "index.json.jbuilder"
  end

  def show
    render "show.json.jbuilder"
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: @recipe, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    render nothing: true, status: :ok
  end

  private
    def recipe_params
      params.require(:recipe).permit(:description, :ingredients, :instructions)
    end

    def external_params
      params.require(:recipe_reference).permit(:name, :external)
    end
    def set_recipe
      ref = RecipeReference.find(params[:id])
      r = ref.recipe
      @recipe = RecipeIntermediate.new(ref, r)
    end
end
