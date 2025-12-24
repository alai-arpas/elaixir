defmodule Quadro.Gestore do
  alias Quadro.QIgm50, as: Q50

  defstruct griglia_50: []

  def start do
    Q50.griglia_nomi()
  end
end
