require "eye_of_newt/version"

require "eye_of_newt/tokenizer"
require "eye_of_newt/parser"
require "eye_of_newt/ingredient"

module EyeOfNewt
  class InvalidIngredient < StandardError
    attr_accessor :original
    def initialize(line, original=nil)
      super(%Q{Could not parse "#{line}" as ingredient})
      self.original = original
    end
  end

  def self.parse(ingredient_line)
    tokenizer = EyeOfNewt::Tokenizer.new(ingredient_line)
    parser = EyeOfNewt::Parser.new(tokenizer)
    parser.parse
  rescue Racc::ParseError
    raise InvalidIngredient, ingredient_line
  end

end
