defmodule TheFuzz.Similarity.DiceSorensen do
  @moduledoc """
  This module contains functions to calculate the Sorensen-Dice coefficient of
  2 given strings.
  """
  require IEx
  import TheFuzz.Util, only: [ngram_tokenize: 2, intersect: 2]

  @behaviour TheFuzz.StringMetric
  @default_ngram_size 2

  @doc """
  Calculates the Sorensen-Dice coefficient of two given strings with the ngram
  size set to a default value of 2.
  ## Examples
      iex> TheFuzz.Similarity.DiceSorensen.compare("night", "nacht")
      0.25
      iex> TheFuzz.Similarity.DiceSorensen.compare("context", "contact")
      0.5
  """
  def compare(a, b) when is_binary(a) and is_binary(b) do
    compare(a, b, @default_ngram_size)
  end

  @doc """
  Calculates the Sorensen-Dice coefficient of two given strings with a
  specified ngram size passed as the third argument.
  ## Examples
      iex> TheFuzz.Similarity.DiceSorensen.compare("night", "nacht", 1)
      0.6
      iex> TheFuzz.Similarity.DiceSorensen.compare("night", "nacht", 2)
      0.25
      iex> TheFuzz.Similarity.DiceSorensen.compare("night", "nacht", 3)
      0.0
  """
  def compare(a, b, ngram_size)
      when ngram_size == 0 or byte_size(a) < ngram_size or byte_size(b) < ngram_size,
      do: nil

  def compare(a, b, _ngram_size) when a == b, do: 1

  def compare(a, b, ngram_size) do
    a_ngrams = a |> ngram_tokenize(ngram_size)
    b_ngrams = b |> ngram_tokenize(ngram_size)
    nmatches = intersect(a_ngrams, b_ngrams) |> length
    2 * nmatches / (length(a_ngrams) + length(b_ngrams))
  end
end
