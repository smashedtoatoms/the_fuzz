defmodule TheFuzz.Similarity.Hamming do
  @moduledoc """
  This module contains functions to calculate the Hamming distance between 2 
  given strings
  """
  @behaviour TheFuzz.StringMetric

  @doc """
  Calculates the Hamming distance between 2 given strings.

  ## Examples
      iex> TheFuzz.Similarity.Hamming.compare("toned", "roses")
      3
      iex> TheFuzz.Similarity.Hamming.compare("toned", "hamming")
      nil
      iex> TheFuzz.Similarity.Hamming.compare("toned", "toned")
      0
  """
  def compare(a, b) when byte_size(a) == 0 or byte_size(b) == 0
    or byte_size(a) != byte_size(b), do: nil
  def compare(a, b) when a == b, do: 0
  def compare(a, b) when is_binary(a) and is_binary(b) do
    a |> String.codepoints |> Enum.zip(b |> String.codepoints)
    |> Enum.count(fn {cp1, cp2} -> cp1 != cp2 end)
  end
end
