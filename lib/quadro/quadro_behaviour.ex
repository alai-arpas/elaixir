defmodule Quadro.QuadroBehaviour do
  alias Elaixir.Coordinate.GradiSessagesimali

  @type incremento :: %{
          x: GradiSessagesimali.t(),
          y: GradiSessagesimali.t()
        }

  @type origine_xlon_ylat :: %{
          x: GradiSessagesimali.t(),
          y: GradiSessagesimali.t()
        }

  @callback scala() :: integer()
  @callback griglia_nomi(String.t()) :: list(list(String.t()))
  @callback origine(String.t()) :: origine_xlon_ylat()
  @callback incremento() :: incremento()
end
