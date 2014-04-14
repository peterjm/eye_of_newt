module EyeOfNewt
  class UnknownConversion < StandardError

    def initialize(from, to)
      super(%Q{Can't convert from "#{from}" to "#{to}"})
    end

  end
end
