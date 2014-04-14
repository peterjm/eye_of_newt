module EyeOfNewt
  class Units
    DEFAULT = 'units'

    attr_reader :units

    def initialize
      @units = {}
    end

    def all
      units.keys
    end

    def [](unit)
      units[unit]
    end

    def add(*names)
      register Unit.new(*names)
    end

    def register(unit)
      unit.names.each do |n|
        register_name(n, unit)
      end
    end

    def register_name(name, unit)
      units[name] = unit
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
