defmodule WeightedLevenshteinTest do
  use ExUnit.Case

  import TheFuzz.Similarity.WeightedLevenshtein, only: [compare: 2, compare: 3]

  test "returns nil with empty arguments" do
    assert compare("", "", %{delete: 10, insert: 0.1, replace: 1}) == nil
    assert compare("abc", "", %{delete: 10, insert: 0.1, replace: 1}) == nil
    assert compare("", "xyz", %{delete: 10, insert: 0.1, replace: 1}) == nil
  end

  test "return 1 with equal arguments" do
    assert compare("a", "a", %{delete: 10, insert: 0.1, replace: 1}) == 0
    assert compare("abc", "abc", %{delete: 10, insert: 0.1, replace: 1}) == 0
    assert compare("123", "123", %{delete: 10, insert: 0.1, replace: 1}) == 0
  end

  test "return distance with unequal arguments" do
    assert compare("abc", "xyz", %{delete: 10, insert: 0.1, replace: 1}) == 3
    assert compare("123", "456", %{delete: 10, insert: 0.1, replace: 1}) == 3
  end

  test "return distance with valid arguments" do
    weights_1 = %{delete: 10, insert: 0.1, replace: 1}
    weights_2 = %{delete: 10, insert: 1, replace: 1}
    assert compare("az", "z", weights_1) == 10
    assert compare("z", "az", weights_1) == 0.1
    assert compare("a", "z", weights_1) == 1
    assert compare("z", "a", weights_1) == 1
    assert compare("ab", "yz", weights_1) == 2
    assert compare("yz", "ab", weights_1) == 2
    assert compare("0", "0123456789", weights_1) == 0.9
    assert compare("0123456789", "0", weights_1) == 90
    assert compare("book", "back", weights_1) == 2
    assert compare("back", "book", weights_1) == 2
    assert compare("hosp", "hospital", weights_1) == 0.4
    assert compare("hospital", "hosp", weights_1) == 40
    assert compare("clms blvd", "columbus boulevard", weights_2) == 9
    assert compare("columbus boulevard", "clmbs blvd", weights_1) == 80
  end
end
