object rolando {
    var capacidadMaxima = 2
    const artefactos = #{}
    const historiaDeArtefactos = []
    var poderBase = 0
    var morada = castillo

    method encontrarArtefacto(artefacto) {
        self.agarrarArtefactoSiEsQuePuede(artefacto)
        historiaDeArtefactos.add(artefacto)
    }

    method capacidadMaxima(nuevaCap) {
        capacidadMaxima = nuevaCap
    }

    method agarrarArtefactoSiEsQuePuede(artefacto) {
        if (self.verificarMochila()) {
            artefactos.add(artefacto)
        }
    }

    method artefactos() {
        return artefactos
    }

    method verificarMochila() {
        return artefactos.size() < capacidadMaxima
    }

    method llegarA(hogar) {
        hogar.depositarArtefactos(self.artefactos())
        artefactos.clear()
    }

    method poseciones() {
        return castillo.inventario().union(self.artefactos()) 
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
        self.artefactos().forEach({objecto => objecto.usarObjecto()})
        poderBase = poderBase + 1
    }

    method artefactoMasPoderosoDeSuMorada() {
        return morada.artefactoMasPoderosoAqui(self)
    }
}

object espadaDelDestino {
    var fueUsada = false
    const poderDespuesDelPrimerGolpe = {poder => poder / 2}
    method poderDeObjecto(personaje) {
      return if (not self.fueUsada()) {
        personaje.poderBase()
      } else {
        poderDespuesDelPrimerGolpe.apply(personaje.poderBase())
      }
    }
    
    method fueUsada() {
        return fueUsada
    }

    method usarObjecto() {
        fueUsada = true
    }
}

object collarDivino {
    const poderCollar = 3
    var usos = 0

    method poderDeObjecto(personaje) {
        return poderCollar + self.poderBonus(personaje)
    }

    method poderBonus(personaje) {
        return if (personaje.poderBase() >= 6) {
            usos
        } else {
            0
        }
    }

    method usarObjecto() {
        usos = usos +1
    }
}

object libroDeHechizo {
    const hechizos = []

    method poderDeObjecto(personaje) {
        return hechizos.poder(personaje)
    }

    method hechizos(nuevoHechizo) {
        hechizos.add(nuevoHechizo)
    } 

    method usarObjecto() {
        
    }
}

object armaduraDeAceroValyrio { 
    const poder = 6
    method poderDeObjecto(personaje) {
        return poder
    }
}

object castillo {
    const inventario = #{}

    method inventario() {
        return inventario 
    }

    method depositarArtefactos(artefactos) {
        inventario.addAll(artefactos)
    }

    method poderDelObjectoMasPoderoso(personaje) {
        return 
    }

    method inventario(objecto) {
        inventario.add(objecto)
    }

    method artefactoMasPoderosoAqui(personaje) {
        return self.nivelesDePoderDe(inventario , personaje).max()
    }

    method nivelesDePoderDe(lista , personaje) {
        return lista.map({artefacto => artefacto.poderDeObjecto(personaje)})
    }
}

object invisibilidad {
    method poder(personaje) {
        return personaje.poderBase()
    }
}

object bendicion {
    const poder = 4
    method poder(personaje) {
        return poder
    }
}

object invocacion {
    method poder(personaje) {
        return personaje.artefactoMasPoderosoDeSuMorada()
    }
}