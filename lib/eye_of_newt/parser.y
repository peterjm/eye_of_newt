class EyeOfNewt::Parser
token WORD NUMBER UNIT OF
rule
  ingredient
    : quantity ingredient_name style
    | quantity ingredient_name
    | ingredient_name style
    | ingredient_name
    ;
  ingredient_name
    : words { @ingredient.name = result }
    ;
  quantity
    : amount unit of
    | amount unit
    | amount of
    | amount
    ;
  amount
    : number { @ingredient.quantity = result }
    | number fraction { @ingredient.quantity = val[0] + val[1] }
    | decimal { @ingredient.quantity = result }
    ;
  style : ',' words { @ingredient.style = val[1] } ;
  words
    : word of words { result = val.join(' ') }
    | word words { result = val.join(' ') }
    | word
    ;
  of : OF ;
  word : WORD ;
  unit : UNIT { @ingredient.unit = to_unit(result) } ;
  number : NUMBER { result = val[0].to_i } ;
  fraction : NUMBER '/' NUMBER { result = val[0].to_f / val[2].to_f } ;
  decimal : NUMBER '.' NUMBER { result = val.join.to_f } ;
end

---- inner

  require 'eye_of_newt/ingredient'

  def initialize(tokenizer, ingredient = EyeOfNewt::Ingredient.new)
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
  end

  def to_unit(u)
    EyeOfNewt::Unit[u]
  end
