import moradas.*
import artefactos.*

object rolando {
    var capacidadMaxima = 2
    const artefactos = #{}
    const historiaDeArtefactos = []
    var poderBase = 0
    const morada = castillo
    const enemigos = []

    method encontrarArtefacto(artefacto) {
        self.agarrarArtefactoSiEsQuePuede(artefacto)
        historiaDeArtefactos.add(artefacto)
    }

    method capacidadMaxima(nuevaCap) {
        capacidadMaxima = nuevaCap
    }

    method agarrarArtefactoSiEsQuePuede(artefacto) {
        if (self.tieneEspacio()) {
            artefactos.add(artefacto)
        }
    }

    method artefactos() {
        return artefactos
    }

    method tieneEspacio() {
        return artefactos.size() < capacidadMaxima
    }

    method llegarASuMorada() {
        morada.depositarArtefactos(self.artefactos())
        artefactos.clear()
    }

    method poseciones() {
        return morada.inventario().union(self.artefactos()) 
    }

    method tieneA(artefacto) {
        return self.poseciones().contains(artefacto)
    }

    method historiaDeArtefactos() {
        return historiaDeArtefactos
    }

    method poderBase(nuevoPoder) {
        poderBase = nuevoPoder
    }

    method poderBase() {
        return poderBase
    }

    method poderDePelea() {
        return poderBase + self.poderObjectos()
    }

    method poderObjectos() {
      return self.artefactos().sum({objecto => objecto.poderDeObjecto(self)})
    }

    method pelearBatalla() {
        self.usarObjectos()
        poderBase = poderBase + 1
    }

    method usarObjectos() {
        artefactos.forEach({objecto => objecto.usarObjecto()})
    }

    method artefactoMasPoderosoDeSuMorada() {
        return morada.artefactoMasPoderosoAqui(self)
    }

    method enemigosVencibles() {
        return enemigos.filter({enemigo => enemigo.puedeSerVencido(self)})
    }

    method moradasConquistables() {
        return self.enemigosVencibles().map({enemigo => enemigo.morada()})
    }

    method enemigos() {
        return enemigos
    }

    method enemigos(nuevoEnemigo) {
        enemigos.add(nuevoEnemigo)
    }

    method esPoderoso() {
        return self.puedeVencerASusEnemigos()
    }

    method puedeVencerASusEnemigos() {
        return enemigos.all({enemigo => enemigo.puedeSerVencido(self)})
    } 

    method artefactoLetalContra(enemigo) {
        return artefactos.find({artefacto  => artefacto.esLetalContra(self , enemigo)})
    }
    
    method tieneArtefactoLetalContra(enemigo) {
       return artefactos.contains(self.artefactoLetalContra(enemigo))
    }
}

object caterina {
    const morada = fortalezaDeAcero

    method poderDePelea() {
        return 28
    }

    method morada() {
        return morada
    }

    method puedeSerVencido(personaje) {
        return personaje.poderDePelea() > self.poderDePelea()
    }
}

object archibaldo {
    const morada = palacioDeMarmol

    method poderDePelea() {
        return 16
    }

    method morada() {
        return morada
    }

    method puedeSerVencido(personaje) {
        return personaje.poderDePelea() > self.poderDePelea()
    }
}

object astra {
    const morada = torreDeMarfil

    method poderDePelea() {
        return 14
    }
    method morada() {
        return morada
    }

    method puedeSerVencido(personaje) {
        return personaje.poderDePelea() > self.poderDePelea()
    }
}