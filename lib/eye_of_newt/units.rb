module EyeOfNewt
  class Units
    DEFAULT = :units

    attr_reader :units

    def initialize
      @units = {}
    end

    def all
      units.keys
    end

    def canonical(unit)
      units[unit]
    end
    alias :[] :canonical

    def set(canonical, *variations)
      variations.each do |v|
        units[v] = canonical.to_sym
      end
    end

    def setup(&block)
      instance_eval &block
      self
    end

    def self.defaults
      new.setup do
        # List of units was taken from the ingreedy project by Ian C. Anderson
        # https://github.com/iancanderson/ingreedy/blob/34d83a7f345efd1522065ac57f5ff0e9735e57de/lib/ingreedy/ingreedy_parser.rb#L59

        # english units
        set :cups, "c.", "c", "cup", "cups"
        set :fluid_ounces, "fl. oz.", "fl oz", "fluid ounce", "fluid ounces"
        set :gallons, "gal", "gal.", "gallon", "gallons"
        set :ounces, "oz", "oz.", "ounce", "ounces"
        set :pints, "pt", "pt.", "pint", "pints"
        set :pounds, "lb", "lb.", "pound", "pounds"
        set :quarts, "qt", "qt.", "qts", "qts.", "quart", "quarts"
        set :tablespoons, "tbsp.", "tbsp", "T", "T.", "tablespoon", "tablespoons", "tbs.", "tbs"
        set :teaspoons, "tsp.", "tsp", "t", "t.", "teaspoon", "teaspoons"

        # metric units
        set :grams, "g", "g.", "gr", "gr.", "gram", "grams"
        set :kilograms, "kg", "kg.", "kilogram", "kilograms"
        set :liters, "l", "l.", "liter", "liters", "litre", "litres"
        set :milligrams, "mg", "mg.", "milligram", "milligrams"
        set :milliliters, "ml", "ml.", "milliliter", "milliliters", "millilitre", "millilitres"

        # nonstandard units
        set :pinches, "pinch", "pinches"
        set :dashes, "dash", "dashes"
        set :touches, "touch", "touches"
        set :handfuls, "handful", "handfuls"
        set :units, "units", "unit"
      end
    end
  end
end
