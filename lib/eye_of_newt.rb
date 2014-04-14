require "eye_of_newt/version"

require "eye_of_newt/tokenizer"
require "eye_of_newt/parser"
require "eye_of_newt/ingredient"
require "eye_of_newt/unit"
require "eye_of_newt/units"
require "eye_of_newt/invalid_ingredient"

module EyeOfNewt

  class << self

    def units
      @units ||= Units.defaults
    end

    def units=(value)
      @units = value
    end

    def parse(ingredient_line)
      tokenizer = EyeOfNewt::Tokenizer.new(ingredient_line)
      parser = EyeOfNewt::Parser.new(tokenizer)
      parser.parse
    end

  end

end
