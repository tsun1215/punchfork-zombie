module RecipesHelper
  class RecipeIntermediate
    def initialize(recipe_reference, recipe)
      @ref = recipe_reference
      if !recipe
        @recipe = Recipe.new
      else
        @recipe = recipe
      end
    end

    def method_missing(method, *args, &block)
      if @ref.respond_to?(method.to_s)
        @ref.send(method, *args, &block)
      elsif @recipe.respond_to?(method.to_s)
        @recipe.send(method, *args, &block)
      else
        super
      end
    end

    def repond_to?(method)
      if @ref.respond_to?(method.to_s)
        true
      elsif @recipe.respond_to?(method.to_s)
        true
      else
        super
      end
    end
  end

end
