defmodule TheFuzz.Similarity.WeightedLevenshtein do
  @moduledoc """
  This module contains function to calculate the weighted levenshtein distance 
  between 2 given strings.
  """
  require IEx
  @behaviour TheFuzz.StringMetric

  @default_delete_cost 1
  @default_insert_cost 1
  @default_replace_cost 1

  @doc """
  Calculates the weighted levenshtein distance between the given strings with 
  the costs of insert, delete, replace as 1.

  ## Examples
      iex> TheFuzz.Similarity.WeightedLevenshtein.compare("kitten", "sitting")
      3
      iex> TheFuzz.Similarity.WeightedLevenshtein.compare("sunday", "saturday")
      3 
  """
  def compare(a, b) when byte_size(a) == 0 or byte_size(b) == 0, do: nil
  def compare(a, b) when a == b, do: 0
  def compare(a, b) do
    compare(a, b, %{delete: @default_delete_cost,
      insert: @default_insert_cost,
      replace: @default_replace_cost
    })
  end

  @doc """
  Calculates the weighted levenshtein distance between the given strings with 
  costs for insert, delete and replace provided as a Map in the third argument.

  ## Examples
      iex> weights = %{delete: 10, insert: 0.1, replace: 1}
      iex> TheFuzz.Similarity.WeightedLevenshtein.compare("book", "back", weights)
      2
      iex> weights = %{delete: 10, insert: 1, replace: 1}
      iex> TheFuzz.Similarity.WeightedLevenshtein.compare("clms blvd", "columbus boulevard", weights)
      9
  """
  def compare(a, b, _) when byte_size(a) == 0 or byte_size(b) == 0, do: nil
  def compare(a, b, _) when a == b, do: 0
  def compare(a, b, %{} = weights) do
    distance(a |> String.to_char_list, b |> String.to_char_list, weights)
  end

  defp store_result(key, result, cache) do
    {result, Dict.put(cache, key, result)}
  end

  defp distance(a, b, weights) do
    distance(a, b, weights, HashDict.new) |> elem(0)
  end
  defp distance(a, [] = b, %{delete: delete_cost}, cache) do
    store_result({a, b}, delete_cost * length(a), cache)
  end
  defp distance([] = a, b, %{insert: insert_cost}, cache) do
    store_result({a, b}, insert_cost * length(b), cache)
  end
  defp distance([x | rest1], [x | rest2], weights, cache) do
    distance(rest1, rest2, weights, cache)
  end
  defp distance([_ | rest1] = a, [_ | rest2] = b, %{
    delete: delete_cost,
    insert: insert_cost,
    replace: replace_cost
  } = weights, cache) do
    case Dict.has_key?(cache, {a, b}) do
      true -> {Dict.get(cache, {a, b}), cache}
      false ->
        {l1, c1} = distance(a, rest2, weights, cache)
        {l2, c2} = distance(rest1, b, weights, c1)
        {l3, c3} = distance(rest1, rest2, weights, c2)

        min = :lists.min([l1 + insert_cost, l2 + delete_cost, l3 + replace_cost])
        store_result({a, b}, min, c3)
    end
  end
end