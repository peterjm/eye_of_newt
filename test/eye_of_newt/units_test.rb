require 'test_helper'

class EyeOfNewt::UnitsTest < ActiveSupport::TestCase

  test "#all returns the list of unit names" do
    units = EyeOfNewt::Units.new.setup do
      add_unit "foo", "f"
      add_unit "bar", "b"
    end
    assert_equal ["foo", "f", "bar", "b"], units.all
  end

  test "#default returns the default unit" do
    units = EyeOfNewt::Units.new.setup do
      add_unit "foo", "f", default: true
    end
    assert_equal "foo", units.default
  end

  test "#[] returns the canonical name of the unit" do
    units = EyeOfNewt::Units.new.setup do
      add_unit "foo", "f"
    end
    assert_equal "foo", units["f"]
    assert_equal "foo", units["foo"]
  end

  test "#[] raises an exception for unknown units" do
    units = EyeOfNewt::Units.new
    assert_raise EyeOfNewt::UnknownUnit do
      units["foo"]
    end
  end

  test "#conversion_rate throws an error for unknown conversions" do
    units = EyeOfNewt::Units.new.setup do
      add_unit "foo"
      add_unit "bar"
    end
    assert_raise EyeOfNewt::UnknownConversion do
      units.conversion_rate("foo", "bar")
    end
  end

  test "#conversion_rate succeeds for self-conversions" do
    units = EyeOfNewt::Units.new.setup do
      add_unit "foo"
    end
    assert_equal 1, units.conversion_rate("foo", "foo")
  end

  test "#conversion_rate returns the conversion rate" do
    units = EyeOfNewt::Units.new.setup do
      add_unit "foo"
      add_unit "bar"
      add_conversion 2, "foo", "bar"
    end
    assert_equal 2, units.conversion_rate("foo", "bar")
    assert_equal 0.5, units.conversion_rate("bar", "foo")
  end

  test "#conversion_rate can find indirect conversions" do
    units = EyeOfNewt::Units.new.setup do
      add_unit "foo"
      add_unit "bar"
      add_unit "baz"
      add_conversion 2, "foo", "bar"
      add_conversion 2, "bar", "baz"
    end
    assert_equal 4, units.conversion_rate("foo", "baz")
    assert_equal 0.25, units.conversion_rate("baz", "foo")
  end
end
