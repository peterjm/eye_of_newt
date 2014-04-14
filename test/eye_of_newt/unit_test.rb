require 'test_helper'

class EyeOfNewt::UnitTest < ActiveSupport::TestCase

  test "#name returns the first name" do
    unit = EyeOfNewt::Unit.new('foo', 'bar')
    assert_equal 'foo', unit.name
  end

end
