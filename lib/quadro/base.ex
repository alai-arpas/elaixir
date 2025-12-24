defmodule Quadro.Base do
  defmacro __using__(_opts) do
    quote do
      @behaviour Quadro.QuadroBehaviour
      alias Quadro.Base, as: Qbase
      alias Elaixir.Reticoli.Incrementi
      alias Elaixir.Coordinate.GradiSessagesimali

      @impl true
      def incremento do
        Incrementi.get_for_scala(scala())
      end

      def modulo do
        __MODULE__
      end
    end
  end

  def scale, do: [:ctr10, :igm25, :igm50]
end
