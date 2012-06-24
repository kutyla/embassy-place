class Note < ActiveResource::Base
  # Regex taken from https://github.com/thoughtbot/clearance
  VALID_EMAIL = %r{^[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$}i

  attr_accessor :email, :message, :name, :phone

  def initialize(attributes={})
    attributes.each do |attribute, value|
      send("#{attribute}=", value)
    end
  end

  def valid?
    (email.present? && email.match(VALID_EMAIL) && message.present? && name.present?)
  end

end
