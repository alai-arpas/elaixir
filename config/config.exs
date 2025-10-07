# General application configuration
import Config

config :elaixir,
  ecto_repos: [Elaixir.Repo]

config :elaixir, Elaixir.Repo,
  database: "elaixir.db"
