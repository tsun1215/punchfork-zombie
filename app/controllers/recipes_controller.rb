class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @user, notice: "Recipe successfully added" }
        format.json { render :index, status: :created, location: @recipe }
      else
        format.html { render :new_internal }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe successfully updated" }
        format.json { render :index, status: :ok, location: @recipe }
      else
        format.html { render :new_internal }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to :index, notice: "Recipe successfully deleted" }
      format.json { status: :ok }
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:description, :ingredients, :instructions)
    end

    def external_params
      params.require(:recipe_reference).permit(:name, :external)
    end
end
