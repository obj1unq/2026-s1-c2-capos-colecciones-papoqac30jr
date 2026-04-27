object rolando {
    var capacidadMaxima = 2
    const artefactos = #{}
    const historiaDeArtefactos = []
    var poderBase = 0

    method encontrarArtefacto(artefacto) {
        if (self.verificarMochila()) {
            artefactos.add(artefacto)
            historiaDeArtefactos.add(artefacto)
        } else {
            historiaDeArtefactos.add(artefacto)
        }
    }

    method capacidadMaxima(nuevaCap) {
        capacidadMaxima = nuevaCap
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
        return if (personaje.poderBase() <= 6) {
            3
        } else {
            poderCollar + usos
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
        artefactos.forEach({nuevoArtefacto => inventario.add(nuevoArtefacto)})
    }

    method poderDelObjectoMasPoderoso(personaje) {
        return self.elMasPoderosoEn(inventario , personaje)
    }

    method elMasPoderosoEn(artefactos , personaje) {
        var elMasPoderosoActual = artefactos.min()
        artefactos.forEach({artefacto => elMasPoderosoActual = self.elMasPoderosoEntre(elMasPoderosoActual , artefacto , personaje)})
        return elMasPoderosoActual
    }

    method elMasPoderosoEntre(unArtefacto , otroArtefacto , personaje) {
        return if(unArtefacto.poderDeObjecto(personaje) > otroArtefacto.poderDeObjecto(personaje)) {
            unArtefacto
        } else {
            otroArtefacto
        }
    }

    method inventario(objecto) {
        inventario.add(objecto)
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
        return castillo.poderDelObjectoMasPoderoso(personaje)
    }
}