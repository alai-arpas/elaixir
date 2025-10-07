defmodule Elaixir.MixProject do
  use Mix.Project

  @version "0.1.8"

  def project do
    [
      app: :elaixir,
      version: @version,
      elixir: "~> 1.15",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp description do
    "Helpers"
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Elaixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:ecto_sqlite3, "~> 0.22"}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/alai-arpas/elaixir"}
    ]
  end

  defp aliases do
    [
      wv: ["Elaixir -awv"]
    ]
  end
end
