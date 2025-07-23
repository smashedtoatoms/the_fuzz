defmodule TheFuzz.Similarity.DamerauLevenshtein do
  @moduledoc """
  This module contains functions to calculate the Damerau-Levenshtein distance between
  given strings.
  """
  @behaviour TheFuzz.StringMetric

  @doc """
  Calculates the Damerau-Levenshtein distance between two given strings.

  ## examples
      iex> TheFuzz.Similarity.DamerauLevenshtein.compare("saturday", "sunday")
      3
      iex> TheFuzz.Similarity.DamerauLevenshtein.compare("fuor", "four")
      1
  """
  def compare(a, b) when byte_size(a) == 0 or byte_size(b) == 0, do: nil
  def compare(a, b) when a == b, do: 0

  def compare(s1, s2) do
    len1 = String.length(s1)
    len2 = String.length(s2)

    chars1 = String.to_charlist(s1)
    chars2 = String.to_charlist(s2)

    d = initialize_score_matrix(s1, s2)

    {d, _da} =
      Enum.reduce(Enum.with_index(chars1, 1), {d, %{}}, fn {char1, i}, {d, da} ->
        {d, da, _db} =
          Enum.reduce(Enum.with_index(chars2, 1), {d, da, 0}, fn {char2, j}, {d, da, db} ->
            k = Map.get(da, char2, 0)
            l = db
            {db, cost} = if char1 == char2, do: {j, 0}, else: {db, 1}

            substitution = d[{i - 1, j - 1}] + cost
            insertion = d[{i, j - 1}] + 1
            deletion = d[{i - 1, j}] + 1
            transposition = d[{k - 1, l - 1}] + (i - k - 1) + 1 + (j - l - 1)
            new_score = substitution |> min(insertion) |> min(deletion) |> min(transposition)

            {Map.put(d, {i, j}, new_score), Map.put(da, char1, i), db}
          end)

        {d, da}
      end)

    d[{len1, len2}]
  end

  defp initialize_score_matrix(s1, s2) do
    len1 = String.length(s1)
    len2 = String.length(s2)
    maxdist = len1 + len2

    score = %{{-1, -1} => maxdist}

    score =
      Enum.reduce(0..len1, score, fn i, acc ->
        acc
        |> Map.put({i, -1}, maxdist)
        |> Map.put({i, 0}, i)
      end)

    score =
      Enum.reduce(0..len2, score, fn j, acc ->
        acc
        |> Map.put({-1, j}, maxdist)
        |> Map.put({0, j}, j)
      end)

    score
  end
end
