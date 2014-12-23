class RecipeReference < ActiveRecord::Base
  validates :name, presence: true
  validate has_link_xor_recipe_id

  private

    def has_link_xor_recipe_id 
      return (!self.link ^ !self.recipe_id) 
    end

end
