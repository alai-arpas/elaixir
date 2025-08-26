defmodule Elaixir.Coordinate.PuntoGS do
  @moduledoc """
  Rappresenta un punto con coordinate sessagesimali (x, y) e nome derivato dai valori.
  """

  alias Elaixir.Coordinate.GradiSessagesimali

  defstruct [:nome, :x, :y]

  @type t :: %__MODULE__{
          nome: String.t(),
          x: GradiSessagesimali.t(),
          y: GradiSessagesimali.t()
        }

  @doc """
  Crea una struct `PuntoGS` a partire da due coordinate sessagesimali.
  Il nome viene generato dai valori x e y.
  """
  @spec make(GradiSessagesimali.t(), GradiSessagesimali.t()) :: t()
  def make(x, y) do
    nome = "Lon_X_#{GradiSessagesimali.to_name(x)}" <> ":Lat_Y_#{GradiSessagesimali.to_name(y)}"
    %__MODULE__{nome: nome, x: x, y: y}
  end

  @doc """
  Crea una struct `PuntoGS` a partire da due coordinate sessagesimali.
  Il nome viene generato dai valori x e y.
  """
  @spec make_map(GradiSessagesimali.t(), GradiSessagesimali.t()) :: map
  def make_map(x, y) do
    nome = "Lon_X_#{GradiSessagesimali.to_name(x)}" <> ":Lat_Y_#{GradiSessagesimali.to_name(y)}"
    %{nome => %{x: x, y: y}}
  end
end
