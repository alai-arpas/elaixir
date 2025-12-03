defmodule Elaixir.Reticoli.Igm50 do
  defstruct foglio: 0, nome: ""
  # VERTICI
  @matrice_2x2 [
    [3, 4],
    [1, 2]
  ]

  # Nomi sezioni
  @nome "nome_foglio"
  @doc """
  Matrice per vertici.
  """
  @spec vertici() :: [[integer()]]
  def vertici, do: @matrice_2x2

  @doc """
  Nomi Sezioni 25.000 ordine
  TopLeft, TopRigth
  BottomLeft, BottomRigth
  """
  @spec nomi() :: [[String.t()]]
  def nomi, do: @nome
end
