require "test_helper"

class SitemapsControllerTest < ActionController::TestCase
  def setup
    @post_params = proc { { title: Faker::Lorem.sentence, content: Faker::Lorem.paragraphs } }
  end

  test "should get index" do
    get :index, { format: :xml }
    assert_response :success
  end

  test "should only show active posts" do
    post_1 = Post.create(@post_params.call)
    post_2 = Post.create(@post_params.call)
    post_2.mark_as_deleted!

    get :index, { format: :xml }
    assert_response :success
    assert assigns(:posts).include?(post_1)
    assert_select "loc", { text: "http://#{request.host}/posts/#{post_1.permalink}" }
    assert !assigns(:posts).include?(post_2)
  end

end
