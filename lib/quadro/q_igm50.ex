defmodule Quadro.QIgm50 do
  use Quadro.Base

  @impl true
  def scala, do: 50

  @impl true
  def griglia_nomi(_non_usato_per_50 \\ "") do
    [
      ["M-408", "M-409", "M-410", "411", "412", "M-413"]
    ]
  end

  @impl true
  def origin(_non_usato_per_50 \\ "") do
    # esempio
    {39.9, 8.7}
  end

  def origine_da_igm50(foglio) do
    foglio
  end
end
