defmodule TheFuzz.Util do
  @moduledoc """
  Utilities for TheFuzz.
  """

  @doc """
  Finds the length of a string in a less verbose way.
  ## Example
      iex> TheFuzz.Util.len("Jason")
      5
  """
  def len(value), do: String.length(value)

  @doc """
  Checks to see if a string is alphabetic.
  ## Example
      iex> TheFuzz.Util.is_alphabetic?("Jason5")
      false
      iex> TheFuzz.Util.is_alphabetic?("Jason")
      true
  """
  def is_alphabetic?(value) do
    !Regex.match?(~r/[\W0-9]/, value)
  end

  @doc """
  Removes duplicates from a string (except for c)
  ## Example
      iex> TheFuzz.Util.deduplicate("buzz")
      "buz"
      iex> TheFuzz.Util.deduplicate("accept")
      "accept"
  """
  def deduplicate(value) do
    cond do
      String.length(value) <= 1 ->
        value

      true ->
        (String.codepoints(value)
         |> Stream.chunk_every(2, 1, :discard)
         |> Stream.filter(&(hd(&1) == "c" || hd(&1) != hd(tl(&1))))
         |> Stream.map(&hd(&1))
         |> Enum.to_list()
         |> to_string) <> String.last(value)
    end
  end

  @doc """
  Finds the intersection of two lists.  If Strings are provided, it uses the
  codepoints of said string.
  ## Example
      iex> TheFuzz.Util.intersect(~c"context", ~c"contentcontent")
      ~c"contet"
      iex> TheFuzz.Util.intersect("context", "contentcontent")
      ["c", "o", "n", "t", "e", "t"]
  """
  def intersect(l1, l2) when is_binary(l1) and is_binary(l2) do
    intersect(String.codepoints(l1), String.codepoints(l2))
  end

  def intersect(l1, l2), do: l1 -- (l1 -- l2)

  @doc """
  [ngram tokenizes](http://en.wikipedia.org/wiki/N-gram) the string provided.
  ## Example
      iex> TheFuzz.Util.ngram_tokenize("abcdefghijklmnopqrstuvwxyz", 2)
      ["ab", "bc", "cd", "de", "ef", "fg", "gh", "hi", "ij", "jk", "kl", "lm",
      "mn", "no", "op", "pq", "qr", "rs", "st", "tu", "uv", "vw", "wx", "xy",
      "yz"]
  """
  def ngram_tokenize(string, n) when is_binary(string) do
    ngram_tokenize(String.codepoints(string), n)
  end

  def ngram_tokenize(characters, n) do
    case n <= 0 || length(characters) < n do
      true -> nil
      false -> Stream.chunk_every(characters, n, 1, :discard) |> Enum.map(&to_string(&1))
    end
  end
end
