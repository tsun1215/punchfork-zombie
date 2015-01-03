module RecipesHelper
  class RecipeIntermediate
    def initialize(recipe_reference, recipe)
      @ref = recipe_reference
      if !recipe
        @recipe = Recipe.new
        @external = true
      else
        @recipe = recipe
        @external = false
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

    def update(recipe_params, recipe_ref_params)
      if not @external and not recipe_params.empty?
        @recipe.update(recipe_params)
      end
      if not recipe_ref_params.empty?
        @ref.update(recipe_ref_params)
      end
      self.errors.empty?
    end

    def errors()
      @recipe.errors.to_a + @ref.errors.to_a
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
