defmodule DocTest do
  use ExUnit.Case
  doctest TheFuzz.Similarity.Overlap
  doctest TheFuzz.Similarity.JaroWinkler
  doctest TheFuzz.Similarity.Jaro
  doctest TheFuzz.Phonetic.MetaphoneAlgorithm
  doctest TheFuzz.Phonetic.MetaphoneMetric
  doctest TheFuzz.Util
end