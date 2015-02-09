require 'test_helper'

class EyeOfNewt::QuantityTest < ActiveSupport::TestCase

  def units
    EyeOfNewt::Units.new.setup do
      add_unit "foo"
      add_unit "bar"
      add_conversion 2, "foo", "bar"
    end
  end

  test "#in returns a quantity in the new unit" do
    bar = EyeOfNewt::Quantity.new(1, "bar", units: units)
    foo = bar.in("foo")
    assert_equal 0.5, foo.amount
    assert_equal "foo", foo.unit
  end

  test "#to_s makes appropriate strings" do
    assert_equal "1", EyeOfNewt::Quantity.new(1, "unit").to_s
    assert_equal "1/2", EyeOfNewt::Quantity.new(0.5, "units").to_s
    assert_equal "1/2 tbsp", EyeOfNewt::Quantity.new(0.5, "tbs").to_s
    assert_equal "1 1/2 tbsp", EyeOfNewt::Quantity.new(1.5, "tbs").to_s
    assert_equal "1000 g", EyeOfNewt::Quantity.new(1001, "grams").to_s
    assert_equal "1/3 g", EyeOfNewt::Quantity.new(0.33, "grams").to_s
    assert_equal "to taste", EyeOfNewt::Quantity.new(1, "to taste").to_s
    assert_equal "1 heaping tsp", EyeOfNewt::Quantity.new(1, "teaspoon", modifier: "heaping").to_s
  end

end
