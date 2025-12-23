alias Elaixir.Coordinate.GradiSessagesimali, as: GS

alias Elaixir.Reticoli.Incrementi, as: Incrementi



alias Elaixir.Reticoli.QuadroIgm50Sardegna, as: IgmQ50

alias Elaixir.Coordinate.PuntoGS


a = GS.make(%{gradi: 10, minuti: 59, secondi: 45})
b = GS.make(%{gradi: 2, minuti: 2, secondi: 30})
c = GS.make(%{gradi: 0, minuti: 5, secondi: 0})


alias CargCad.Vestizione

alias Elaixir.Repo

alias Griglia

alias Quadro.QCtr10
alias Quadro.QIgm50


g = Griglia.spazia()
