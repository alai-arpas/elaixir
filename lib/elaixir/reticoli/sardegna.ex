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

  # Sardegna.get_by_foglio("igm25", 546)
  # Sardegna.get_by_foglio("ctr10", 546)
  def get_by_foglio(tipo, foglio), do: GenServer.call(__MODULE__, {:get_by_foglio, tipo, foglio})

  # Server (callbacks)

  @impl true
  def init(_elements) do
    initial_state = GestioneIgmCtr.start()

    # Crea ETS
    :ets.new(:griglia, [
      :set,
      :named_table,
      :public,
      read_concurrency: true
    ])

    # Inserisce tutti i dati
    :ets.insert(:griglia, Map.to_list(Map.get(initial_state, :coord_6707)))

    {:ok, initial_state}
  end

  @impl true
  def handle_call({:get_by_foglio, tipo, foglio}, _from, state) do
    results =
      :ets.match(
        :griglia,
        {{tipo, foglio, :"$1", :"$2"}, :"$3"}
      )
      |> Enum.map(fn [row, col, value] ->
        {{row, col}, value}
      end)
      |> Enum.into(%{})

    {:reply, results, state}
  end

  @impl true
  def handle_call(:igm50, _from, state), do: {:reply, state, state}

  @impl true
  def handle_call(:info, _from, state), do: {:reply, state, state}
end
