defmodule TheFuzz.Mixfile do
  use Mix.Project

  def project do
    [app: :the_fuzz,
     version: "0.3.0",
     elixir: "~> 1.2.1",
     name: "TheFuzz",
     source_url: "https://github.com/smashedtoatoms/the_fuzz",
     homepage_url: "https://github.com/smashedtoatoms/the_fuzz",
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.6", only: :dev},
      {:dogma, "~> 0.0", only: :dev}
    ]
  end

  defp description do
    """
    String metrics and phonetic algorithms for Elixir (e.g. Dice/Sorensen, 
    Hamming, Jaccard, Jaro, Jaro-Winkler, Levenshtein, Metaphone, N-Gram, 
    NYSIIS, Overlap, Ratcliff/Obershelp, Refined NYSIIS, Refined Soundex, 
    Soundex, Tversky, Tanimoto, Weighted Levenshtein).  Based Heavily on 
    StringMetrics for Scala written by Rocky Madden.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jason Legler", "Kiran Danduprolu"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/smashedtoatoms/the_fuzz",
        "Docs" => "https://smashedtoatoms.github.io/the_fuzz"
      }
    ]
  end
end
