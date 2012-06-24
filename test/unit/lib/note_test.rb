require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  def setup
    #
  end

  test "should initialize attributes" do
    note = Note.new({ message: "a message", email: "an email"})
    assert_equal note.message, "a message"
    assert_equal note.email, "an email"
  end

  # valid?
  test "should validate email" do
    note = Note.new({ message: Faker::Lorem.paragraphs, email: Faker::Internet.email, name: Faker::Company.name })
    assert note.valid?
    note.email = nil
    assert !note.valid?
    note.email = "not an email"
    assert !note.valid?
  end

  test "should validate message" do
    note = Note.new({ message: Faker::Lorem.paragraphs, email: Faker::Internet.email, name: Faker::Company.name })
    assert note.valid?
    note.message = nil
    assert !note.valid?
  end

  test "should validate name" do
    note = Note.new({ message: Faker::Lorem.paragraphs, email: Faker::Internet.email, name: Faker::Company.name })
    assert note.valid?
    note.name = nil
    assert !note.valid?
  end

end
