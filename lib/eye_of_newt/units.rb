require 'active_support/core_ext/hash/deep_merge'

module EyeOfNewt
  class Units
    DEFAULT = 'units'

    attr_reader :units, :conversions, :default

    def initialize(default: DEFAULT)
      @units = {}
      @conversions = Hash.new { |h, k| h[k] = {} }
      @default = default
    end

    def all
      units.keys
    end

    def [](unit)
      units[unit] or raise UnknownUnit.new(unit)
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

    def conversion_rate(from, to, extra: {})
      f = self[from]
      t = self[to]
      c = conversions.deep_merge(extra)
      r = search_conversion(f, t, c) or raise UnknownConversion.new(from, to)
      r.to_f
    end

    def search_conversion(from, to, conversions, rate=1, visited=[])
      return rate if from == to
      visited = visited + [from]
      conversions[from].each do |k, r|
        next if visited.include?(k)
        value = search_conversion(k, to, conversions, rate*r, visited)
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
        add "cups", "c.", "c", "cup", "tbsp" => 16, "fl oz" => 8, "ml" => 235
        add "fl oz", "fl. oz.", "fluid ounces", "fluid ounce"
        add "gallons", "gal", "gal.", "gallon", "quarts" => 4
        add "pints", "pt", "pt.", "pint", "cups" => 2
        add "quarts", "qt", "qt.", "qts", "qts.", "quart", "pints" => 2
        add "tbsp", "tbsp.", "T", "T.", "tbs.", "tbs", "tablespoons", "tablespoon", "tsp" => 3
        add "tsp", "tsp.", "t", "t.", "teaspoons", "teaspoon"

        # english mass units
        add "lb", "lb.", "pounds", "pound", "oz" => 16, "g" => 454
        add "oz", "oz.", "ounces", "ounce"

        # metric volume units
        add "l", "l.", "liter", "liters", "litre", "litres", "ml" => 1000
        add "ml", "ml.", "milliliter", "milliliters", "millilitre", "millilitres"

        # metric mass units
        add "kg", "kg.", "kilogram", "kilograms", "g" => 1000
        add "g", "g.", "gr", "gr.", "gram", "grams", "mg" => 1000
        add "mg", "mg", "mg.", "milligram", "milligrams"

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
