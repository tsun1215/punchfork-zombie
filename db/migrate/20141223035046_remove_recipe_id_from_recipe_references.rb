class RemoveRecipeIdFromRecipeReferences < ActiveRecord::Migration
  def change
    remove_column :recipe_references, :recipe_id
  end
end
