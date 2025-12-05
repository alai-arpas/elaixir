defmodule Quad.Base do
  defmacro __using__(_opts) do
    quote do
      @behaviour Quad.QuadBehaviour
      import Quad.Base

      # gli incrementi li legge da qui
      @increments %{
        10 => %{x: {0, 5, 0}, y: {0, 3, 0}},
        25 => %{x: {0, 10, 0}, y: {0, 6, 0}},
        50 => %{x: {0, 20, 0}, y: {0, 12, 0}}
      }
    end
  end

  # ========== FUNZIONE BASE ==========

  # converte tuple {g,m,s} in decimal
  def dms_to_decimal({g, m, s}) do
    g + m / 60 + s / 3600
  end
end
