defmodule TheFuzz.Similarity.JaroWinkler do
  @moduledoc """
  Calculates the [Jaro-Winkler Distance](http://en.wikipedia.org/wiki/
  Jaro-Winkler_distance) between two strings.
  """
  @behaviour TheFuzz.StringMetric

  @doc """
  Calculates the Jaro-Winkler distance between two strings.
  ## Examples
      iex> TheFuzz.Similarity.JaroWinkler.compare("abc", "")
      nil
      iex> TheFuzz.Similarity.JaroWinkler.compare("abc", "xyz")
      0.0
      iex> TheFuzz.Similarity.JaroWinkler.compare("compare me", "compare me")
      1.0
      iex> TheFuzz.Similarity.JaroWinkler.compare("natural", "nothing")
      0.5714285714285714
  """
  def compare(string1, string2) do
    alias TheFuzz.Similarity.Jaro, as: Jaro
    string1_length = String.length(string1)
    string2_length = String.length(string2)

    cond do
      string1_length == 0 or string2_length == 0 ->
        nil

      string1 == string2 ->
        1.0

      string1_length > string2_length ->
        score = Jaro.compare(string2, string1)
        modified_prefix = modify_prefix(string2, string1)
        score + modified_prefix * (1 - score) / 10

      true ->
        score = Jaro.compare(string1, string2)
        modified_prefix = modify_prefix(string1, string2)
        score + modified_prefix * (1 - score) / 10
    end
  end

  ############################################################################
  ## Helper Functions
  ############################################################################

  # Modifies the prefix scale, which gives a more favorable rating to strings
  # that match from the beginning.
  defp modify_prefix(s1, s2) do
    modify_prefix(s1, s2, 0, Enum.min([4, String.length(s1)]))
  end

  defp modify_prefix(s1, s2, prefix_length, last_character) do
    cond do
      prefix_length < last_character &&
          String.at(s1, prefix_length) == String.at(s2, prefix_length) ->
        modify_prefix(s1, s2, prefix_length + 1, last_character)

      true ->
        prefix_length
    end
  end
end
