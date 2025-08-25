defmodule Elaixir.Coordinate.GradiSessagesimali do
  @moduledoc """
  Coordinate geografiche in gradi, minuti e secondi (sessagesimali).
  """

  defstruct [:gradi, :minuti, :secondi]

  @type t :: %__MODULE__{
          gradi: integer(),
          minuti: integer(),
          secondi: integer()
        }

  @doc """
  Crea una nuova struct `GradiSessagesimali` a partire da una mappa
  contenente `:gradi`, `:minuti` e `:secondi`.
  """
  @spec make(map()) :: t()
  def make(%{gradi: g, minuti: m, secondi: s}) do
    %__MODULE__{gradi: g, minuti: m, secondi: s}
  end

  @doc """
  Crea una nuova struct `GradiSessagesimali` a partire da una tupla `{gradi, minuti, secondi}`.
  """
  @spec make_from_tuple({integer(), integer(), integer()}) :: t()
  def make_from_tuple({g, m, s}) do
    %__MODULE__{gradi: g, minuti: m, secondi: s}
  end

  @doc """
  Restituisce la rappresentazione testuale della coordinata
  in formato `G° M' S"`.
  """
  @spec to_string(t()) :: String.t()
  def to_string(%__MODULE__{gradi: g, minuti: m, secondi: s}) do
    "#{g}° #{m}' #{s}\""
  end

  @doc """
  Restituisce la coordinata come tupla `{gradi, minuti, secondi}`.
  """
  @spec to_tuple(t()) :: {integer(), integer(), integer()}
  def to_tuple(%__MODULE__{gradi: g, minuti: m, secondi: s}) do
    {g, m, s}
  end
end
