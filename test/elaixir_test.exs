defmodule ElaixirTest do
  use ExUnit.Case
  doctest Elaixir

  test "Author" do
    assert Elaixir.author() == "Andrea Lai"
  end
end
