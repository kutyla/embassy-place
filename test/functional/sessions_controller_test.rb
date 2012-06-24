require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    use_ssl
    @password = (0...8).map{65.+(rand(25)).chr}.join
    @user = User.create({
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: @password })
  end

  test "should get new user session" do
    get :new
    assert_response :success
  end

  test "should post user session data" do
    post :create, { user_session: {} }

    assert_response 401
    assert_nil current_user
    assert_not_nil flash
  end

  test "should create user session" do
    params = {
      email: @user.email,
      password: @password }

    post :create, { user_session: params }

    assert_not_nil current_user
    assert_not_nil assigns(:user)
    assert_redirected_to root_path
  end

end
