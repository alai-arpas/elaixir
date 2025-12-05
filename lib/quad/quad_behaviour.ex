defmodule Quad.QuadBehaviour do
  @callback scala() :: integer()
  @callback nomi() :: list(list(String.t()))
  @callback origin() :: {float(), float()}
end
