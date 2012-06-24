class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Clearance::User

  field :name
  field :email
  field :encrypted_password
  field :salt
  field :confirmation_token
  field :remember_token

  class << self
    # Clearance Overrides
    def find_by_email(email)
      where({ :email => email }).first
    end

    def find_by_remember_token(token)
      where({ :remember_token => token }).first
    end
  end

end
