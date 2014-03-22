module EyeOfNewt
  class Ingredient
    attr_accessor :quantity, :unit, :name, :style

    def initialize
      self.quantity = 1
      self.unit = Unit::DEFAULT
    end
  end
end
