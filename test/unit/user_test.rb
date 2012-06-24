require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create({
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: (0...8).map{65.+(rand(25)).chr}.join })
  end

  # Mongoid does not support rails 'find_by_...'
  test "should find user with find_by_email" do
    assert_equal User.find_by_email(@user.email)._id, @user._id
  end

  test "should find user by remember token" do
    assert_equal User.find_by_remember_token(@user.remember_token), @user
  end

end
