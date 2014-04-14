require 'test_helper'

class EyeOfNewt::UnitsTest < ActiveSupport::TestCase

  test "#[] returns the canonical name of the unit" do
    units = EyeOfNewt::Units.new
    units.add "foo", "bar"
    assert_equal "foo", units["foo"]
    assert_equal "foo", units["bar"]
  end

  test "#conversion_rate throws an error for unknown conversions" do
    units = EyeOfNewt::Units.new
    assert_raise EyeOfNewt::UnknownConversion do
      units.conversion_rate("foo", "bar")
    end
  end

  test "#conversion_rate succeeds for self-conversions" do
    units = EyeOfNewt::Units.new
    units.add "foo"
    assert_equal 1, units.conversion_rate("foo", "foo")
  end

  test "#conversion_rate returns the conversion rate" do
    units = EyeOfNewt::Units.new
    units.add "foo", "bar" => 2
    units.add "bar"
    assert_equal 2, units.conversion_rate("foo", "bar")
    assert_equal 0.5, units.conversion_rate("bar", "foo")
  end

  test "#conversion_rate can find indirect conversions" do
    units = EyeOfNewt::Units.new
    units.add "foo", "bar" => 2
    units.add "bar", "baz" => 2
    units.add "baz"
    assert_equal 4, units.conversion_rate("foo", "baz")
    assert_equal 0.25, units.conversion_rate("baz", "foo")
  end

end
