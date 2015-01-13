require 'strscan'

module EyeOfNewt
  class Tokenizer
    NO_MATCH = /a^/ # should never match anything

    WHITESPACE = /\s+/
    ANYTHING = /[^()]+/
    WORD = /[\w-]+/
    NUMBER = /\d+/
    OF = /of/
    A = /an?/
    TO_TASTE = /to taste/
    COMMA = ','

    attr_reader :string, :units

    def initialize(string, units: EyeOfNewt.units.all)
      @string = string
      @units = units
      @ss = StringScanner.new(string)
    end

    def next_token
      return if @ss.eos?

      @ss.scan(WHITESPACE)

      case
      when @scan_text && text = @ss.scan(/#{ANYTHING}\b/)
        [:TEXT, text]
      when text = @ss.scan(NUMBER)
        [:NUMBER, text]
      when text = @ss.scan(/#{OF}\b/)
        [:OF, text]
      when text = @ss.scan(/#{A}\b/)
        [:A, text]
      when text = @ss.scan(/#{TO_TASTE}\b/)
        [:TO_TASTE, text]
      when text = @ss.scan(/#{unit_matcher}\b/)
        [:UNIT, text]
      when text = @ss.scan(/#{WORD}\b/)
        [:WORD, text]
      else
        x = @ss.getch
        @scan_text = true if x == ',' || x == '('
        [x, x]
      end
    end

    private

    def unit_matcher
      @unit_matcher ||= if units.any?
        r = units
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
