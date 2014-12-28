require 'active_support/core_ext/module/attribute_accessors'

module EyeOfNewt

  require "eye_of_newt/version"

  require "eye_of_newt/tokenizer"
  require "eye_of_newt/parser"
  require "eye_of_newt/ingredient"
  require "eye_of_newt/units"
  require "eye_of_newt/quantity"
  require "eye_of_newt/errors"

  mattr_accessor :units
  self.units = Units.defaults

  def self.parse(ingredient_line, units: self.units)
    tokenizer = Tokenizer.new(ingredient_line)
    parser = Parser.new(tokenizer, units: units)
    parser.parse
  end

end
