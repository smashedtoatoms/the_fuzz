defmodule DiceSorensenTest do
  use ExUnit.Case

  import TheFuzz.Similarity.DiceSorensen, only: [compare: 2, compare: 3]

  test "returns nil with empty arguments" do
    assert compare("", "", 1) == nil
    assert compare("abc", "", 1) == nil
    assert compare("", "xyz", 1) == nil
    assert compare("", "") == nil
    assert compare("abc", "") == nil
    assert compare("", "xyz") == nil
  end

  test "return 1 with equal arguments" do
    assert compare("a", "a", 1) == 1
    assert compare("abc", "abc", 2) == 1
    assert compare("123", "123", 3) == 1
    assert compare("abc", "abc") == 1
    assert compare("123", "123") == 1
  end

  test "return 0 with unequal arguments" do
    assert compare("abc", "xyz", 1) == 0
    assert compare("123", "456", 2) == 0
    assert compare("fff", "xxx", 3) == 0
    assert compare("abc", "xyz") == 0
    assert compare("123", "456") == 0
    assert compare("fff", "xxx") == 0
  end

  test "returns nil with invalid arguments" do
    assert compare("n", "naght") == nil
    assert compare("night", "n") == nil
    assert compare("n", "naght", 2) == nil
    assert compare("night", "n", 2) == nil
    assert compare("ni", "naght", 3) == nil
    assert compare("night", "na", 3) == nil
  end

  test "return distance with valid arguments" do
    assert compare("night", "nacht", 1) == 0.6
    assert compare("night", "naght", 1) == 0.8
    assert compare("context", "contact", 1) == 0.7142857142857143

    assert compare("night", "nacht", 2) == 0.25
    assert compare("night", "naght", 2) == 0.5
    assert compare("context", "contact", 2) == 0.5
    assert compare("contextcontext", "contact", 2) == 0.3157894736842105
    assert compare("context", "contactcontact", 2) == 0.3157894736842105
    assert compare("ht", "nacht", 2) == 0.4
    assert compare("xp", "nacht", 2) == 0
    assert compare("ht", "hththt", 2) == 0.3333333333333333
    assert compare("night", "nacht") == 0.25
    assert compare("night", "naght") == 0.5
    assert compare("context", "contact") == 0.5
    assert compare("contextcontext", "contact") == 0.3157894736842105
    assert compare("context", "contactcontact") == 0.3157894736842105
    assert compare("ht", "nacht") == 0.4
    assert compare("xp", "nacht") == 0
    assert compare("ht", "hththt") == 0.3333333333333333

    assert compare("night", "nacht", 3) == 0
    assert compare("night", "naght", 3) == 0.3333333333333333
    assert compare("context", "contact", 3) == 0.4
  end
end
