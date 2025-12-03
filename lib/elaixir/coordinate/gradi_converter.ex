defmodule Elaixir.Coordinate.GeoConverter do
  @doc """
  Converte una mappa %{gradi: g, minuti: m, secondi: s} in decimale.
  """
  def to_decimale(%{gradi: g, minuti: m, secondi: s}) do
    g + m / 60 + s / 3600
  end

  @doc """
  Converte un valore decimale in una mappa %{gradi: g, minuti: m, secondi: s}.
  I secondi sono arrotondati all’intero più vicino.
  """
  def to_sessagesimali(valore) do
    gradi = trunc(valore)
    minuti_float = (valore - gradi) * 60
    minuti = trunc(minuti_float)
    secondi = round((minuti_float - minuti) * 60)

    # correzione overflow secondi → minuti
    {minuti, secondi} =
      if secondi == 60 do
        {minuti + 1, 0}
      else
        {minuti, secondi}
      end

    # correzione overflow minuti → gradi
    {gradi, minuti} =
      if minuti == 60 do
        {gradi + 1, 0}
      else
        {gradi, minuti}
      end

    %{gradi: gradi, minuti: minuti, secondi: secondi}
  end
end
