class RecipesController < ApplicationController
  include RecipesHelper
  before_action :authenticate, :except =>[:index, :show]
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
    r = Recipe.new(recipe_params)
    ref = RecipeReference.new(recipe_ref_params)
    if recipe_params.empty?
      if ref.save
        @recipe = RecipeIntermediate.new(ref, r)
        render :show and return
      end
    else
      if r.save
        ref.recipe_id = r.id
        if ref.save
          r.recipe_reference = ref
          @recipe = RecipeIntermediate.new(ref, r)
          render :show and return
        end
      end
    end
    render json: r.errors.to_a + ref.errors.to_a, status: :unprocessable_entity
  end

  def update
    if @recipe.update(recipe_params, recipe_ref_params)
      render :show and return
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
      params.permit(:description, :instructions).tap do |w|
        if params[:ingredients]
          w[:ingredients] = params[:ingredients]
        end
      end
    end

    def recipe_ref_params
      params.permit(:name, :external)
    end
    def set_recipe
      ref = RecipeReference.find(params[:id])
      r = ref.recipe
      @recipe = RecipeIntermediate.new(ref, r)
    end
end
