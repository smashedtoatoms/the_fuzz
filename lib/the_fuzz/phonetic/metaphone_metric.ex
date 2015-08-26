defmodule TheFuzz.Phonetic.MetaphoneMetric do
  @moduledoc """
  Calculates the [Metaphone Phonetic Algorithm](http://en.wikipedia.org/wiki/
  Metaphone) metric of two strings.
  """

  import TheFuzz.Phonetic.MetaphoneAlgorithm, only: [compute: 1]
  import TheFuzz.Util, only: [len: 1, is_alphabetic?: 1]
  import String, only: [first: 1, codepoints: 1]

  @doc """
    Compares two values phonetically and returns a boolean of whether they match
    or not.
    ## Examples
      iex> TheFuzz.Phonetic.MetaphoneMetric.compare("Colorado", "Kolorado")
      true
      iex> TheFuzz.Phonetic.MetaphoneMetric.compare("Moose", "Elk")
      false
  """
  def compare(a, b) do
    case len(a) == 0 || !is_alphabetic?(first(a)) ||
        len(b) == 0 || !is_alphabetic?(first(b)) do
      false ->
        compute(a) == compute(b)
      true ->
        nil
    end
  end
end
