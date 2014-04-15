require 'test_helper'

class EyeOfNewt::QuantityTest < ActiveSupport::TestCase

  test "#in returns a quantity in the new unit" do
    units = EyeOfNewt::Units.new
    units.add "foo", "bar" => 2
    units.add "bar"

    bar = EyeOfNewt::Quantity.new(1, "bar", units: units)
    foo = bar.in("foo")
    assert_equal 0.5, foo.amount
    assert_equal "foo", foo.unit
  end

  test "#to_s makes appropriate strings" do
    assert_equal "1", EyeOfNewt::Quantity.new(1, "unit").to_s
    assert_equal "1/2", EyeOfNewt::Quantity.new(0.5, "unit").to_s
    assert_equal "1/2 tablespoon", EyeOfNewt::Quantity.new(0.5, "tbs").to_s
    assert_equal "1 1/2 tablespoons", EyeOfNewt::Quantity.new(1.5, "tbs").to_s
    assert_equal "1000 grams", EyeOfNewt::Quantity.new(1001, "grams").to_s
    assert_equal "1/3 gram", EyeOfNewt::Quantity.new(0.33, "grams").to_s
  end

end
