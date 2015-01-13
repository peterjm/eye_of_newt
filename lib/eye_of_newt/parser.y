class EyeOfNewt::Parser
token WORD NUMBER UNIT TEXT OF A TO_TASTE
rule
  ingredient
    : quantity ingredient_name style
    | quantity ingredient_name
    | ingredient_name to_taste style
    | ingredient_name to_taste
    | ingredient_name style
    | ingredient_name
    ;
  ingredient_name
    : words { @ingredient.name = result }
    ;
  quantity
    : amount unit OF
    | amount unit
    | amount OF
    | amount
    ;
  amount
    : number { @ingredient.amount = result }
    | number fraction { @ingredient.amount = val[0] + val[1] }
    | fraction { @ingredient.amount = result }
    | decimal { @ingredient.amount = result }
    | A { @ingredient.amount = 1 }
    ;
  to_taste : TO_TASTE { @ingredient.unit = to_unit(result) } ;
  style : ',' text { @ingredient.style = val[1] } ;
  words
    : word words { result = val.join(' ') }
    | word
    ;
  text : TEXT
  word : WORD | A | OF ;
  unit : UNIT { @ingredient.unit = to_unit(result) } ;
  number : NUMBER { result = val[0].to_i } ;
  fraction : NUMBER '/' NUMBER { result = val[0].to_f / val[2].to_f } ;
  decimal : NUMBER '.' NUMBER { result = val.join.to_f } ;
end

---- inner

  def initialize(tokenizer, units:, ingredient: nil)
    @tokenizer = tokenizer
    @units = units
    @ingredient = ingredient || default_ingredient
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
    @units[u]
  end

  def default_ingredient
    EyeOfNewt::Ingredient.new(amount: 1, unit: @units.default)
  end
