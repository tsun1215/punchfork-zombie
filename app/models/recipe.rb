class Recipe < ActiveRecord::Base
  validates :description, presence: true
  validates :ingredients, presence: true
  serialize :ingredients, JSON
  validates :instructions, presence: true

  belongs_to :recipe_reference
end
