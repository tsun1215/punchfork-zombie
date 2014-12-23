require 'test_helper'

class RecipeReferenceTest < ActiveSupport::TestCase
  
  test "recipe ref with no link or external is invalid" do
    ref = RecipeReference.new(name: "hello world")
    assert_not ref.valid?
  end

  test "recipe with both link and external is invalid" do
    ref = RecipeReference.new(name: "hello world", recipe_id: 1, external: "http://google.com")
    assert_not ref.valid?
  end

  test "recipe ref with no name is invalid" do
    ref = RecipeReference.new(recipe_id: 1)
    assert_not ref.valid?
  end

  test "recipe external validates as link with regex" do
    ref = RecipeReference.new(name: "hello world", external: "llamas")
    assert_not ref.valid?

    ref.external = "http://www.llamas.com"
    assert ref.valid?
  end

  test "recipe with link xor external and name is valid" do
    ref = RecipeReference.new(name: "asdf", recipe_id: 1)
    assert ref.valid?

    ref.recipe_id = nil
    ref.external = "http://www.stackoverflow.com"
    assert ref.valid?
  end

end
