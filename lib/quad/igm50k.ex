defmodule Quad.Igm50k do
  use Quad.Base

  @impl true
  def scala, do: 50

  @impl true
  def nomi do
    [
      ["M-408", "M-409", "M-410", "411", "412", "M-413"]
    ]
  end

  @impl true
  def origin do
    # esempio
    {39.9, 8.7}
  end
end
