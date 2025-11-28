defmodule ElaixirTest do
  use ExUnit.Case
  doctest Elaixir

  test "Author" do
    assert Elaixir.author() == "Andrea Lai"
  end

  test "griglia" do
    assert Griglia.spazia() == [
             {"1", 1, 1, {0, 0}, 28, 16, {0, 0}},
             {"2", 1, 2, {0, 0}, 28, 16, {0, 16}},
             {"3", 1, 3, {0, 0}, 28, 16, {0, 32}},
             {"4", 1, 4, {0, 0}, 28, 16, {0, 48}},
             {"5", 2, 1, {0, 0}, 28, 16, {28, 0}},
             {"6", 2, 2, {0, 0}, 28, 16, {28, 16}},
             {"7", 2, 3, {0, 0}, 28, 16, {28, 32}},
             {"8", 2, 4, {0, 0}, 28, 16, {28, 48}}
           ]
  end
end
