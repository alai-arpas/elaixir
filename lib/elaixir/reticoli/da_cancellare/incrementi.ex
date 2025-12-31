defmodule Elaixir.Reticoli.Incrementi do
  @moduledoc """
  Incrementi di coordinate reticolari per diverse scale cartografiche.
  """
  alias Elaixir.Coordinate.GradiSessagesimali, as: GradiSessagesimali

  @type incremento :: %{
          x: GradiSessagesimali.t(),
          y: GradiSessagesimali.t()
        }

  @incrementi %{
    5 => %{
      x: %GradiSessagesimali{gradi: 0, minuti: 2, secondi: 30},
      y: %GradiSessagesimali{gradi: 0, minuti: 1, secondi: 30}
    },
    10 => %{
      x: %GradiSessagesimali{gradi: 0, minuti: 5, secondi: 0},
      y: %GradiSessagesimali{gradi: 0, minuti: 3, secondi: 0}
    },
    25 => %{
      x: %GradiSessagesimali{gradi: 0, minuti: 10, secondi: 0},
      y: %GradiSessagesimali{gradi: 0, minuti: 6, secondi: 0}
    },
    50 => %{
      x: %GradiSessagesimali{gradi: 0, minuti: 20, secondi: 0},
      y: %GradiSessagesimali{gradi: 0, minuti: 12, secondi: 0}
    }
  }

  def scale_incrementi, do: @incrementi

  @doc """
  Restituisce l'incremento x per la scala specificata.
  """
  @spec get_for_scala(integer()) :: incremento
  def get_for_scala(scala) do
    case @incrementi[scala] do
      nil -> raise("Scala '#{scala}' non prevista.")
      incremento -> incremento
    end
  end

  @doc """
  Restituisce la lista delle scale disponibili.
  """
  @spec scale_keys() :: [integer()]
  def scale_keys do
    Map.keys(@incrementi)
  end
end
