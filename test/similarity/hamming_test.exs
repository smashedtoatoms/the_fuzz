defmodule HammingTest do
  use ExUnit.Case

  import TheFuzz.Similarity.Hamming, only: [compare: 2]

  test "returns nil with empty arguments" do
    assert compare("", "") == nil
    assert compare("abc", "") == nil
    assert compare("", "xyz") == nil
  end

  test "return nil with unequal string length arguments" do
    assert compare("abc", "wxyz") == nil
    assert compare("123", "3456") == nil
    assert compare("fff", "xxxx") == nil
  end

  test "return 0 with equal arguments" do
    assert compare("abc", "abc") == 0
    assert compare("123", "123") == 0
  end

  test "return distance with unequal arguments" do
    assert compare("abc", "xyz") == 3
    assert compare("123", "456") == 3
    assert compare("fff", "xxx") == 3
  end

  test "returns distance with valid arguments" do
    assert compare("toned", "roses") == 3
    assert compare("1011101", "1001001") == 2
    assert compare("2173896", "2233796") == 3
  end
end
