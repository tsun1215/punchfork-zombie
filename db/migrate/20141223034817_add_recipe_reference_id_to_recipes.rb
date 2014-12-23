class AddRecipeReferenceIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :recipe_reference_id, :integer
  end
end
