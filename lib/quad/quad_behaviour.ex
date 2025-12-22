defmodule Quad.QuadBehaviour do
  @callback scala() :: integer()
  @callback nomi(String.t()) :: list(list(String.t()))
  @callback origin() :: {float(), float()}
end
