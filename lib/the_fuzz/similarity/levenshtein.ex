defmodule TheFuzz.Similarity.Levenshtein do
  @moduledoc """
  This module contains functions to calculate the levenshtein distance between 
  given strings.
  """
  require IEx
  @behaviour TheFuzz.StringMetric

  @doc """
  Calculates the levenshtein distance between two given strings.
  
  Note: All operations [INSERT, DELETE, REPLACE/SUBSTITUTE] are considered 
  with a cost of 1. For custom weights and limited operations use
  WeightedLevenshtein 

  ## Examples
      iex> TheFuzz.Similarity.Levenshtein.compare("saturday", "sunday")
      3
      iex> TheFuzz.Similarity.Levenshtein.compare("book", "back")
      2
  """
  def compare(a, b) when byte_size(a) == 0 or byte_size(b) == 0, do: nil
  def compare(a, b) when a == b, do: 0
  def compare(a, b) do
    distance(a |> String.to_charlist, b |> String.to_charlist)
  end

  defp store_result(key, result, cache) do
    {result, Map.put(cache, key, result)}
  end

  defp distance(a, b), do: distance(a, b, Map.new) |> elem(0)
  defp distance(a, [] = b, cache), do: store_result({a, b}, length(a), cache)
  defp distance([] = a, b, cache), do: store_result({a, b}, length(b), cache)
  defp distance([x | rest1], [x | rest2], cache) do
    distance(rest1, rest2, cache)
  end
  defp distance([_ | rest1] = a, [_ | rest2] = b, cache) do
    case Map.has_key?(cache, {a, b}) do
      true -> {Map.get(cache, {a, b}), cache}
      false ->
        {l1, c1} = distance(a, rest2, cache)
        {l2, c2} = distance(rest1, b, c1)
        {l3, c3} = distance(rest1, rest2, c2)

        min = :lists.min([l1, l2, l3]) + 1
        store_result({a, b}, min, c3)
    end
  end
end
