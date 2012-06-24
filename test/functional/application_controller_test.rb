require "test_helper"

module TestControllers
  class RequireSSL < ApplicationController; before_filter :require_ssl; end
  class DoNotRequireSSL < ApplicationController; end
  class SSLForFoo < ApplicationController; before_filter :require_ssl, only: [:foo]; end
  class SSLExceptFoo < ApplicationController; before_filter :require_ssl, except: [:foo]; end
end

class ApplicationControllerTest < ActionController::TestCase

  def setup_controller(class_name)
    @controller = class_name.new
    update_response
    update_request
  end

  def update_response
    @controller.instance_variable_set("@_response", @response)
  end

  def update_request
    @controller.instance_variable_set("@_request", @request)
  end

  #
  # require_ssl
  #

  test "it redirects non-ssl requests" do
    update_response
    @controller.require_ssl

    assert_response 301
  end

  test "it does not redirect ssl requests" do
    update_response
    use_ssl
    @controller.require_ssl

    assert_response 200
  end

  #
  # check_for_ssl
  #

  test "it should redirect out of ssl when its not required" do
    setup_controller(TestControllers::DoNotRequireSSL)
    use_ssl
    @controller.check_for_ssl

    assert_response 301
  end

  test "it should redirect out of ssl when its not require for action" do
    setup_controller(TestControllers::SSLForFoo)
    use_ssl
    @controller.action_name = "bar"
    @controller.check_for_ssl

    assert_response 301
  end

  test "it should not redirect out of ssl when its required" do
    setup_controller(TestControllers::RequireSSL)
    use_ssl

    assert_response 200
  end

  test "it should not redirect out of ssl when its required for action" do
    setup_controller(TestControllers::SSLExceptFoo)
    use_ssl
    @controller.action_name = "bar"

    assert_response 200
  end

end
