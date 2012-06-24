class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery

  before_filter :check_for_ssl

  # Clearance hack to prevent confusion of what we're actually doing.
  alias :require_user :authorize

  def require_ssl
    if (request.protocol != "https://")
      options = { controller: controller_name, action: action_name, protocol: "https://" }
      options.merge!({ host: ENV["SSL_HOST"] }) unless ENV["SSL_HOST"].blank?
      flash.keep
      redirect_to url_for(options), :status => 301 and return
    end
  end

  def check_for_ssl
    if !use_ssl? && (request.protocol == "https://")
      options = { controller: controller_name, action: action_name, protocol: "http://" }
      options.merge!({ host: ENV["HOST"] }) unless ENV["HOST"].blank?
      flash.keep
      redirect_to url_for(options), :status => 301 and return
    end
  end

  private

  def use_ssl?
    callback = self._process_action_callbacks.find do |callback|
      callback.filter == :require_ssl
    end

    return false unless callback

    unless_options = (callback.options[:unless] + (callback.options[:except] || [])).collect(&:to_s)
    if_options = (callback.options[:if] + (callback.options[:only] || [])).collect(&:to_s)
    return false if unless_options.present? && unless_options.include?(action_name)
    return false if if_options.present? && !if_options.include?(action_name)

    true
  end

  def url_after_denied_access_when_signed_out
    options = { protocol: "https://" }
    options.merge!({ host: ENV["SSL_HOST"] }) unless ENV["SSL_HOST"].blank?
    login_url(options)
  end

end
