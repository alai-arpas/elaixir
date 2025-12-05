defmodule Elaixir.Reticoli.QuadroIgm50Sardegna do
  @moduledoc """
  Suddivisio IGM50 per la regione Sardegna, viene rappresentato
  come una griglia regolare di (6 larghezza X 13 altezza)

  Alcune Fogli non esistono perche ricadono a mare
  ad esempio M-571 (questi fogli iniziano con "M-") rappresenta
  il foglio in basso a sinistra che ricade competamente a mare e
  viene usato come base per il calcolo delle coordiante.
  @lon_x_gg_mm_ss %GradiSessagesimali{gradi: 8, minuti: 0, secondi: 0}
  @lat_y_gg_mm_ss %GradiSessagesimali{gradi: 38, minuti: 48, secondi: 0}

  """

  alias Elaixir.Coordinate.GradiSessagesimali
  alias Elaixir.Reicoli.Incrementi

  @nomi [
    ["M-408", "M-409", "M-410", "411", "412", "M-413"],
    ["425", "M-425", "426", "427", "428", "M-429"],
    ["440", "441", "442", "443", "444", "445"],
    ["458", "459", "460", "461", "462", "463"],
    ["478", "479", "480", "481", "482", "483"],
    ["M-496", "497", "498", "499", "500", "501"],
    ["M-513", "514", "515", "516", "517", "518"],
    ["M-527", "528", "529", "530", "531", "532"],
    ["M-537", "538", "539", "540", "541", "M-542"],
    ["M-543", "546", "547", "548", "549", "M-550"],
    ["M-554", "555", "556", "557", "558", "M-559"],
    ["563", "564", "565", "566", "567", "M-568"],
    ["M-571", "572", "573", "M-573", "M-574", "M-575"]
  ]

  def quadro_visuale do
    @nomi
  end

  def quadro_per_calcoli do
    Enum.reverse(@nomi)
  end

  @lon_x_gg_mm_ss %GradiSessagesimali{gradi: 8, minuti: 0, secondi: 0}
  @lat_y_gg_mm_ss %GradiSessagesimali{gradi: 38, minuti: 48, secondi: 0}

  def coordinate_angolo_bottom_left do
    %{nome: "M-571", lon_x: @lon_x_gg_mm_ss, lat_y: @lat_y_gg_mm_ss}
  end

  def quadro_col_row do
    quadro_per_calcoli()
    |> Enum.with_index()
    |> Enum.map(fn {riga, i_riga} ->
      riga
      |> Enum.with_index()
      |> Enum.map(fn {valore, i_col} ->
        {valore, {i_riga, i_col}}
      end)
    end)
    |> List.flatten()
    |> List.flatten()
    |> Enum.sort()
  end

  def quadro_coordinate_left_bottom do
    quadro_col_row()
    |> Enum.map(fn {nome, coordinate_row_colum} ->
      {nome, get_new_base(coordinate_row_colum)}
    end)
  end

  def get_new_base({i_riga_Y, i_col_X}) do
    # Quando {i_riga, i_col} = {0,0} non viene incrementato nulla
    # siamo nello spigolo bottom_left

    x_inc_50 = Incrementi.get_x(50)
    y_inc_50 = Incrementi.get_y(50)

    incremento_x_totale = GradiSessagesimali.moltiplica(x_inc_50, i_col_X)
    incremento_y_totale = GradiSessagesimali.moltiplica(y_inc_50, i_riga_Y)

    new_lon_x = GradiSessagesimali.somma(@lon_x_gg_mm_ss, incremento_x_totale)
    new_lat_y = GradiSessagesimali.somma(@lat_y_gg_mm_ss, incremento_y_totale)

    {new_lon_x, new_lat_y}
  end

  def get_mappa_nome_coordinate do
    quadro_coordinate_left_bottom()
    |> Enum.filter(fn {igm, _coord} -> not String.starts_with?(igm, "M") end)
    |> Enum.into(%{})
  end
end
