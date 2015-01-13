module EyeOfNewt
  class Ingredient
    attr_accessor :amount, :unit, :name, :style, :note

    def initialize(amount: nil, unit: nil, name: nil, style: nil, note: nil)
      self.amount = amount
      self.unit = unit
      self.name = name
      self.style = style
      self.note = note
    end
  end
end
