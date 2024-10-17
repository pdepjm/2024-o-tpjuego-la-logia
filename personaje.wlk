object main {
    var property position = game.at(20, 0) // Posición inicial del personaje
    var property imagen = "personaje1.png"
    const maxX = 42 // Máximo X (derecho)
    const maxY = 0 // Máximo Y (inferior)
    const minX = 0 // Mínimo X (izquierdo)
    const minY = 23 // Mínimo Y (superior)
    var valorVida = 100
    
    method image() = imagen

    method modificarVida(valorVehiculo) {
        valorVida = (valorVida - valorVehiculo).max(0)

    } 
    method moverArriba() {
        if (position.y() < minY) { // Solo moverse si no supera el borde superior
            position = position.up(1)
        }
    }

    method moverAbajo() {
        if (position.y() > maxY) { // Solo moverse si no supera el borde inferior
            position = position.down(1)
        }
    }

    method moverDerecha() {
        if (position.x() < maxX) { // Solo moverse si no supera el borde derecho
            position = position.right(1)
        }
    }

    method moverIzquierda() {
        if (position.x() > minX) { // Solo moverse si no supera el borde izquierdo
            position = position.left(1)
        }
    }


}