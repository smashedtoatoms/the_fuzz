defmodule DamerauLevenshteinTest do
  use ExUnit.Case

  import TheFuzz.Similarity.DamerauLevenshtein, only: [compare: 2]

  test "returns nil with empty arguments" do
    assert compare("", "") == nil
    assert compare("abc", "") == nil
    assert compare("", "xyz") == nil
  end

  test "return 1 with equal arguments" do
    assert compare("a", "a") == 0
    assert compare("abc", "abc") == 0
    assert compare("123", "123") == 0
  end

  test "return distance with unequal arguments" do
    assert compare("abc", "xyz") == 3
    assert compare("123", "456") == 3
  end

  test "return distance with valid arguments" do
    assert compare("abc", "a") == 2
    assert compare("a", "abc") == 2
    assert compare("abc", "c") == 2
    assert compare("c", "abc") == 2
    assert compare("abc", "cba") == 2
    assert compare("cba", "abc") == 2
    assert compare("ca", "abc") == 2
    assert compare("abc", "ca") == 2
    assert compare("sitting", "kitten") == 3
    assert compare("kitten", "sitting") == 3
    assert compare("cake", "drake") == 2
    assert compare("drake", "cake") == 2
    assert compare("saturday", "sunday") == 3
    assert compare("sunday", "saturday") == 3
    assert compare("book", "back") == 2
    assert compare("dog", "fog") == 1
    assert compare("foq", "fog") == 1
    assert compare("fvg", "fog") == 1
    assert compare("encyclopedia", "encyclopediaz") == 1
    assert compare("encyclopediz", "encyclopediaz") == 1
  end
end
