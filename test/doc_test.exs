defmodule DocTest do
  use ExUnit.Case
  doctest TheFuzz.Phonetic.MetaphoneAlgorithm
  doctest TheFuzz.Phonetic.MetaphoneMetric
  doctest TheFuzz.Similarity.DiceSorensen
  doctest TheFuzz.Similarity.Hamming
  doctest TheFuzz.Similarity.Jaccard
  doctest TheFuzz.Similarity.Jaro
  doctest TheFuzz.Similarity.JaroWinkler
  doctest TheFuzz.Similarity.Levenshtein
  doctest TheFuzz.Similarity.NGram
  doctest TheFuzz.Similarity.Overlap
  doctest TheFuzz.Similarity.WeightedLevenshtein
  doctest TheFuzz.Util
end
