require 'test_helper'
require 'eye_of_newt'

class EyeOfNewtTest < ActiveSupport::TestCase
  def self.examples
    examples_file = File.expand_path("examples.txt", File.dirname(__FILE__))
    File.open(examples_file) do |f|
      f.read.each_line.map { |line|
        next if line.starts_with?('#')
        next if line.strip.blank?

        tokens = line.split('|').map(&:strip)
        line = tokens.shift
        name = tokens.shift
        amount = tokens.shift.split('-').map(&:to_f)
        amount = amount.first unless amount.many?
        unit = tokens.shift.presence
        style = tokens.shift.presence
        note = tokens.shift.presence
        unit_modifier = tokens.shift.presence
        expected = [name, amount, unit, style, note, unit_modifier]
        [line, expected]
      }.compact
    end
  end

  examples.each do |line, expected|
    test "parses #{line} correctly" do
      ingr = EyeOfNewt.parse(line)
      name, amount, unit, style, note, unit_modifier = *expected
      assert_equal name, ingr.name, %Q{incorrect name}
      assert_equal amount, ingr.amount, %Q{incorrect amount}
      assert_equal unit, ingr.unit, %Q{incorrect unit}
      assert_equal style, ingr.style, %Q{incorrect style}
      assert_equal note, ingr.note, %Q{incorrect note}
      assert_equal unit_modifier, ingr.unit_modifier, %Q{incorrect unit modifier}
    end
  end

  test "raises InvalidIngredient on invalid input" do
    assert_raise EyeOfNewt::InvalidIngredient do
      EyeOfNewt.parse("1")
    end
  end
end
