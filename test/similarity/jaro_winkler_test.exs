defmodule JaroWinklerTest do
  use ExUnit.Case

  import TheFuzz.Similarity.JaroWinkler, only: [compare: 2]

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
    assert compare("aa", "a") == 0.8500000000000001
    assert compare("a", "aa") == 0.8500000000000001
    assert compare("veryveryverylong", "v") == 0.71875
    assert compare("v", "veryveryverylong") == 0.71875
    assert compare("martha", "marhta") == 0.9611111111111111
    assert compare("dwayne", "duane") == 0.8400000000000001
    assert compare("dixon", "dicksonx") == 0.8133333333333332
    assert compare("abcvwxyz", "cabvwxyz") == 0.9583333333333334
    assert compare("jones", "johnson") == 0.8323809523809523
    assert compare("henka", "henkan") == 0.9666666666666667
    assert compare("fvie", "ten") == 0

    assert compare("zac ephron", "zac efron") >
      compare("zac ephron", "kai ephron")
    assert compare("brittney spears", "britney spears") >
      compare("brittney spears", "brittney startzman")
  end
end
