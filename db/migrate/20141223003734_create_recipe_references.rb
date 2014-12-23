class CreateRecipeReferences < ActiveRecord::Migration
  def change
    create_table :recipe_references do |t|
      t.string :name
      t.integer :recipe_id
      t.string :external

      t.timestamps null: false
    end
  end
end
