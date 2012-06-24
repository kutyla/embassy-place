Given /^a post$/ do
  @post = Post.create({
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph })
end