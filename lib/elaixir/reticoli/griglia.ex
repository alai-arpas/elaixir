defmodule Elaixir.Reticoli.Griglia do
  # genera matrice NxN di vertici come %{x: , y: }
  def genera_vertici(n) do
    for y <- 0..(n - 1) do
      for x <- 0..(n - 1) do
        %{x: x, y: y}
      end
    end
  end

  # costruisce poligoni da matrice di vertici NxN
  def poligoni(vertici) do
    # numero di poligoni per lato
    n = length(vertici) - 1

    for i <- 0..(n - 1), j <- 0..(n - 1) do
      v1 = vertici |> Enum.at(i) |> Enum.at(j)
      v2 = vertici |> Enum.at(i) |> Enum.at(j + 1)
      v3 = vertici |> Enum.at(i + 1) |> Enum.at(j + 1)
      v4 = vertici |> Enum.at(i + 1) |> Enum.at(j)

      [{i, j}, [v1, v2, v3, v4]]
    end
  end
end
