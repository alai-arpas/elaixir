defmodule Quadro.Base do
  defmacro __using__(_opts) do
    quote do
      @behaviour Quadro.QuadroBehaviour
      import Quadro.Base
      alias Elaixir.Reticoli.Incrementi

      @impl true
      def incremento do
        Incrementi.get_for_scala(scala())
      end
    end
  end

  # ========== FUNZIONE BASE ==========

  # converte tuple {g,m,s} in decimal
  def dms_to_decimal({g, m, s}) do
    g + m / 60 + s / 3600
  end
end
