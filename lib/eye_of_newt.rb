require "eye_of_newt/version"

require "eye_of_newt/tokenizer"
require "eye_of_newt/parser"
require "eye_of_newt/ingredient"

module EyeOfNewt

  def self.parse(ingredient_line)
    tokenizer = EyeOfNewt::Tokenizer.new(ingredient_line)
    parser = EyeOfNewt::Parser.new(tokenizer)
    parser.parse
  end

end
