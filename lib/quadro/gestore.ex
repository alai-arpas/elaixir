defmodule Quadro.Gestore do
  alias Elaixir.Coordinate.GradiSessagesimali
  alias Elaixir.Reticoli.Incrementi
  defstruct griglia: nil, left_bottom: []

  @type t :: %__MODULE__{
          griglia: list(),
          left_bottom: list() | nil
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

  def fogli_igm50() do
    griglia_nomi(:igm50)
    |> List.flatten()
    |> List.flatten()
    |> Enum.sort()
  end

  def origine(griglia_suddivide, foglio \\ "M-571") do
    case griglia_suddivide do
      :ctr10 ->
        origine_calcola(foglio)

      :igm25 ->
        origine_calcola(foglio)

      :igm50 ->
        %{
          x: %GradiSessagesimali{gradi: 8, minuti: 0, secondi: 0},
          y: %GradiSessagesimali{gradi: 38, minuti: 48, secondi: 0}
        }
    end
  end

  defp origine_calcola(_foglio) do
    %{
      x: %GradiSessagesimali{gradi: 8, minuti: 0, secondi: 0},
      y: %GradiSessagesimali{gradi: 38, minuti: 48, secondi: 0}
    }
  end

  def start do
    quadro_col_row(:igm50)
  end

  ###############################################
  #### calcolo coordinate in base a griglia #####
  ###############################################

  def quadro_col_row(griglia_suddivide) do
    #  @type griglia_suddivide :: :ctr10 | :igm25 | :igm50
    griglia_nomi(griglia_suddivide)
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
    |> Enum.into(%{})
  end

  def get_new_base(griglia_suddivide, {i_riga_Y, i_col_X}, foglio \\ "M-571") do
    # Quando {i_riga, i_col} = {0,0} non viene incrementato nulla
    # siamo nello spigolo bottom_left
    {scala, punto_base_left_bottom} =
      case griglia_suddivide do
        :ctr10 -> {10, origine(:ctr10, foglio)}
        :igm25 -> {25, origine(:igm25, foglio)}
        :igm50 -> {50, origine(:igm50)}
      end

    %{x: lon_x_gg_mm_ss, y: lat_y_gg_mm_ss} = punto_base_left_bottom
    incrementi = Incrementi.get_for_scala(scala)

    x_inc = Map.get(incrementi, :x)
    y_inc = Map.get(incrementi, :y)

    incremento_x_totale = GradiSessagesimali.moltiplica(x_inc, i_col_X)
    incremento_y_totale = GradiSessagesimali.moltiplica(y_inc, i_riga_Y)

    new_lon_x = GradiSessagesimali.somma(lon_x_gg_mm_ss, incremento_x_totale)
    new_lat_y = GradiSessagesimali.somma(lat_y_gg_mm_ss, incremento_y_totale)

    {new_lon_x, new_lat_y}
  end
end
