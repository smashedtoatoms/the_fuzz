defmodule TheFuzz.Similarity.Tversky do
  @moduledoc """
  This module contains functions to calculate the [Tversky index
  ](https://en.wikipedia.org/wiki/Tversky_index) between two given
  strings
  """
  import TheFuzz.Util, only: [ngram_tokenize: 2, intersect: 2]

  @behaviour TheFuzz.StringMetric
  @default_ngram_size 1
  @default_alpha 1
  @default_beta 1

  @doc """
  Calculates the Tversky index between two given strings with
  a default ngram size of 1, alpha of 1 and beta of 1

  This is equivalent of Tanimoto coefficient

  ## Examples
      iex> TheFuzz.Similarity.Tversky.compare("contact", "context")
      0.5555555555555556
      iex> TheFuzz.Similarity.Tversky.compare("ht", "hththt")
      0.3333333333333333
  """
  def compare(a, b) do
    compare(a, b, %{n_gram_size: @default_ngram_size, alpha: @default_alpha, beta: @default_beta})
  end

  @doc """
  Calculates the Tversky index between two given strings with
  the specified options passed as a map of key, value pairs.

  #### Options
  - **n_gram_size**: positive integer greater than 0, to tokenize the strings
  - **alpha**: weight of the prototype sequence
  - **beta**: weight of the variant sequence

  Note: If any of them is not specified as part of the options object
  they are set to the default value of 1

  ## Examples
      iex> TheFuzz.Similarity.Tversky.compare("contact", "context", %{n_gram_size: 4, alpha: 2, beta: 0.8})
      0.10638297872340426
      iex> TheFuzz.Similarity.Tversky.compare("contact", "context", %{n_gram_size: 2, alpha: 0.5, beta: 0.5})
      0.5
  """
  def compare(a, b, %{n_gram_size: n}) when n <= 0 or byte_size(a) < n or byte_size(b) < n,
    do: nil

  def compare(a, b, _n) when a == b, do: 1

  def compare(a, b, %{n_gram_size: n, alpha: alpha, beta: beta}) do
    n = n || @default_ngram_size
    alpha = alpha || @default_alpha
    beta = beta || @default_beta

    a_ngrams = a |> ngram_tokenize(n)
    b_ngrams = b |> ngram_tokenize(n)

    nmatches = intersect(a_ngrams, b_ngrams) |> length

    a_diff_length = (a_ngrams -- b_ngrams) |> length
    b_diff_length = (b_ngrams -- a_ngrams) |> length

    nmatches / (alpha * a_diff_length + beta * b_diff_length + nmatches)
  end
end
