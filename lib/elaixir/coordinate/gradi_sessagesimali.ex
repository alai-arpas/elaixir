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
  Crea una nuova struct `GradiSessagesimali` a partire da una stringa
  "gradi:minuti:secondi"
  """
  @spec make_from_string(String.t(), String.t()) :: t()
  def make_from_string(stringa, separatore \\ ":") do
    case String.split(stringa, separatore) do
      [g, m, s] ->
        %__MODULE__{
          gradi: String.to_integer(g),
          minuti: String.to_integer(m),
          secondi: String.to_integer(s)
        }

      _ ->
        raise ArgumentError,
          message: "Formato non valido: usa \"gradi#{separatore}minuti#{separatore}secondi\""
    end
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
  Restituisce la rappresentazione testuale della coordinata
  in formato `G° M' S"`.
  """
  @spec to_name(t()) :: String.t()
  def to_name(%__MODULE__{gradi: g, minuti: m, secondi: s}, separatore \\ ":") do
    "#{g}#{separatore}#{m}#{separatore}#{s}"
  end

  @doc """
  Restituisce la coordinata come tupla `{gradi, minuti, secondi}`.
  """
  @spec to_tuple(t()) :: {integer(), integer(), integer()}
  def to_tuple(%__MODULE__{gradi: g, minuti: m, secondi: s}) do
    {g, m, s}
  end

  @doc """
  Somma due coordinate `GradiSessagesimali`.
  """
  @spec somma(t(), t()) :: t()
  def somma(%__MODULE__{gradi: g1, minuti: m1, secondi: s1}, %__MODULE__{
        gradi: g2,
        minuti: m2,
        secondi: s2
      }) do
    tot_secondi = s1 + s2
    riporto_minuti = div(tot_secondi, 60)
    secondi = rem(tot_secondi, 60)

    tot_minuti = m1 + m2 + riporto_minuti
    riporto_gradi = div(tot_minuti, 60)
    minuti = rem(tot_minuti, 60)

    gradi = g1 + g2 + riporto_gradi

    %__MODULE__{gradi: gradi, minuti: minuti, secondi: secondi}
  end

  @doc """
  Moltiplica una coordinata `GradiSessagesimali` per un intero.
  """
  @spec moltiplica(t(), integer()) :: t()
  def moltiplica(%__MODULE__{gradi: g, minuti: m, secondi: s}, n) when is_integer(n) and n >= 0 do
    tot_secondi = (g * 3600 + m * 60 + s) * n

    gradi = div(tot_secondi, 3600)
    rest = rem(tot_secondi, 3600)
    minuti = div(rest, 60)
    secondi = rem(rest, 60)

    %__MODULE__{gradi: gradi, minuti: minuti, secondi: secondi}
  end
end
