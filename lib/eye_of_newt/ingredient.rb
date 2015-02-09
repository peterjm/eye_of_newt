module EyeOfNewt
  class Ingredient
    attr_accessor :amount, :unit, :unit_modifier, :name, :style, :note

    def initialize(amount: nil, unit: nil, unit_modifier: nil, name: nil, style: nil, note: nil)
      self.amount = amount
      self.unit = unit
      self.unit_modifier = unit_modifier
      self.name = name
      self.style = style
      self.note = note
    end
  end
end
