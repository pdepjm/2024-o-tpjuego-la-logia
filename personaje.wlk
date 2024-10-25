object toby {
    var property position = game.at(20, 0) // Posición inicial del personaje
    const maxX = 42 // Máximo X (derecho)
    const maxY = 0 // Máximo Y (inferior)
    const minX = 0 // Mínimo X (izquierdo)
    const minY = 23 // Mínimo Y (superior)
    var property valorVida = 100
    var property puntos = 0
    var property barraVida = 1
    var property barraPuntos = 1
    var property flag = 0
    var property flagLife = 0

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

    method vidaPromedio() {
        if(self.valorVida() >= 90 && self.valorVida() <= 100){
            self.barraVida(2)
        } else if(self.valorVida() >= 80 && self.valorVida() < 90){
            self.barraVida(3)
        } else if(self.valorVida() >= 70 && self.valorVida() < 80){
            self.barraVida(4)
        } else if(self.valorVida() >= 60 && self.valorVida() < 70){
            self.barraVida(5)
        } else if(self.valorVida() >= 50 && self.valorVida() < 60){
            self.barraVida(6)
        } else if(self.valorVida() >= 40 && self.valorVida() < 50){
            self.barraVida(7)
        } else if(self.valorVida() >= 30 && self.valorVida() < 40){
            self.barraVida(8)
        } else if(self.valorVida() >= 20 && self.valorVida() < 30){
            self.barraVida(9)
        } else if(self.valorVida() >= 10 && self.valorVida() < 20){
            self.barraVida(10)
        } else if(self.valorVida() >= 0 && self.valorVida() < 10){
            self.barraVida(11)
        }
    }

    method puntoPromedio() {
        if(self.puntos() > 180 && self.puntos() <= 200){
            self.barraPuntos(11)
        } else if(self.puntos() > 160  && self.puntos() <= 180){
            self.barraPuntos(10)
        } else if(self.puntos() > 140 && self.puntos() <= 160){
            self.barraPuntos(9)
        } else if(self.puntos() > 120 && self.puntos() <= 140){
            self.barraPuntos(8)
        } else if(self.puntos() > 100 && self.puntos() <= 120){
            self.barraPuntos(7)
        } else if(self.puntos() > 80 && self.puntos() <= 100){
            self.barraPuntos(6)
        } else if(self.puntos() > 60 && self.puntos() <= 80){
            self.barraPuntos(5)
        } else if(self.puntos() > 40 && self.puntos() <= 60){
            self.barraPuntos(4)
        } else if(self.puntos() > 20 && self.puntos() <= 40){
            self.barraPuntos(3)
        } else if(self.puntos() > 0 && self.puntos() <= 20){
            self.barraPuntos(2)
        } 
    }
}