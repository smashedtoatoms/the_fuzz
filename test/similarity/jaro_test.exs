defmodule JaroTest do
  use ExUnit.Case

  import TheFuzz.Similarity.Jaro, only: [compare: 2]

  test "returns nil with empty arguments" do
    assert compare("", "") == nil
    assert compare("abc", "") == nil
    assert compare("", "xyz") == nil
  end

  test "return 1 with equal arguments" do
    assert compare("a", "a") == 1
    assert compare("abc", "abc") == 1
    assert compare("123", "123") == 1
  end

  test "return 0 with unequal arguments" do
    assert compare("abc", "xys") == 0
    assert compare("123", "456") == 0
  end

  test "return distance with valid arguments" do
    assert compare("aa", "a") == 0.8333333333333334
    assert compare("a", "aa") == 0.8333333333333334
    assert compare("veryveryverylong", "v") == 0.6875
    assert compare("v", "veryveryverylong") == 0.6875
    assert compare("martha", "marhta") == 0.9444444444444445
    assert compare("dwayne", "duane") == 0.8222222222222223
    assert compare("dixon", "dicksonx") == 0.7666666666666666
    assert compare("abcvwxyz", "cabvwxyz") == 0.9583333333333334
    assert compare("jones", "johnson") == 0.7904761904761904
    assert compare("henka", "henkan") == 0.9444444444444445
    assert compare("fvie", "ten") == 0

    assert compare("zac ephron", "zac efron") > 
      compare("zac ephron", "kai ephron")
    assert compare("brittney spears", "britney spears") > 
      compare("brittney spears", "brittney startzman")
  end
end