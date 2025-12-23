defmodule Quadro.QCtr10 do
  use Quadro.Base

  @nomi [
    ["010", "020", "030", "040"],
    ["050", "060", "070", "080"],
    ["090", "100", "110", "120"],
    ["130", "140", "150", "160"]
  ]

  @impl true
  def scala, do: 10

  @impl true
  def griglia_nomi(_prefisso \\ "") do
    @nomi
  end

  @impl true
  def origin(_foglio50) do
    # esempio
    {39.9, 8.7}
  end
end
