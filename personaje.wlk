object toby {
    var property position = game.at(20, 0) // Posición inicial del personaje
    const maxX = 42 // Máximo X (derecho)
    const maxY = 0 // Máximo Y (inferior)
    const minX = 0 // Mínimo X (izquierdo)
    const minY = 23 // Mínimo Y (superior)
    var valorVida = 100
    var property puntos = 0

    method valorVida() = valorVida

    method position(x, y) {
        position = game.at(x, y)
    } 
    
    method image() = "personaje1.png"

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
        
    method modificarVida(valorVehiculo) {
        valorVida = (valorVida - valorVehiculo).max(0)
    } 

    method agarrarMoneda() {
        puntos += 20
    }   

    method perdio()= self.valorVida() == 0
    method gano(puntosNecesarios) = self.puntos() >= puntosNecesarios
}