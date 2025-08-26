defmodule Elaixir.Reticoli.Quadro do
  @moduledoc """
  Rappresenta un quadro reticolare con nome e 4 vertici (coordinate sessagesimali).
  """

  alias Elaixir.Coordinate.GradiSessagesimali

  defstruct [
    :nome,
    :bottom_left,
    :bottom_right,
    :top_left,
    :top_right
  ]

  @type t :: %__MODULE__{
          nome: String.t(),
          bottom_left: GradiSessagesimali.t(),
          bottom_right: GradiSessagesimali.t(),
          top_left: GradiSessagesimali.t(),
          top_right: GradiSessagesimali.t()
        }

  @doc """
  Crea una struct `Quadro` a partire da una mappa con nome e 4 vertici.
  """
  @spec make(map()) :: t()
  def make(%{
        nome: nome,
        bottom_left: bl,
        bottom_right: br,
        top_left: tl,
        top_right: tr
      }) do
    %__MODULE__{
      nome: nome,
      bottom_left: bl,
      bottom_right: br,
      top_left: tl,
      top_right: tr
    }
  end

  # ...existing code...

  @doc """
  Crea una struct `Quadro` a partire dal nome, dal vertice bottom_left e dagli incrementi x e y.
  Calcola gli altri 3 vertici sommando gli incrementi.
  """
  @spec make(String.t(), GradiSessagesimali.t(), GradiSessagesimali.t(), GradiSessagesimali.t()) ::
          t()
  def make(nome, bottom_left, incr_x, incr_y) do
    bottom_right = GradiSessagesimali.somma(bottom_left, incr_x)
    top_left = GradiSessagesimali.somma(bottom_left, incr_y)
    top_right = GradiSessagesimali.somma(bottom_right, incr_y)

    %__MODULE__{
      nome: nome,
      bottom_left: bottom_left,
      bottom_right: bottom_right,
      top_left: top_left,
      top_right: top_right
    }
  end
end
