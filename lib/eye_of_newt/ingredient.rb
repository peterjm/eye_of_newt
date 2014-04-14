module EyeOfNewt
  class Ingredient
    attr_accessor :amount, :unit, :name, :style

    def initialize
      self.amount = 1
      self.unit = Units::DEFAULT
    end
  end
end
