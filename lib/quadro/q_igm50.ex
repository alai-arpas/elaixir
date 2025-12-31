defmodule Quadro.QIgm50 do
  use Quadro.Base

  @griglia [
    ["M-408", "M-409", "M-410", "411", "412", "M-413"],
    ["425", "M-425", "426", "427", "428", "M-429"],
    ["440", "441", "442", "443", "444", "445"],
    ["458", "459", "460", "461", "462", "463"],
    ["478", "479", "480", "481", "482", "483"],
    ["M-496", "497", "498", "499", "500", "501"],
    ["M-513", "514", "515", "516", "517", "518"],
    ["M-527", "528", "529", "530", "531", "532"],
    ["M-537", "538", "539", "540", "541", "M-542"],
    ["M-543", "546", "547", "548", "549", "M-550"],
    ["M-554", "555", "556", "557", "558", "M-559"],
    ["563", "564", "565", "566", "567", "M-568"],
    ["M-571", "572", "573", "M-573", "M-574", "M-575"]
  ]

  @impl true
  def scala, do: 50

  @impl true
  def griglia_nomi(_non_usato_per_50 \\ ""), do: @griglia

  @impl true
  def origine(_non_usato_per_50_fisso \\ "M-571") do
    %{
      x: %GradiSessagesimali{gradi: 8, minuti: 0, secondi: 0},
      y: %GradiSessagesimali{gradi: 38, minuti: 48, secondi: 0}
    }
  end

  def origine_da_igm50(foglio) do
    foglio
  end
end
