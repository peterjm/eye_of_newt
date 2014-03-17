require 'strscan'
require 'eye_of_newt/unit'

module EyeOfNewt
  class Tokenizer
    NO_MATCH = /^&%#&^%/

    WHITESPACE = /\s+/
    WORD = /[\w-]+/
    NUMBER = /\d+/

    def initialize(string, units=Unit.all)
      @units = units
      @ss = StringScanner.new(string)
    end

    def next_token
      return if @ss.eos?

      @ss.scan(WHITESPACE)

      case
      when text = @ss.scan(NUMBER)
        [:NUMBER, text]
      when text = @ss.scan(/#{unit_matcher}\b/)
        [:UNIT, text]
      when text = @ss.scan(/#{WORD}\b/)
        [:WORD, text]
      else
        x = @ss.getch
        [x, x]
      end
    end

    private

    def unit_matcher
      @unit_matcher ||= if @units.any?
        r = @units
          .sort
          .reverse
          .map{|u|Regexp.escape(u)}
          .join("|")
        Regexp.new(r)
      else
        NO_MATCH
      end
    end
  end
end
