import Erethia.*
import artefactos.*

object castillo {
    const inventario = #{}

    method inventario() {
        return inventario 
    }

    method depositarArtefactos(artefactos) {
        inventario.addAll(artefactos)
    }

    method inventario(objecto) {
        inventario.add(objecto)
    }

    method artefactoMasPoderosoAqui(personaje) {
        return self.nivelesDePoderDe(personaje).max()
    }

    method nivelesDePoderDe(personaje) {
        return inventario.map({artefacto => artefacto.poderDeObjecto(personaje)})
    }
}

object fortalezaDeAcero {

}

object palacioDeMarmol {

}

object torreDeMarfil {
    
}