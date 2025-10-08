defmodule Elaixir.Repo do
  use Ecto.Repo,
    otp_app: :elaixir,
    adapter: Ecto.Adapters.SQLite3

  @impl true
  def init(_type, config) do
    db_path = Path.join([:code.priv_dir(:elaixir), "data", "my_sqlite.sqlite3"])
    IO.puts(db_path)

    {:ok, Keyword.put(config, :database, db_path)}
  end
end
