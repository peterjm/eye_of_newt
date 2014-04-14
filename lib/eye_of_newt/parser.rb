#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.11
# from Racc grammer file "".
#

require 'racc/parser.rb'
module EyeOfNewt
  class Parser < Racc::Parser


  def initialize(tokenizer, ingredient: EyeOfNewt::Ingredient.new)
    @tokenizer = tokenizer
    @ingredient = ingredient
    super()
  end

  def next_token
    @tokenizer.next_token
  end

  def parse
    do_parse
    @ingredient
  rescue Racc::ParseError
    raise InvalidIngredient, @tokenizer.string
  end

  def to_unit(u)
    EyeOfNewt::Unit[u]
  end
##### State transition tables begin ###

racc_action_table = [
   -19,    11,    15,    25,    14,    13,    11,   -19,    11,    14,
    13,    14,    13,    11,    23,    14,    14,    13,    27,    28,
    20,    29,    20,    16,    14,    27,    33,    34 ]

racc_action_check = [
     9,     0,     0,     6,     0,     0,     2,     9,    20,     2,
     2,    20,    20,    10,     5,     5,    10,    10,    15,    15,
     3,    16,    17,     1,    21,    25,    27,    28 ]

racc_action_pointer = [
    -1,    23,     4,    13,   nil,    10,     0,   nil,   nil,     0,
    11,   nil,   nil,   nil,   nil,    10,    21,    15,   nil,   nil,
     6,    19,   nil,   nil,   nil,    17,   nil,    23,    24,   nil,
   nil,   nil,   nil,   nil,   nil ]

racc_action_default = [
   -27,   -27,   -27,    -4,    -5,    -9,   -10,   -12,   -13,   -14,
   -17,   -18,   -20,   -21,   -22,   -24,   -27,    -2,   -19,    -3,
   -27,    -7,    -8,   -23,   -11,   -27,   -16,   -27,   -27,    35,
    -1,   -15,    -6,   -25,   -26 ]

racc_goto_table = [
    22,    19,    26,     7,     3,    21,    17,     5,     1,    24,
     6,     2,    31,     8,     9,    30,    32 ]

racc_goto_check = [
     8,     4,     5,    10,     3,     7,     3,     6,     1,    10,
     9,     2,     5,    11,    12,     4,     8 ]

racc_goto_pointer = [
   nil,     8,    11,     4,    -2,    -8,     7,     0,    -5,    10,
     3,    13,    14,   nil ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,     4,   nil,   nil,    12,   nil,
   nil,   nil,    18,    10 ]

racc_reduce_table = [
  0, 0, :racc_error,
  3, 11, :_reduce_none,
  2, 11, :_reduce_none,
  2, 11, :_reduce_none,
  1, 11, :_reduce_none,
  1, 13, :_reduce_5,
  3, 12, :_reduce_none,
  2, 12, :_reduce_none,
  2, 12, :_reduce_none,
  1, 12, :_reduce_none,
  1, 16, :_reduce_10,
  2, 16, :_reduce_11,
  1, 16, :_reduce_12,
  1, 16, :_reduce_13,
  1, 16, :_reduce_14,
  2, 14, :_reduce_15,
  2, 15, :_reduce_16,
  1, 15, :_reduce_none,
  1, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 22, :_reduce_none,
  1, 18, :_reduce_none,
  1, 17, :_reduce_23,
  1, 19, :_reduce_24,
  3, 20, :_reduce_25,
  3, 21, :_reduce_26 ]

racc_reduce_n = 27

racc_shift_n = 35

racc_token_table = {
  false => 0,
  :error => 1,
  :WORD => 2,
  :NUMBER => 3,
  :UNIT => 4,
  :OF => 5,
  :A => 6,
  "," => 7,
  "/" => 8,
  "." => 9 }

racc_nt_base = 10

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "WORD",
  "NUMBER",
  "UNIT",
  "OF",
  "A",
  "\",\"",
  "\"/\"",
  "\".\"",
  "$start",
  "ingredient",
  "quantity",
  "ingredient_name",
  "style",
  "words",
  "amount",
  "unit",
  "of",
  "number",
  "fraction",
  "decimal",
  "a",
  "word" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

# reduce 2 omitted

# reduce 3 omitted

# reduce 4 omitted

def _reduce_5(val, _values, result)
 @ingredient.name = result 
    result
end

# reduce 6 omitted

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

def _reduce_10(val, _values, result)
 @ingredient.amount = result 
    result
end

def _reduce_11(val, _values, result)
 @ingredient.amount = val[0] + val[1] 
    result
end

def _reduce_12(val, _values, result)
 @ingredient.amount = result 
    result
end

def _reduce_13(val, _values, result)
 @ingredient.amount = result 
    result
end

def _reduce_14(val, _values, result)
 @ingredient.amount = 1 
    result
end

def _reduce_15(val, _values, result)
 @ingredient.style = val[1] 
    result
end

def _reduce_16(val, _values, result)
 result = val.join(' ') 
    result
end

# reduce 17 omitted

# reduce 18 omitted

# reduce 19 omitted

# reduce 20 omitted

# reduce 21 omitted

# reduce 22 omitted

def _reduce_23(val, _values, result)
 @ingredient.unit = to_unit(result) 
    result
end

def _reduce_24(val, _values, result)
 result = val[0].to_i 
    result
end

def _reduce_25(val, _values, result)
 result = val[0].to_f / val[2].to_f 
    result
end

def _reduce_26(val, _values, result)
 result = val.join.to_f 
    result
end

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module EyeOfNewt
