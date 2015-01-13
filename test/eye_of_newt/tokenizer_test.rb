require 'test_helper'

class EyeOfNewt::TokenizerTest < ActiveSupport::TestCase
  test "tokenizes WORD" do
    t = tok("hello world to-day")
    assert_equal [:WORD, "hello"], t.next_token
    assert_equal [:WORD, "world"], t.next_token
    assert_equal [:WORD, "to-day"], t.next_token
    assert_nil t.next_token
  end

  test "tokenizes TEXT after a comma" do
    t = tok(", cut into 2-inch chunks")
    assert_equal [',', ","], t.next_token
    assert_equal [:TEXT, "cut into 2-inch chunks"], t.next_token
    assert_nil t.next_token
  end

  test "tokenizes TO_TASTE" do
    t = tok("salt to taste")
    assert_equal [:WORD, "salt"], t.next_token
    assert_equal [:TO_TASTE, "to taste"], t.next_token
    assert_nil t.next_token
  end

  test "tokenizes OF" do
    t = tok("piece of cake")
    assert_equal [:WORD, "piece"], t.next_token
    assert_equal [:OF, "of"], t.next_token
    assert_equal [:WORD, "cake"], t.next_token
    assert_nil t.next_token
  end

  test "tokenizes fractions" do
    t = tok("1 1/2")
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal ['/', '/'], t.next_token
    assert_equal [:NUMBER, "2"], t.next_token
    assert_nil t.next_token
  end

  test "tokenizes recognized units as UNIT" do
    t = tok("1 cup spinach", ["cup"])
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal [:UNIT, "cup"], t.next_token
    assert_equal [:WORD, "spinach"], t.next_token
  end

  test "recognizes the longest version of UNIT" do
    t = tok("1 cup", ["c", "cup"])
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal [:UNIT, "cup"], t.next_token
  end

  test "does not recognize partial units" do
    t = tok("tomato", ["t"])
    assert_equal [:WORD, "tomato"], t.next_token
  end

  test "does not require a space between number and unit" do
    t = tok("1ml", ["ml"])
    assert_equal [:NUMBER, "1"], t.next_token
    assert_equal [:UNIT, "ml"], t.next_token
  end

  def tok(string, units=[])
    EyeOfNewt::Tokenizer.new(string, units: units)
  end
end
