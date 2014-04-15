require 'active_support/core_ext/string/inflections'

module EyeOfNewt
  class Quantity
    DELTA = 0.01
    SIGNIFICANT_DIGITS = 3

    attr_reader :amount, :unit, :units

    def initialize(amount, unit, units: EyeOfNewt.units)
      @amount = amount
      @unit = units[unit]
      @units = units
    end

    def in(new_unit, conversions: {})
      rate = units.conversion_rate(unit, new_unit, extra: conversions)
      self.class.new(amount * rate, new_unit, units: units)
    end

    def to_s
      [fraction_str, unit_str].compact.join(' ')
    end
    alias :inspect :to_s

    private

    def fraction_str
      whole = fraction.to_i
      fractional = fraction - whole
      [whole, fractional].reject(&:zero?).join(' ')
    end

    def unit_str
      return nil if unit == units.default
      singular = fraction <= 1 && fraction.numerator == 1
      singular ? unit.singularize : unit
    end

    def fraction
      @fraction ||= signif(amount, SIGNIFICANT_DIGITS).to_r.rationalize(DELTA)
    end

    def signif(value, digits)
      Float("%.#{digits}g" % value)
    end
  end
end
