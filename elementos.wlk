object fondoPortada {
	var property position = game.at(0, 0)
	var property imagen = "Designer.jpeg"

	method image() = imagen
}

object fondoNivel1 {
	var property position = game.at(0, 1)
	var property imagen = "pollo.jpg"

	method image() = imagen
}

object start {
	var property position = game.at(3, 2)
	var property imagen = "pollo.jpg"

	method image() = "pollo.jpg"

	method actualizarStart() {
		game.onTick(300, "actualizarStart", { => self.visual() })
	}

	method visual() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		} else {
			game.addVisual(self)
		}
	}
}
