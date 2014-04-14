module EyeOfNewt
  class Units
    DEFAULT = 'units'

    attr_reader :units, :conversions

    def initialize
      @units = {}
      @conversions = Hash.new { |h, k| h[k] = {} }
    end

    def all
      units.keys
    end

    def [](unit)
      units[unit]
    end

    def add(canonical, *variations)
      c = variations.last.is_a?(Hash) ? variations.pop : {}

      units[canonical] = canonical
      variations.each do |v|
        units[v] = canonical
      end

      conversions[canonical][canonical] = 1
      c.each do |other_unit, value|
        conversions[canonical][other_unit] = value.to_r
        conversions[other_unit][canonical] ||= 1 / value.to_r
      end
    end

    def conversion_rate(from, to)
      r = search_conversion(from, to) or raise UnknownConversion.new(from, to)
      r.to_f
    end

    def search_conversion(from, to, rate=1, visited=[])
      return rate if from == to
      visited = visited + [from]
      conversions[from].each do |k, r|
        next if visited.include?(k)
        value = search_conversion(k, to, rate*r, visited)
        return value if value
      end
      nil
    end

    def setup(&block)
      instance_eval &block
      self
    end

    def self.defaults
      new.setup do
        # english volume units
        add "cups", "c.", "c", "cup"
        add "fluid ounces", "fl. oz.", "fl oz", "fluid ounce"
        add "gallons", "gal", "gal.", "gallon"
        add "pints", "pt", "pt.", "pint"
        add "quarts", "qt", "qt.", "qts", "qts.", "quart"
        add "tablespoons", "tbsp.", "tbsp", "T", "T.", "tbs.", "tbs", "tablespoon"
        add "teaspoons", "tsp.", "tsp", "t", "t.", "teaspoon"

        # english mass units
        add "pounds", "lb", "lb.", "pound"
        add "ounces", "oz", "oz.", "ounce"

        # metric volume units
        add "liters", "l", "l.", "liter", "litre", "litres"
        add "milligrams", "mg", "mg.", "milligram"
        add "milliliters", "ml", "ml.", "milliliter", "millilitre", "millilitres"

        # metric mass units
        add "grams", "g", "g.", "gr", "gr.", "gram"
        add "kilograms", "kg", "kg.", "kilogram"

        # nonstandard units
        add "pinches", "pinch"
        add "dashes", "dash"
        add "touches", "touch"
        add "handfuls", "handful"
        add "units", "unit"
      end
    end
  end
end
