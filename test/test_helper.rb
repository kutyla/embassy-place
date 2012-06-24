ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'clearance/testing'
require 'database_setup'

class ActiveSupport::TestCase
  def current_user
    @controller.current_user
  end

  def use_ssl
    @request.env['HTTPS'] = 'on'
  end

end
