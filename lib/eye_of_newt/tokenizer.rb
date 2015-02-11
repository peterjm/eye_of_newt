require 'strscan'

module EyeOfNewt
  class Tokenizer
    NO_MATCH = /a^/ # should never match anything

    WHITESPACE = /\s+/
    ANYTHING = /[^()]+/
    WORD = /\w+(-\w+)*/
    NUMBER = /\d+/
    OF = /of/i
    OR = /or/i
    A = /an?/i
    TO_TASTE = /to taste/i

    attr_reader :string, :units, :unit_modifiers

    def initialize(string, units: EyeOfNewt.units.all, unit_modifiers: EyeOfNewt.units.unit_modifiers)
      @string = string
      @units = units
      @unit_modifiers = unit_modifiers
      @ss = StringScanner.new(string)
    end

    def next_token
      return if @ss.eos?

      @ss.scan(WHITESPACE)

      case
      when @scan_text && text = @ss.scan(/#{ANYTHING}\b/)
        @scan_text = false
        [:TEXT, text]
      when text = @ss.scan(NUMBER)
        [:NUMBER, text]
      when text = @ss.scan(/#{OF}\b/)
        [:OF, text]
      when text = @ss.scan(/#{A}\b/)
        [:A, text]
      when text = @ss.scan(/#{OR}\b/)
        [:OR, text]
      when text = @ss.scan(/#{TO_TASTE}\b/)
        [:TO_TASTE, text]
      when text = @ss.scan(/#{unit_matcher}\b/)
        [:UNIT, text]
      when text = @ss.scan(/#{unit_modifier}\b/)
        [:UNIT_MODIFIER, text]
      when text = @ss.scan(/#{WORD}\b/)
        [:WORD, text]
      else
        x = @ss.getch
        @scan_text = true if x == ',' || x == '('
        [x, x]
      end
    end

    private

    def unit_modifier
      @unit_modifier_matcher ||= match_any(unit_modifiers)
    end

    def unit_matcher
      @unit_matcher ||= match_any(units)
    end

    def match_any(elements)
      if elements.any?
        r = elements
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
