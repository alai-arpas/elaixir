defmodule Quadro.Gestore do
  alias Quadro.QIgm50, as: Q50

  defstruct griglia: [], left_bottom: []

  def new(modulo, foglio \\ "") do
    %__MODULE__{griglia: modulo.griglia_nomi(foglio)}
  end

  def start do
    Q50.griglia_nomi()
  end
end
