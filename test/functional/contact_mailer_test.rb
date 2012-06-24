require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase
  def test_contact_email
    attributes = {
      name: Faker::Company.name,
      email: Faker::Internet.email,
      message: Faker::Lorem.paragraphs
    }
    email = ContactMailer.question_email(attributes).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [ContactMailer.default_params[:to]], email.to
    assert_equal "Email from Site", email.subject
    assert_match(/#{attributes[:message]}/, email.encoded)
  end
end
