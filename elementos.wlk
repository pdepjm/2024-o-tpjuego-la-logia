object fondoPortada {
	var property position = game.at(0, 0)
	var property imagen = "Designer.jpeg"

	method image() = imagen
}

object fondoNivel1 {
	var property position = game.at(0, 0)
	var property imagen = "background-Level1.png"

	method image() = imagen
	
	method chocasteCon(personaje) {
		game.say(personaje, "Te chocaste con el fondo")
	} 
}

class Road {
  	var property position

  	method image() = "road1.png"

  	method visual() = game.addVisual(self)

	method chocasteCon(personaje) {
		game.say(personaje, "Te chocaste con la ruta")
	} 

	method moverse(){}
}

class Tree {
  	var property position

  	method image() = "pyramid3.png"

  	method visual() = game.addVisual(self)
  
  	method chocasteCon(personaje) {
		game.say(personaje, "Te comiste un arbol")
	}
}

class Car {
	var property position = game.at(0,0)

	method image() = "PixelCar.png"

	method visual() = game.addVisual(self)
  
  	method chocasteCon(personaje) {
		game.say(personaje, "Te chocaste con un auto")
	}

method moverse() {
    const x = position.x() + 1
    const y = position.y()
    
    // Comprueba si el auto está dentro de los límites
    if (x < game.width()) {
        position = game.at(x, y)
    } else {
        // Si el auto sale de la pantalla, reiniciarlo a la izquierda
        position = game.at(0, y)
    }
}

}