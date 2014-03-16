require 'strscan'

module EyeOfNewt
  class Tokenizer
    NO_MATCH = /^&%#&^%/

    WHITESPACE = /\s+/
    WORD = /\b\w+\b/
    NUMBER = /\b\d+\b/

    def initialize(string, units=[])
      @units = units
      @ss = StringScanner.new(string)
    end

    def next_token
      return false if @ss.eos?

      @ss.scan(WHITESPACE)

      case
      when text = @ss.scan(NUMBER) then [:NUMBER, text]
      when text = @ss.scan(unit_matcher) then [:UNIT, text]
      when text = @ss.scan(WORD) then [:WORD, text]
      else
        x = @ss.getch
        [x, x]
      end
    end

    private

    def unit_matcher
      @unit_matcher ||= @units.any? ? Regexp.new(@units.join("|")) : NO_MATCH
    end
  end
end
