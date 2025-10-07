defmodule Elaixir.Repo do
  use Ecto.Repo,
    otp_app: :elaixir,
    adapter: Ecto.Adapters.SQLite3
end
