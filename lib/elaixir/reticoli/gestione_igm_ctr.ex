defmodule Elaixir.Reticoli.GestioneIgmCtr do
  @moduledoc """
  Suddivisio IGM50 per la regione Sardegna, viene rappresentato
  come una griglia regolare di (6 larghezza X 13 altezza)

  Alcune Fogli non esistono perche ricadono a mare
  ad esempio M-571 (questi fogli iniziano con "M-") rappresenta
  il foglio in basso a sinistra che ricade competamente a mare e
  viene usato come base per il calcolo delle coordiante.

  """

  alias Elaixir.Coordinate.GradiSessagesimali
  alias Elaixir.Reticoli.Incrementi

  defstruct igm50_griglia: [],
            igm50_coordinate: [],
            igm50_nomi: [],
            igm25_griglia: [],
            igm25_nomi: [],
            ctr10_griglia: [],
            ctr10_nomi: []

  @type t :: %__MODULE__{
          igm50_griglia: list(),
          igm50_coordinate: list(),
          igm50_nomi: list(),
          igm25_griglia: list(),
          igm25_nomi: list(),
          ctr10_griglia: list(),
          ctr10_nomi: list()
        }

  @type griglia_suddivide :: :ctr10 | :igm25 | :igm50

  @spec griglia_nomi(griglia_suddivide()) :: list()
  def griglia_nomi(griglia_suddivide) do
    case griglia_suddivide do
      :ctr10 ->
        [
          ["010", "020", "030", "040"],
          ["050", "060", "070", "080"],
          ["090", "100", "110", "120"],
          ["130", "140", "150", "160"]
        ]

      :igm25 ->
        [
          ["IV", "I"],
          ["III", "II"]
        ]

      :igm50 ->
        [
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
    end
  end

  def fogli(griglia_suddivide) do
    griglia_nomi(griglia_suddivide)
    |> List.flatten()
    |> List.flatten()
    |> Enum.sort()
  end

  def origine(griglia_suddivide, foglio \\ "M-571") do
    case {griglia_suddivide, foglio} do
      {:ctr10, foglio} ->
        origine_calcola(foglio)

      {:igm25, foglio} ->
        origine_calcola(foglio)

      {:igm50, "M-571"} ->
        %{
          x: %GradiSessagesimali{gradi: 8, minuti: 0, secondi: 0},
          y: %GradiSessagesimali{gradi: 38, minuti: 48, secondi: 0}
        }

      {:igm50, foglio} ->
        origine_calcola(foglio)
    end
  end

  defp origine_calcola(foglio) do
    igm_coordinate =
      Elaixir.Reticoli.Sardegna.info()
      |> Map.get(:igm50_coordinate)

    Map.get(igm_coordinate, foglio)
  end

  def start do
    %__MODULE__{
      igm50_griglia: griglia_nomi(:igm50),
      igm50_coordinate: quadro_coordinate_left_bottom(:igm50),
      igm50_nomi: fogli(:igm50),
      igm25_griglia: griglia_nomi(:igm25),
      igm25_nomi: fogli(:igm25),
      ctr10_griglia: griglia_nomi(:ctr10),
      ctr10_nomi: fogli(:ctr10)
    }
  end

  ###############################################
  #### calcolo coordinate in base a griglia #####
  ###############################################

  def quadro_col_row(griglia_suddivide) do
    #  @type griglia_suddivide :: :ctr10 | :igm25 | :igm50
    # reverse solo per calcolo
    Enum.reverse(griglia_nomi(griglia_suddivide))
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

  def quadro_coordinate_left_bottom(griglia_suddivide, foglio \\ "M-571") do
    quadro_col_row(griglia_suddivide)
    |> Enum.map(fn {nome, coordinate_row_colum} ->
      {nome, get_new_base(griglia_suddivide, coordinate_row_colum, foglio)}
    end)
    |> Enum.into(%{foglio: foglio})
  end

  def get_new_base(griglia_suddivide, {i_riga_Y, i_col_X}, foglio \\ "M-571") do
    # Quando {i_riga, i_col} = {0,0} non viene incrementato nulla
    # siamo nello spigolo bottom_left
    {scala, punto_base_left_bottom} =
      case griglia_suddivide do
        :ctr10 -> {10, origine(:ctr10, foglio)}
        :igm25 -> {25, origine(:igm25, foglio)}
        :igm50 -> {50, origine(:igm50, foglio)}
      end

    %{x: lon_x_gg_mm_ss, y: lat_y_gg_mm_ss} = punto_base_left_bottom
    incrementi = Incrementi.get_for_scala(scala)

    x_inc = Map.get(incrementi, :x)
    y_inc = Map.get(incrementi, :y)

    incremento_x_totale = GradiSessagesimali.moltiplica(x_inc, i_col_X)
    incremento_y_totale = GradiSessagesimali.moltiplica(y_inc, i_riga_Y)

    new_lon_x = GradiSessagesimali.somma(lon_x_gg_mm_ss, incremento_x_totale)
    new_lat_y = GradiSessagesimali.somma(lat_y_gg_mm_ss, incremento_y_totale)

    %{x: new_lon_x, y: new_lat_y}
  end
end
