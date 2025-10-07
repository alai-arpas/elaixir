defmodule Elaixir do
  @moduledoc """
  Documentation for `Elaixir`.
  """

  @doc """
  Author

  ## Examples

      iex> Elaixir.author()
      "Andrea Lai"

  """
  def author do
    "Andrea Lai"
  end

  def directory_dati() do
    :code.priv_dir(:elaixir)
  end
end
