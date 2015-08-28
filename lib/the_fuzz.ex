defmodule TheFuzz do
  @moduledoc """
  Contains shortforms to execute different string metric algorithms to compare 
  given strings.
  """
  @spec compare(atom, String.t, String.t) :: number

  @doc """
  Compares given strings using the corresponding string metric algorithm.
  
  Available metric types are:
  - Sorensen Dice coefficient: **:dice_sorensen**
  - Hamming distance: **:hamming**
  - Jaccard Similarity coefficient: **:jaccard**
  - Jaro distance: **:jaro**
  - Jaro Winkler distance: **:jaro_winkler**
  - Levenshtein distance: **:levenshtein**
  - n Gram similarity: **:n_gram** 
  - Overlap coefficient: **:overlap**
  - Tanimoto coefficient: **:tanimoto**
  - Weighted Levenshtein distance: **:weighted_levenshtein**

  Note: Some of these metrics will use default values for other parameters
  they might need like n gram size in case of Jaccard
  """
  def compare(metric_type, a, b)
  def compare(:dice_sorensen, a, b) do
    TheFuzz.Similarity.DiceSorensen.compare(a, b)
  end

  def compare(:hamming, a, b) do
    TheFuzz.Similarity.Hamming.compare(a, b)
  end

  def compare(:jaccard, a, b) do
    TheFuzz.Similarity.Jaccard.compare(a, b)
  end

  def compare(:jaro, a, b) do
    TheFuzz.Similarity.Jaro.compare(a, b)
  end

  def compare(:jaro_winkler, a, b) do
    TheFuzz.Similarity.JaroWinkler.compare(a, b)
  end

  def compare(:levenshtein, a, b) do
    TheFuzz.Similarity.Levenshtein.compare(a, b)
  end

  def compare(:n_gram, a, b) do
    TheFuzz.Similarity.NGram.compare(a, b)
  end

  def compare(:overlap, a, b) do
    TheFuzz.Similarity.Overlap.compare(a, b)
  end

  def compare(:tanimoto, a, b) do
    TheFuzz.Similarity.Tversky.compare(a, b)
  end

  def compare(:weighted_levenshtein, a, b) do
    TheFuzz.Similarity.WeightedLevenshtein.compare(a, b)
  end

  @doc """
  Compares given strings using the corresponding string metric algorithm with 
  given `opts`

  `opts` can be n gram size in case of Dice Sorensen, Jaccard, N Gram similarity
  and can be weights in case of Weighted Levenshtein

  Available metric types are:
  - Sorensen Dice coefficient: **:dice_sorensen**
  - Jaccard Similarity coefficient: **:jaccard**
  - n Gram similarity: **:n_gram** 
  - Tversky index: **:tversky**
  - Weighted Levenshtein distance: **:weighted_levenshtein**
  """
  def compare(metric_type, a, b, opts)
  def compare(:dice_sorensen, a, b, n) do
    TheFuzz.Similarity.DiceSorensen.compare(a, b, n)
  end

  def compare(:jaccard, a, b, n) do
    TheFuzz.Similarity.Jaccard.compare(a, b, n)
  end

  def compare(:n_gram, a, b, n) do
    TheFuzz.Similarity.NGram.compare(a, b, n)
  end

  def compare(:tversky, a, b, %{} = opts) do
    TheFuzz.Similarity.Tversky.compare(a, b, opts)
  end

  def compare(:weighted_levenshtein, a, b, %{} = weights) do
    TheFuzz.Similarity.WeightedLevenshtein.compare(a, b, weights)
  end
end
