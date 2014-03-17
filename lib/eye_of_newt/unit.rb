# List of units was taken from the ingreedy project by Ian C. Anderson
# https://github.com/iancanderson/ingreedy/blob/34d83a7f345efd1522065ac57f5ff0e9735e57de/lib/ingreedy/ingreedy_parser.rb#L59

module EyeOfNewt
  class Unit
    class << self
      def units
        @units ||= {}
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
    end

    # english units
    set :cup, "c.", "c", "cup", "cups"
    set :fluid_ounce, "fl. oz.", "fl oz", "fluid ounce", "fluid ounces"
    set :gallon, "gal", "gal.", "gallon", "gallons"
    set :ounce, "oz", "oz.", "ounce", "ounces"
    set :pint, "pt", "pt.", "pint", "pints"
    set :pound, "lb", "lb.", "pound", "pounds"
    set :quart, "qt", "qt.", "qts", "qts.", "quart", "quarts"
    set :tablespoon, "tbsp.", "tbsp", "T", "T.", "tablespoon", "tablespoons", "tbs.", "tbs"
    set :teaspoon, "tsp.", "tsp", "t", "t.", "teaspoon", "teaspoons"

    # metric units
    set :gram, "g", "g.", "gr", "gr.", "gram", "grams"
    set :kilogram, "kg", "kg.", "kilogram", "kilograms"
    set :liter, "l", "l.", "liter", "liters"
    set :milligram, "mg", "mg.", "milligram", "milligrams"
    set :milliliter, "ml", "ml.", "milliliter", "milliliters"

    # nonstandard units
    set :pinch, "pinch", "pinches"
    set :dash, "dash", "dashes"
    set :touch, "touch", "touches"
    set :handful, "handful", "handfuls"
  end
end
