defmodule CargCad.Vestizione do
  defstruct descrizione: "",
            iniziale: "",
            numero_layer: "",
            layers: [],
            index_blocco: "",
            nomi_blocchi: [],
            pattern_line: "",
            layer_output: "",
            linea_continua: "",
            strato: 18

  @nome_file_vestizione "carg_cad/carg_rete_vestizione.txt"

  def directory_dati() do
    :code.priv_dir(:elaixir)
  end

  def nome_file_base() do
    Path.join(directory_dati(), @nome_file_vestizione)
  end

  def read_file_vestizione(nome_file \\ nome_file_base()) do
    separatore_riga_windows = "\n"

    lista_vestizioni_carg =
      File.read!(nome_file)
      |> String.split(separatore_riga_windows, trim: true)
      |> Enum.chunk_by(&is_separatore?/1)
      |> Enum.reject(fn blocco -> blocco |> List.first() |> is_separatore?() end)
      |> Enum.drop(1)

    lista_vestizioni_carg
  end

  def is_separatore?(riga) do
    String.starts_with?(riga, "/**")
  end

  def crea() do
    %__MODULE__{}
  end

  # STEP 1
  def estrai_descrizione(lista) do
    [desc | lista] = lista
    # "N:Faglia Transtensiva SINISTRA Certa"
    descrizione = desc |> String.split(":") |> Enum.drop(1) |> hd
    {descrizione, lista}
  end

  # STEP 2
  def estrai_iniziale(lista) do
    # INZIALE - si puo usare come index
    [iniziale | lista] = lista
    {iniziale, lista}
  end

  # STEP 3
  def estrai_layers(lista) do
    # NUMERO_LAYER
    [numero_layer | lista] = lista
    numero_layer = String.to_integer(numero_layer)

    prendi_numero = numero_layer + 1
    layers = Enum.take(lista, prendi_numero)
    # lista per prossima elaborazione
    lista = Enum.drop(lista, prendi_numero)
    {layers, lista}
  end

  def carica_vestizioni_da_file(nome_file \\ nome_file_base()) do
    read_file_vestizione(nome_file)
    |> crea()
  end

  def crea(lista) when is_list(lista) do
    # ATTENZIONE gli INDICI partono da "0"
    # per questo i numero dei Layer e Blocchi
    # hanno + 1

    {descrizione, lista} = estrai_descrizione(lista)
    {iniziale, lista} = estrai_iniziale(lista)
    {layers, lista} = estrai_layers(lista)

    # INDEX_BLOCK
    index_blocco = hd(lista) |> String.to_integer()
    prendi_blocchi = index_blocco + 1
    lista = Enum.drop(lista, prendi_blocchi)
    nomi_blocchi = Enum.take(lista, prendi_blocchi)
    # lista per prossima elaborazione
    lista = Enum.drop(lista, 1)

    # LAYER_OUTPUT
    layer_output = hd(lista)
    # lista per prossima elaborazione
    lista = Enum.drop(lista, 1)

    # PATTERN_LINE
    pattern_line = hd(lista)
    # lista per prossima elaborazione
    lista = Enum.drop(lista, 1)

    # LINEA CONTINUA ? SI/NO
    continua = hd(lista)

    linea_continua =
      if continua == "SI" do
        true
      else
        false
      end

    %__MODULE__{
      descrizione: descrizione,
      iniziale: iniziale,
      numero_layer: Enum.count(layers) - 1,
      layers: layers,
      index_blocco: index_blocco,
      nomi_blocchi: nomi_blocchi,
      layer_output: layer_output,
      pattern_line: pattern_line,
      linea_continua: linea_continua
    }
  end
end
