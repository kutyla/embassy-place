# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do
  post = Post.new
  post.title = Faker::Lorem.sentence(rand(5))
  post.content = Faker::Lorem.paragraphs(rand(10)).join
  post.save
end
