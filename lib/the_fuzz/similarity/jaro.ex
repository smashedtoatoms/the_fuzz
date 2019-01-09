defmodule TheFuzz.Similarity.Jaro do
  @moduledoc """
  Calculates the [Jaro Distance](http://en.wikipedia.org/wiki/
  Jaro-Winkler_distance) between two strings.
  """
  @behaviour TheFuzz.StringMetric

  @doc """
  Calculates the Jaro distance between two strings.  This used to be
  implemented here, but since Elixir 1.1, Jaro is part of the standard lib.
  This now uses the std lib call, but returns nil if either string is empty
  to preserve backwards compatibility with this library's original code.

  ## Examples
      iex> TheFuzz.Similarity.Jaro.compare("abc", "")
      nil
      iex> TheFuzz.Similarity.Jaro.compare("abc", "xyz")
      0.0
      iex> TheFuzz.Similarity.Jaro.compare("compare me", "compare me")
      1.0
      iex> TheFuzz.Similarity.Jaro.compare("natural", "nothing")
      0.5238095238095238
  """
  def compare(string1, string2) do
    string1_length = String.length(string1)
    string2_length = String.length(string2)

    cond do
      string1_length == 0 or string2_length == 0 -> nil
      true -> String.jaro_distance(string1, string2)
    end
  end
end
