module Clearance
  module Authentication
    def sign_in(user)
      if user
        cookies[:remember_token] = {
          value: user.remember_token,
          expires: Clearance.configuration.cookie_expiration.call,
          domain: ".#{ENV['DOMAIN']}"
        }
        self.current_user = user
      end
    end
  end
end
