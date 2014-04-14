module EyeOfNewt
  class Unit
    def initialize(name, variations)
      @name = name.to_sym
      @variations = variations
    end

    def to_s
      @name.to_s
    end

    def to_sym
      @name
    end
  end
end
