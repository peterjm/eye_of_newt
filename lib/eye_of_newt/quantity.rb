module EyeOfNewt
  class Quantity
    attr_reader :amount, :unit, :units

    def initialize(amount, unit, units=EyeOfNewt.units)
      @amount = amount
      @unit = unit
      @units = units
    end

    def in(new_unit)
      rate = units.conversion_rate(unit, new_unit)
      self.class.new(amount * rate, new_unit)
    end
  end
end
