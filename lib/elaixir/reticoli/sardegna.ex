defmodule Elaixir.Reticoli.Sardegna do
  use GenServer

  alias Elaixir.Reticoli.GestioneIgmCtr

  # Client
  # per ora pensato per partire con defualt = []
  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def igm50(), do: GenServer.call(__MODULE__, :igm50)
  def info(), do: GenServer.call(__MODULE__, :info)

  # Server (callbacks)

  @impl true
  def init(_elements) do
    initial_state = GestioneIgmCtr.start()
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:igm50, _from, state), do: {:reply, state, state}

  @impl true
  def handle_call(:info, _from, state), do: {:reply, state, state}
end
