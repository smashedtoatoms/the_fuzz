defmodule TheFuzz.Similarity.Overlap do
  @moduledoc """
  Implements the [Overlap Similarity Metric](http://en.wikipedia.org/wiki/
  Overlap_coefficient)
  """

  import TheFuzz.Util, only: [ngram_tokenize: 2, intersect: 2]

  @doc """
  Compares two values using the Overlap Similarity metric and returns the 
  coefficient.  It takes the ngram size as the third argument, and, if
  none is provided, assumes that you want to use 1.
  ## Examples
      iex> TheFuzz.Similarity.Overlap.compare("compare me", "to me")
      0.8
      TheFuzz.Similarity.Overlap.compare("compare me", "to me", 2)
      0.8
      iex> TheFuzz.Similarity.Overlap.compare("or me", "me", 1)
      1.0
  """
  def compare(a, b), do: compare(a, b, 1)
  def compare(a, b, n) do
    cond do
      n <= 0 || String.length(a) < n || String.length(b) < n -> nil
      a == b -> 1.0
      true ->
        tokens_a = ngram_tokenize(a, n)
        tokens_b = ngram_tokenize(b, n)
        ms = intersect(tokens_a, tokens_b) |> length
        ms / min(length(tokens_a), length(tokens_b))
    end
  end
end