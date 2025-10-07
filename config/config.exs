# General application configuration
import Config

config :elaixir,
  ecto_repos: [Elaixir.Repo]

config :elaixir, Elaixir.Repo,
  database: "elaixir.db",
  # database: :code.priv_dir(:elaixir) <> "elaxir.db",
  default_transaction_mode: :immediate
