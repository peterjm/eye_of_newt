require 'test_helper'

class EyeOfNewt::UnitTest < ActiveSupport::TestCase

  test "#to_s returns the name as a string" do
    unit = EyeOfNewt::Unit.new(:foo, [])
    assert_equal 'foo', unit.to_s
  end

  test "#to_sym returns the name as a symbol" do
    unit = EyeOfNewt::Unit.new(:foo, [])
    assert_equal :foo, unit.to_sym
  end

end
