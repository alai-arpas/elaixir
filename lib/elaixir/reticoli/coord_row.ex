defmodule Elaixir.Reticoli.CoordRow do
  alias Elaixir.Coordinate.GradiSessagesimali, as: GS
  alias Elaixir.Coordinate.GeoConverter, as: GConv

  defstruct tipo: "",
            foglio: 0,
            row_lat_y: 0,
            col_lon_x: 0,
            lon_x__lat_y: "",
            lon_x: "lon_x",
            lon_y: "lon_y",
            lon_x_dec: 0.0,
            lat_y_dec: 0.0,
            x_6707_gsb: 99.9,
            y_6707_gsb: 99.9

  def report(lista_fogli_coordinate) do
    lista_fogli_coordinate
    |> Enum.map(&report_foglio/1)
  end

  defp report_foglio(lista_fogli_coordinate) do
    {tipo, foglio, vertici} = lista_fogli_coordinate

    tabella_coordinate =
      vertici |> Enum.map(&report_coordinate(&1, tipo, foglio))

    tabella_coordinate
  end

  defp report_coordinate(vertice, tipo, foglio) do
    {{row, col},
     %{
       x: x,
       y: y
     }} = vertice

    %__MODULE__{
      tipo: Atom.to_string(tipo),
      foglio: foglio,
      row_lat_y: row,
      col_lon_x: col,
      lon_x__lat_y: GS.to_name(x) <> "_" <> GS.to_name(y),
      lon_x: GS.to_name(x),
      lon_y: GS.to_name(y),
      lon_x_dec: GConv.to_decimale(x),
      lat_y_dec: GConv.to_decimale(y)
    }
  end
end
