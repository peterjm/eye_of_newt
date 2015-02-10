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
      new_amount = range? ? amount.map{|a| a * rate} : amount * rate
      self.class.new(new_amount, new_unit, units: units)
    end

    def to_s
      amount_str = range? ? amount.map{|a| fraction_str(a)}.join('–') : fraction_str(amount)
      [amount_str, modifier, unit_str].compact.join(' ')
    end
    alias :inspect :to_s

    private

    def range?
      amount.is_a?(Array)
    end

    def fraction_str(a)
      return nil if units.unquantified?(unit)
      fraction = to_fraction(a)
      whole = fraction.to_i
      fractional = fraction - whole
      [whole, fractional].reject(&:zero?).join(' ')
    end

    def unit_str
      return nil if unit == units.default
      singular = range? ? amount.last <= 1 : amount <= 1
      singular ? unit.singularize : unit
    end

    def to_fraction(a)
      signif(a, SIGNIFICANT_DIGITS).to_r.rationalize(DELTA)
    end

    def signif(value, digits)
      Float("%.#{digits}g" % value)
    end
  end
end
