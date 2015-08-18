defmodule TheFuzz.Similarity.Jaccard do
  @moduledoc """
  This module contains functions to calculate the [Jaccard similarity 
  coefficient](https://en.wikipedia.org/wiki/Jaccard_index) between two given 
  strings
  """
  import TheFuzz.Util, only: [ngram_tokenize: 2, intersect: 2]

  @behaviour TheFuzz.StringMetric
  @default_ngram_size 2

  @doc """
  Calculates the Jaccard similarity coefficient between two given strings with
  a default ngram size of 2

  ## Examples
      iex> TheFuzz.Similarity.Jaccard.compare("contact", "context")
      0.3333333333333333
      iex> TheFuzz.Similarity.Jaccard.compare("ht", "hththt")
      0.2
  """
  def compare(a, b) do
    compare(a, b, @default_ngram_size)
  end

  @doc """
  Calculates the Jaccard similarity coefficient between two given strings with
  the specified ngram size

  ## Examples
      iex> TheFuzz.Similarity.Jaccard.compare("contact", "context", 3)
      0.25
      iex> TheFuzz.Similarity.Jaccard.compare("contact", "context", 1)
      0.5555555555555556
  """
  def compare(a, b, n) when n <= 0 or byte_size(a) < n
    or byte_size(b) < n, do: nil
  def compare(a, b, _n) when a == b, do: 1
  def compare(a, b, ngram_size) do
    a_ngrams = a |> ngram_tokenize(ngram_size)
    b_ngrams = b |> ngram_tokenize(ngram_size)
    nmatches = intersect(a_ngrams, b_ngrams) |> length
    (nmatches)/(length(a_ngrams) + length(b_ngrams) - nmatches)
  end
end
