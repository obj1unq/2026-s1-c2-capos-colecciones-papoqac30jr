import Erethia.*
import moradas.*

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
        return if (personaje.poderBase() > 6) {
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
        return if (hechizos.size() >= 1) {
            self.poderDeHechizo(hechizos.first() , personaje)
        } else {
            0
        }
    }

    method poderDeHechizo(hechizo , personaje) {
        return hechizo.poder(personaje)
    }

    method hechizos(nuevoHechizo) {
        hechizos.add(nuevoHechizo)
    } 

    method usarObjecto() {
        if (hechizos.size() >= 1) {
        hechizos.remove(hechizos.first())
        }
    }
}

object armaduraDeAceroValyrio { 
    method poderDeObjecto(personaje) {
        return 6
    }

    method usarObjecto() {

    }
}

object invisibilidad {
    method poder(personaje) {
        return personaje.poderBase()
    }
}

object bendicion {
    method poder(personaje) {
        return 4
    }
}

object invocacion {
    method poder(personaje) {
        return personaje.artefactoMasPoderosoDeSuMorada()
    }
}