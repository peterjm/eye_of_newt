require 'test_helper'

class EyeOfNewt::UnitsTest < ActiveSupport::TestCase

  test "#[] returns the canonical name of the unit" do
    units = EyeOfNewt::Units.new
    units.add "foo", "bar"
    assert_equal "foo", units["foo"]
    assert_equal "foo", units["bar"]
  end

end
