class AddUserIdToRecipeReference < ActiveRecord::Migration
  def change
    add_column :recipe_references, :user_id, :integer
  end
end
