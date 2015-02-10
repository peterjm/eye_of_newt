module EyeOfNewt
  class Ingredient
    attr_accessor :amount, :unit, :unit_modifier, :names, :style, :note

    def initialize(amount: nil, unit: nil, unit_modifier: nil, names: [], style: nil, note: nil)
      self.amount = amount
      self.unit = unit
      self.unit_modifier = unit_modifier
      self.names = names
      self.style = style
      self.note = note
    end

    def name
      names.first
    end

    def name=(n)
      self.names = [n]
    end
  end
end
