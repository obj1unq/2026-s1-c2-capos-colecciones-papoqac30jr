import capos.*
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
        return self.nivelesDePoderDe(inventario , personaje).max()
    }

    method nivelesDePoderDe(lista , personaje) {
        return lista.map({artefacto => artefacto.poderDeObjecto(personaje)})
    }
}