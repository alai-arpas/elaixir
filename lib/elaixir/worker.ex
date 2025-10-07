defmodule Elaixir.Worker do
  use GenServer

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    IO.puts("Inizializza Elaixir.Worker")
    {:ok, state}
  end
end
