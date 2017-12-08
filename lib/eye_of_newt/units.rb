require 'active_support/core_ext/hash/deep_merge'

module EyeOfNewt
  class Units
    attr_reader :units, :conversions, :unit_modifiers, :default

    def initialize
      @units = {}
      @conversions = Hash.new { |h, k| h[k] = {} }
      @unit_modifiers = []
      @default = nil
      @unquantified = []
    end

    def all
      units.keys
    end

    def [](unit)
      units[unit] or raise UnknownUnit.new(unit)
    end

    def add_unit(canonical, *variations, default: false, unquantified: false)
      units[canonical] = canonical
      variations.each do |v|
        units[v] = canonical
      end

      @unquantified << canonical if unquantified
      @default = canonical if default

      conversions[canonical][canonical] = 1
    end

    def add_conversion(amount, unit, other_unit)
      unit = self[unit]
      other_unit = self[other_unit]

      new_conversion = {unit => {other_unit => amount.to_r}, other_unit => {unit => 1/amount.to_r}}
      conversions.deep_merge!(new_conversion)
    end

    def add_unit_modifier(modifier)
      unit_modifiers << modifier
    end

    def conversion_rate(from, to)
      f = self[from]
      t = self[to]
      r = search_conversion(f, t) or raise UnknownConversion.new(from, to)
      r.to_f
    end

    def unquantified?(unit)
      @unquantified.include?(self[unit])
    end

    def setup(&block)
      instance_eval(&block)
      self
    end

    def self.defaults
      new.setup do
        # english volume units
        add_unit "cups", "c.", "c", "cup"
        add_unit "fl oz", "fl. oz.", "fluid ounces", "fluid ounce"
        add_unit "gallons", "gal", "gal.", "gallon"
        add_unit "pints", "pt", "pt.", "pint"
        add_unit "quarts", "qt", "qt.", "qts", "qts.", "quart"
        add_unit "tbsp", "tbsp.", "T", "T.", "tbs.", "tbs", "tablespoons", "tablespoon"
        add_unit "tsp", "tsp.", "t", "t.", "teaspoons", "teaspoon"

        # english mass units
        add_unit "lb", "lb.", "pounds", "pound"
        add_unit "oz", "oz.", "ounces", "ounce"

        # metric volume units
        add_unit "l", "l.", "liter", "liters", "litre", "litres"
        add_unit "ml", "ml.", "milliliter", "milliliters", "millilitre", "millilitres"

        # metric mass units
        add_unit "kg", "kg.", "kilogram", "kilograms"
        add_unit "g", "g.", "gr", "gr.", "gram", "grams"
        add_unit "mg", "mg", "mg.", "milligram", "milligrams"

        # english distance units
        add_unit "inch", "inches"

        # nonstandard units
        add_unit "pinches", "pinch"
        add_unit "dashes", "dash"
        add_unit "touches", "touch"
        add_unit "handfuls", "handful"
        add_unit "cloves", "clove"
        add_unit "bunches", "bunch"
        add_unit "sprigs", "sprig"
        add_unit "cans", "can"
        add_unit "packages", "package"
        add_unit "containers", "container"
        add_unit "sticks", "stick"

        add_unit_modifier "big"
        add_unit_modifier "large"
        add_unit_modifier "medium"
        add_unit_modifier "small"
        add_unit_modifier "heaping"
        add_unit_modifier "level"
        add_unit_modifier "scant"

        # unquantified units
        add_unit "to taste", unquantified: true

        add_unit "units", "unit", default: true

        add_conversion 16, "tbsp", "cup"
        add_conversion 8, "fl oz", "cup"
        add_conversion 235, "ml", "cup"
        add_conversion 4, "quarts", "gallon"
        add_conversion 2, "cups", "pint"
        add_conversion 2, "pints", "quart"
        add_conversion 3, "tsp", "tbsp"

        add_conversion 16, "oz", "pound"
        add_conversion 454, "grams", "pound"

        add_conversion 1000, "ml", "liter"

        add_conversion 1000, "g", "kg"
        add_conversion 1000, "mg", "g"
      end
    end

    private

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

  end
end
