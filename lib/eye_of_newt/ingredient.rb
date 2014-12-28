module EyeOfNewt
  class Ingredient
    attr_accessor :amount, :unit, :name, :style

    def initialize(amount: nil, unit: nil, name: nil, style: nil)
      self.amount = amount
      self.unit = unit
      self.name = name
      self.style = style
    end
  end
end
