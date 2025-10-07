defmodule Elaixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, arg) do
    children = [
      # Starts a worker by calling: Elaixir.Worker.start_link(arg)
      {Elaixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Elaixir.Supervisor]
    IO.puts("Siamo in: Elaixir.Application.start")
    Supervisor.start_link(children, opts)
  end
end
