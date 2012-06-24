Given /^a user$/ do
  @password = (0...8).map{65.+(rand(25)).chr}.join
  @user = User.create({ name: Faker::Name.name, email: Faker::Internet.email, password: @password })
end

Given /^a visitor$/ do
  true
end