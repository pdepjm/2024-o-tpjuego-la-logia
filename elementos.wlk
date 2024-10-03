object fondoPortada {
	var property position = game.at(0, 0)
	var property imagen = "Designer.jpeg"

	method image() = imagen
}

object fondoNivel1 {
	var property position = game.at(0, 0)
	var property imagen = "background-Level1.png"

	method image() = imagen
}

class Road {
  	var property position

  	method image() = "road1.png"

  	method visual() = game.addVisual(self)
}

class Tree {
  	var property position

  	method image() = "pyramid3.png"

  	method visual() = game.addVisual(self)
  
  	method chocasteCon(personaje) {
		game.say(personaje, "Te comiste un arbol")
	}
}