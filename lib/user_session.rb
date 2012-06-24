class UserSession < ActiveResource::Base
  attr_accessor :email, :password

  def initialize(attributes={})
    attributes.each do |attribute, value|
      send("#{attribute}=", value)
    end
  end

  def authenticate!
    User.authenticate(email, password) if valid?
  end

  def valid?
    (email.present? && password.present?)
  end

end
