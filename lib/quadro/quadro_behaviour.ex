defmodule Quadro.QuadroBehaviour do
  alias Elaixir.Coordinate.GradiSessagesimali

  @type incremento :: %{
          x: GradiSessagesimali.t(),
          y: GradiSessagesimali.t()
        }

  @callback scala() :: integer()
  @callback griglia_nomi(String.t()) :: list(list(String.t()))
  @callback origin(String.t()) :: {float(), float()}
  @callback incremento() :: incremento()
end
