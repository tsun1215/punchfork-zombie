class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :description
      t.string :ingredients
      t.text :instructions

      t.timestamps null: false
    end
  end
end
