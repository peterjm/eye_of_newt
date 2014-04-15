require 'active_support/core_ext/module/attribute_accessors'

require "eye_of_newt/version"

require "eye_of_newt/tokenizer"
require "eye_of_newt/parser"
require "eye_of_newt/ingredient"
require "eye_of_newt/units"
require "eye_of_newt/quantity"
require "eye_of_newt/errors"

module EyeOfNewt

  mattr_accessor :units
  self.units = Units.defaults

  def self.parse(ingredient_line)
    tokenizer = EyeOfNewt::Tokenizer.new(ingredient_line)
    parser = EyeOfNewt::Parser.new(tokenizer)
    parser.parse
  end

end
