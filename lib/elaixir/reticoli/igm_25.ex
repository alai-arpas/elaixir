defmodule Elaixir.Reticoli.Igm25 do
  # VERTICI
  @matrice_3X3 [
    [7, 8, 9],
    [4, 5, 6],
    [1, 2, 3]
  ]

  # Nomi sezioni
  @nomi [
    ["IV", "I"],
    ["III", "II"]
  ]

  @doc """
  Matrice per vertici.
  """
  @spec vertici() :: [[integer()]]
  def vertici, do: @matrice_3X3

  @doc """
  Nomi Sezioni 25.000 ordine
  TopLeft, TopRigth
  BottomLeft, BottomRigth
  """
  @spec nomi() :: [[String.t()]]
  def nomi, do: @nomi
end
