require "test/unit"
require File.expand_path('../../../lib/permalink', __FILE__)

class PermalinkTest < Test::Unit::TestCase
  def setup
    #
  end

  def test_should_downcase_string
    assert_equal 'foo', Permalink.new("FoO")
  end

  def test_should_replace_spaces
    assert_equal 'foo-bar', Permalink.new("foo bar")
  end

  def test_should_remove_invalid_characers
    assert_equal 'foobar', Permalink.new("f~o#o&b!ar")
  end

end
