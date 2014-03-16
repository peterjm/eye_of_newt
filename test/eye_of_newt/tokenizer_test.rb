require 'test_helper'
require 'eye_of_newt/tokenizer'

class EyeOfNewt::TokenizerTest < ActiveSupport::TestCase
  test "tokenizes WORD" do
    t = tok("hello world")
    assert_equal [:WORD, "hello"], t.next_token
    assert_equal [:WORD, "world"], t.next_token
    assert_equal false, t.next_token
  end

  test "tokenizes fractions" do
    t = tok("1 1/2")
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal ['/', '/'], t.next_token
    assert_equal [:NUMBER, "2"], t.next_token
    assert_equal false, t.next_token
  end

  test "tokenizes words start with a number as WORD" do
    t = tok("1word")
    assert_equal [:WORD, "1word"], t.next_token
  end

  test "tokenizes recognized units as UNIT" do
    t = tok("1 cup spinach", ["cup"])
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal [:UNIT, "cup"], t.next_token
    assert_equal [:WORD, "spinach"], t.next_token
  end

  def tok(string, units=[])
    EyeOfNewt::Tokenizer.new(string, units)
  end
end
