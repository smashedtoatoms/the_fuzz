defmodule TheFuzz.Similarity.NGram do
  @moduledoc """
  This module contains functions to calculate the ngram distance between two 
  given strings based on this 
  [paper](webdocs.cs.ualberta.ca/~kondrak/papers/spire05.pdf)
  """
  require IEx
  import TheFuzz.Util, only: [ngram_tokenize: 2, intersect: 2]

  @behaviour TheFuzz.StringMetric
  @default_ngram_size 2

  @doc """
  Calculates the ngram similarity between two given strings with a default 
  ngram size of 2

  ## Examples
      iex> TheFuzz.Similarity.NGram.compare("context", "contact")
      0.5
      iex> TheFuzz.Similarity.NGram.compare("ht", "nacht")
      0.25
  """
  def compare(a, b) when is_binary(a) and is_binary(b) do
    compare(a, b, @default_ngram_size)
  end

  @doc """
  Calculates the ngram similarity between two given strings with a specified 
  ngram size

  ## Examples
      iex> TheFuzz.Similarity.NGram.compare("night", "naght", 3)
      0.3333333333333333
      iex> TheFuzz.Similarity.NGram.compare("context", "contact", 1)
      0.7142857142857143
  """
  def compare(a, b, ngram_size) when ngram_size == 0 or
    byte_size(a) < ngram_size or byte_size(b) < ngram_size, do: nil
  def compare(a, b, _ngram_size) when a == b, do: 1
  def compare(a, b, ngram_size) do
    a_ngrams = a |> ngram_tokenize(ngram_size)
    b_ngrams = b |> ngram_tokenize(ngram_size)
    nmatches = intersect(a_ngrams, b_ngrams) |> length
    nmatches / max(length(a_ngrams), length(b_ngrams))
  end
end
