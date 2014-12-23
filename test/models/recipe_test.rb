require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "recipe with no fields should not validate" do
    recipe = Recipe.new
    assert_not recipe.valid?      
  end

  test "recipe with all fields should validate" do
    recipe = Recipe.new(description:"123", ingredients:"1,2,3", instructions:"1,2,3")
    assert recipe.valid?      
  end
end
