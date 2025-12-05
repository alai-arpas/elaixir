defmodule Elaixir.Reticoli.Ctr10 do
  @moduledoc """
  Modello CTR Carta Tecnica regionale. Rappresenta
  nomi e vertici
  """

  @matrice_5x5 [
    [21, 22, 23, 24, 25],
    [16, 17, 18, 19, 20],
    [11, 12, 13, 14, 15],
    [6, 7, 8, 9, 10],
    [1, 2, 3, 4, 5]
  ]

  @nomi [
    ["010", "020", "030", "040"],
    ["050", "060", "070", "080"],
    ["090", "100", "110", "120"],
    ["130", "140", "150", "160"]
  ]

  @matrice_4x4 [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16]
  ]

  @doc """
  Restituisce la matrice 4x4 con valori da 1 a 16.
  """
  @spec matrice_4x4() :: [[integer()]]
  def matrice_4x4, do: @matrice_4x4

  @doc """
  Matrice per vertici.
  """
  @spec vertici() :: [[integer()]]
  def vertici, do: @matrice_5x5

  @doc """
  Codifica nomi CTR.
  """
  @spec nomi() :: [[String.t()]]
  def nomi, do: @nomi

  def genera_nomi(igm) do
    igm
  end


end
