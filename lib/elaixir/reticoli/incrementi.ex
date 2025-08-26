defmodule Elaixir.Reicoli.Incrementi do
  @moduledoc """
  Incrementi di coordinate reticolari per diverse scale cartografiche.
  """
  alias Elaixir.Coordinate.GradiSessagesimali, as: GradiSessagesimali

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
  @spec get_x(integer()) :: GradiSessagesimali.t() | nil
  def get_x(scala) do
    case @incrementi[scala] do
      %{x: x} -> x
      _ -> nil
    end
  end

  @doc """
  Restituisce l'incremento y per la scala specificata.
  """
  @spec get_y(integer()) :: GradiSessagesimali.t() | nil
  def get_y(scala) do
    case @incrementi[scala] do
      %{y: y} -> y
      _ -> nil
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
