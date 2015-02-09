require 'active_support/core_ext/string/inflections'

module EyeOfNewt
  class Quantity
    DELTA = 0.01
    SIGNIFICANT_DIGITS = 3

    attr_reader :amount, :unit, :modifier, :units

    def initialize(amount, unit, modifier: nil, units: EyeOfNewt.units)
      @amount = amount
      @units = units
      @unit = units[unit]
      @modifier = modifier
    end

    def in(new_unit)
      rate = units.conversion_rate(unit, new_unit)
      self.class.new(amount * rate, new_unit, units: units)
    end

    def to_s
      [fraction_str, modifier, unit_str].compact.join(' ')
    end
    alias :inspect :to_s

    private

    def fraction_str
      return nil if units.unquantified?(unit)
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
