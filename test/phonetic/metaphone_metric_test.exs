defmodule MetaphoneMetricTest do
  use ExUnit.Case

  import TheFuzz.Phonetic.MetaphoneMetric, only: [compare: 2]

  test "returns nil with empty argument" do
    assert compare("", "") == nil
    assert compare("abc", "") == nil
    assert compare("", "xyz") == nil
  end

  test "returns nil with non-phonetic arguments" do
    assert compare("123", "123") == nil
    assert compare("123", "") == nil
    assert compare("", "123") == nil
  end

  test "returns true with phonetically similar arguments" do
    assert compare("dumb", "dum") == true
    assert compare("smith", "smeth") == true
    assert compare("merci", "mercy") == true
  end

  test "returns false with phonetically dissimilar arguments" do
    assert compare("dumb", "gum") == false
    assert compare("smith", "kiss") == false
    assert compare("merci", "burpy") == false
  end
end
