defmodule Elaixir.Reticoli.QuadroIgm50Sardegna do
  alias Elaixir.Coordinate.GradiSessagesimali
  alias Elaixir.Reicoli.Incrementi

  @tabella [
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

  def quadro_bottom_left do
    @tabella
  end

  def quadro_top_left do
    Enum.reverse(@tabella)
  end

  @lon_x_gg_mm_ss %GradiSessagesimali{gradi: 8, minuti: 0, secondi: 0}
  @lat_y_gg_mm_ss %GradiSessagesimali{gradi: 38, minuti: 48, secondi: 0}

  def coordinate_angolo_bottom_left do
    %{nome: "M-571", lon_x: @lon_x_gg_mm_ss, lat_y: @lat_y_gg_mm_ss}
  end

  @doc """
  Converte una mappa %{gradi: g, minuti: m, secondi: s} in decimale.
  """
  def to_decimale(%{gradi: g, minuti: m, secondi: s}) do
    g + m / 60 + s / 3600
  end

  @doc """
  Converte un valore decimale in una mappa %{gradi: g, minuti: m, secondi: s}.
  I secondi sono arrotondati all’intero più vicino.
  """
  def to_sessagesimali(valore) do
    gradi = trunc(valore)
    minuti_float = (valore - gradi) * 60
    minuti = trunc(minuti_float)
    secondi = round((minuti_float - minuti) * 60)

    # correzione overflow secondi → minuti
    {minuti, secondi} =
      if secondi == 60 do
        {minuti + 1, 0}
      else
        {minuti, secondi}
      end

    # correzione overflow minuti → gradi
    {gradi, minuti} =
      if minuti == 60 do
        {gradi + 1, 0}
      else
        {gradi, minuti}
      end

    %{gradi: gradi, minuti: minuti, secondi: secondi}
  end

  def get_igm do
    # lon_x_decimale = to_decimale(@lon_x_gg_mm_ss)
    # lat_y_decimale = to_decimale(@lat_y_gg_mm_ss)

    quadro_top_left()
    |> Enum.with_index()
    |> Enum.map(fn {riga, i_riga} ->
      riga
      |> Enum.with_index()
      |> Enum.map(fn {valore, i_col} ->
        {valore, {i_riga, i_col}}
      end)
    end)
  end

  def get_igm_left_bottom do
    quadro_top_left()
    |> Enum.with_index()
    |> Enum.map(fn {riga, i_riga} ->
      riga
      |> Enum.with_index()
      |> Enum.map(fn {valore, i_col} ->
        {valore, {i_riga, i_col}, get_new_base({i_riga, i_col})}
      end)
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

  def get_igm_validi do
    get_igm_left_bottom()
    |> List.flatten()
    |> Enum.filter(fn {igm, _riga_colonna, _coord} -> not String.starts_with?(igm, "M") end)
    |> Enum.map(fn {igm, _riga_colonna, {x, y}} -> {igm, x, y} end)
  end

  def elabora_dammi_10_punti({igm, x, y}) do
    x_inc_10 = Incrementi.get_x(10)
    y_inc_10 = Incrementi.get_y(10)
    {igm, x, y, x_inc_10, y_inc_10}
  end
end
