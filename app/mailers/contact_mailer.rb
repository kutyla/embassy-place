class ContactMailer < ActionMailer::Base
  self.default to: ENV["MAILER_TO"],
    from: ENV["MAILER_FROM"]

  def question_email(attributes={})
    @name = attributes[:name]
    @email = attributes[:email]
    @message = attributes[:message]
    @phone = attributes[:phone]

    mail({ subject: "Email from Site" })
  end

end
