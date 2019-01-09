defmodule TheFuzz.Mixfile do
  use Mix.Project

  def project do
    [
      app: :the_fuzz,
      version: "0.4.0",
      elixir: "~> 1.6",
      name: "TheFuzz",
      source_url: "https://github.com/smashedtoatoms/the_fuzz",
      homepage_url: "https://github.com/smashedtoatoms/the_fuzz",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [extra_applications: [:logger]]
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
      {:earmark, "~> 1.3", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev},
      {:credo, "~> 1.0", only: :dev}
    ]
  end

  defp description do
    """
    String metrics and phonetic algorithms for Elixir.  Based Heavily on
    StringMetrics for Scala written by Rocky Madden.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jason Legler", "Kiran Danduprolu", "Craig Waterman"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/smashedtoatoms/the_fuzz",
        "Docs" => "https://smashedtoatoms.github.io/the_fuzz"
      }
    ]
  end
end
