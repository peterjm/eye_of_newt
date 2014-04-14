module EyeOfNewt
  class InvalidIngredient < StandardError

    attr_accessor :original

    def initialize(line, original=nil)
      super(%Q{Could not parse "#{line}" as ingredient})
      self.original = original
    end

  end
end
