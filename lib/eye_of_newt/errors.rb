module EyeOfNewt
  class EyeOfNewtError < StandardError; end

  class UnknownUnit < EyeOfNewtError
    def initialize(unit)
      super(%Q{Unknown unit '#{unit}'})
    end
  end

  class UnknownConversion < EyeOfNewtError
    def initialize(from, to)
      super(%Q{Can't convert from "#{from}" to "#{to}"})
    end
  end

  class InvalidIngredient < EyeOfNewtError
    attr_accessor :original
    def initialize(line, original=nil)
      super(%Q{Could not parse "#{line}" as ingredient})
      self.original = original
    end
  end
end
