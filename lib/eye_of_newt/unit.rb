module EyeOfNewt
  class Unit
    attr_reader :names

    def initialize(*names)
      @names = names
    end

    def name
      names.first
    end
    alias_method :to_s, :name

  end
end
