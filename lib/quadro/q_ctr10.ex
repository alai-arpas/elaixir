defmodule Quadro.QCtr10 do
  use Quadro.Base

  alias Quadro.QIgm50

  @nomi [
    ["010", "020", "030", "040"],
    ["050", "060", "070", "080"],
    ["090", "100", "110", "120"],
    ["130", "140", "150", "160"]
  ]

  @impl true
  def scala, do: 10

  @impl true
  def griglia_nomi(prefisso \\ "") do
    for riga <- @nomi do
      for nome <- riga do
        prefisso <> "-" <> nome
      end
    end
  end

  @impl true
  def origine(foglio50) do
    QIgm50.origine_da_igm50(foglio50)
  end
end
