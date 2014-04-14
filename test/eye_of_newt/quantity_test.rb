require 'test_helper'

class EyeOfNewt::QuantityTest < ActiveSupport::TestCase

  test "#in returns a quantity in the new unit" do
    units = EyeOfNewt::Units.new
    units.add "foo", "bar" => 2
    units.add "bar"
    bar = EyeOfNewt::Quantity.new(1, "bar", units)
    foo = bar.in("foo")
    assert_equal 0.5, foo.amount
    assert_equal "foo", foo.unit
  end

end
