# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
  User.create!(email: "example-#{n}@example.com", 
               first_name: "The", 
               last_name: "#{10+n}th Best", 
               password: "password", 
               password_confirmation: "password")
end

100.times do |n|
  RecipeReference.create!(name: "Recipe #{n}", external: "http://reddit.com/r/food", user_id: ((n%10)+1))
end