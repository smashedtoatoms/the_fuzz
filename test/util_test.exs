defmodule UtilTest do
  use ExUnit.Case

  import TheFuzz.Util, only: [ngram_tokenize: 2, intersect: 2]

  test "intersect" do
    assert Enum.sort(intersect(~c"content", ~c"contextcontext")) == ~c"cennott"
    assert Enum.sort(intersect(~c"contextcontext", ~c"content")) == ~c"cennott"
  end

  test "ngram_tokenize empty string" do
    assert(ngram_tokenize("", 1) == nil)
  end

  test "ngram_tokenize 1" do
    desired_result = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z"
    ]

    result = ngram_tokenize("abcdefghijklmnopqrstuvwxyz", 1)
    assert(result == desired_result)
  end

  test "ngram_tokenize 2" do
    desired_result = [
      "ab",
      "bc",
      "cd",
      "de",
      "ef",
      "fg",
      "gh",
      "hi",
      "ij",
      "jk",
      "kl",
      "lm",
      "mn",
      "no",
      "op",
      "pq",
      "qr",
      "rs",
      "st",
      "tu",
      "uv",
      "vw",
      "wx",
      "xy",
      "yz"
    ]

    result = ngram_tokenize("abcdefghijklmnopqrstuvwxyz", 2)
    assert(result == desired_result)
  end

  test "ngram_tokenize 3" do
    desired_result = [
      "abc",
      "bcd",
      "cde",
      "def",
      "efg",
      "fgh",
      "ghi",
      "hij",
      "ijk",
      "jkl",
      "klm",
      "lmn",
      "mno",
      "nop",
      "opq",
      "pqr",
      "qrs",
      "rst",
      "stu",
      "tuv",
      "uvw",
      "vwx",
      "wxy",
      "xyz"
    ]

    result = ngram_tokenize("abcdefghijklmnopqrstuvwxyz", 3)
    assert(result == desired_result)
  end
end
