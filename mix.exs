defmodule TheFuzz.MixProject do
  use Mix.Project

  def project do
    [
      app: :the_fuzz,
      version: "0.6.0",
      elixir: "~> 1.7",
      name: "TheFuzz",
      source_url: "https://github.com/smashedtoatoms/the_fuzz",
      homepage_url: "https://github.com/smashedtoatoms/the_fuzz",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.38", only: :dev, runtime: false}
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
