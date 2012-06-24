require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  def setup
    #
  end

  test "should get the homepage" do
    get :index
    assert_response :success
  end

  test "should get the gallery" do
    get :gallery
    assert_response :success
  end

  test "should get features" do
    get :features
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should post contact" do
    post :create_contact, { note: {} }
    assert_response 400
  end

  test "should send email after post contact" do
    message = "some message"
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create_contact, { note: { email: Faker::Internet.email, name: Faker::Company.name, message: message } }
    end

    email = ActionMailer::Base.deliveries.last
    assert_equal ContactMailer.default_params[:to], email.to[0]
    assert_equal "Email from Site", email.subject
    assert_match(/#{message}/, email.encoded)

    assert_redirected_to root_path
  end

end
