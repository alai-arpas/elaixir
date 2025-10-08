# General application configuration
import Config

config :elaixir,
  ecto_repos: [Elaixir.Repo]

config :elaixir, Elaixir.Repo,
  pool_size: 1,
  journal_mode: :wal
