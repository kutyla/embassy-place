class Permalink
  INVALID_CHARACTERS = %r{[^A-Za-z0-9-]}

  attr_accessor :string

  def self.new(string)
    begin
      @string = string.dup
      @string.downcase!
      replace_spaces!
      replace_invalid_characters!
      @string
    rescue
      ''
    end
  end

  private

  def self.replace_spaces!
    @string.gsub!(/\s/, '-')
  end

  def self.replace_invalid_characters!
    @string.gsub!(INVALID_CHARACTERS, '')
  end

end
