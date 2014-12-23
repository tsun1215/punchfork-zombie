class AddRatingToRecipeReference < ActiveRecord::Migration
  def change
    add_column :recipe_references, :rating, :float
  end
end
