defmodule Elaixir.Worker do
  use GenServer

  alias Elaixir

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    my_dir_data = Elaixir.directory_dati()
    IO.puts("Inizializza Elaixir.Worker")
    IO.puts(my_dir_data)

    {:ok, state}
  end
end
