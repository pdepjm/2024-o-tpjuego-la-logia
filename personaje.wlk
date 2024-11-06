object toby {
    var property position = game.at(20, 0) // Posición inicial del personaje
    const maxX = 42 // Máximo X (derecho)
    const maxY = 0 // Máximo Y (inferior)
    const minX = 0 // Mínimo X (izquierdo)
    const minY = 23 // Mínimo Y (superior)
    var property valorVida = 100
    var property puntos = 0
    var monedasRestantes = 1
    var vidaRestante = 1
    var property barraVida = null
    var property direction = "back"

    
    method position(x, y) {
        position = game.at(x, y)
    } 
    
    method image() = "characterr-"+self.direction() +".png"

    method moverArriba() {
        if (position.y() < minY) { // Solo moverse si no supera el borde superior
            position = position.up(1)
            direction = "back"
        }
    }

    method moverAbajo() {
        if (position.y() > maxY) { // Solo moverse si no supera el borde inferior
            position = position.down(1)
            direction = "front"
        }
    }

    method moverDerecha() {
        if (position.x() < maxX) { // Solo moverse si no supera el borde derecho
            position = position.right(1)
            direction = "rigth" //Se me patino la th
        }
    }

    method moverIzquierda() {
        if (position.x() > minX) { // Solo moverse si no supera el borde izquierdo
            position = position.left(1)
            direction = "left"
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

    method obtenerMoneda() {
        monedasRestantes += 1
    }

    method restarVida(valor){
        vidaRestante += valor
    }

    method monedasRestantes() = monedasRestantes
    method vidaRestante() = vidaRestante
}