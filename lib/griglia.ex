defmodule Griglia do
  @y_rows 4
  @x_cols 2

  @x_spazio 8 + 20
  @y_spazio 14 + 2

  @pt_base {0, 0}

  def crea(y_rows \\ @y_rows, x_cols \\ @x_cols) do
    for c_x <- 1..x_cols do
      for r_y <- 1..y_rows do
        elementi_in_colonna_precedenti = (c_x - 1) * y_rows
        n = (elementi_in_colonna_precedenti + r_y) |> Integer.to_string()
        %{n => %{col_x: c_x, row_y: r_y}}
      end
    end
    |> List.flatten()
  end

  def spazia(griglia \\ crea()) do
    Enum.map(griglia, fn e ->
      calcola_punto_base_griglia(e, @pt_base, @x_spazio, @y_spazio)
    end)
  end

  def calcola_punto_base_griglia(e, pt \\ @pt_base, xs \\ @x_spazio, ys \\ @y_spazio) do
    # {"1", 1,   1, {0, 0}, 28, 16}
    # {n, c_x, r_y,     pt, xs, ys}

    [{n, %{col_x: c_x, row_y: r_y}}] = Map.to_list(e)
    {pt_x, pt_y} = pt

    pt_new_x = pt_x + xs * (c_x - 1)
    pt_new_y = pt_y + ys * (r_y - 1)

    {n, c_x, r_y, pt, xs, ys, {pt_new_x, pt_new_y}}
  end

  def crea_rect(ele_grigla) do
    {n, c_x, r_y, pt, xs, ys, {pt_new_x, pt_new_y}} = ele_grigla

    {"rectangle", {n, c_x, r_y, pt, xs, ys, {pt_new_x, pt_new_y}}}
  end
end
