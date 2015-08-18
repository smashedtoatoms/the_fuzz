defmodule TheFuzz.Similarity.Jaro do
  @moduledoc """
  Calculates the [Jaro Distance](http://en.wikipedia.org/wiki/
  Jaro-Winkler_distance) between two strings.
  """
  @behaviour TheFuzz.StringMetric

  @doc """
  Calculates the Jaro distance between two strings.
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
      string1 == string2 -> 1.0
      string1_length > string2_length -> match(string2, string1)
      true -> match(string1, string2)
    end
  end

  ############################################################################
  ## Helper Functions
  ############################################################################

  # Iterates through the first string and finds common characters (com) and
  # transpositions (trans).
  defp match(s1, s2) do
    max = div(String.length(s2), 2)
    match(s1, s2, max, 0, 0, -1, 0)
  end
  defp match(s1, s2, max, com, trans, prev, i) when i < byte_size(s1) do
    c = String.at(s1, i)
    from = Enum.max([0, i - max])
    to = Enum.min([String.length(s2), i + max])
    {new_com, new_trans, new_prev} = match_second(
      c, s2, from, to, prev, com, trans, false
    )
    match(s1, s2, max, new_com, new_trans, new_prev, i+1)
  end
  defp match(s1, s2, _, com, trans, _, _) do
    cond do
      com == 0 ->
        0.0
      true ->
        (((com / String.length(s1)) + (com / String.length(s2)) +
          ((com - trans) / com)) / 3.0)
    end
  end

  # Iterates through the second string and find common characters (com)
  # and transpositions (trans)
  defp match_second(c, s2, from, to, prev, com, trans, break) do
    cond do
      break ->
        {com, trans, prev}
      from >= to ->
        {com, trans, prev}
      c == String.at(s2, from) && prev != -1 && from < prev ->
        match_second(c, s2, from+1, to, from, com+1, trans+1, true)
      c == String.at(s2, from) ->
        match_second(c, s2, from+1, to, from, com+1, trans, true)
      true ->
        match_second(c, s2, from+1, to, prev, com, trans, false)
    end
  end
end
