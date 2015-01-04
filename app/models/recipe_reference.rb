class RecipeReference < ActiveRecord::Base
  validates :name, presence: true
  validate :has_external_xor_recipe_id

  VALID_URL_REGEX = /\A(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,8}(.)*)\z/
  validates :external, format: {with: VALID_URL_REGEX}, allow_nil: true

  belongs_to :user
  belongs_to :recipe_reference
  has_one :recipe

  private

    def has_external_xor_recipe_id 
      if !(external.blank? ^ recipe_id.blank?) 
        errors.add(:base, "Recipe reference must have external link or recipe_id")
      end
    end

end
