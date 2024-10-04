import wollok.game.*

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
	} 
}

class Road {
  	var property position

  	method image() = "road1.png"

  	method visual() = game.addVisual(self)

	method chocasteCon(personaje) {
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
    var property position = game.at(0, 0)

    method image() = "PixelCar2.png"

    method visual() = game.addVisual(self)

    method chocasteCon(personaje) {
        game.say(personaje, "Te chocaste con un auto")
    }

    method moverse() {
        const x = position.x() + 1
        const y = position.y()
        
        if (x < game.width() + 1) {
            position = game.at(x, y)
        } else {
            position = game.at(0, y)
        }
    }
}


class FiestaTuneado {
	var property position = game.at(0,0)

	method image() = "spr_rally_2.png"

	method visual() = game.addVisual(self)
  
  	method chocasteCon(personaje) {
		game.say(personaje, "Te chocaste con un fiestita tuneado")
	}

method moverse() {
    const x = position.x() - 1
    const y = position.y()
    
    if (x > -3) {
        position = game.at(x, y)
    } else {
        position = game.at(44, y)
    }
}
}

class Chopperita {
	var property position = game.at(0,0)

	method image() = "spr_chopper_2.png"

	method visual() = game.addVisual(self)
  
  	method chocasteCon(personaje) {
		game.say(personaje, "Te chocaste con una Chopperita")
	}

	method moverse() {
    const x = position.x() + 1
    const y = position.y()
    
    if (x < game.width() + 1) {
        position = game.at(x, y)
    } else {
        position = game.at(0, y)
    }
	}
}

class Colectivo {
	var property position = game.at(0,0)

	method image() = "double decker2.png"

	method visual() = game.addVisual(self)
  
  	method chocasteCon(personaje) {
		game.say(personaje, "Te chocaste con un 101")
	}

method moverse() {
    const x = position.x() - 1
    const y = position.y()
    
    if (x > -3) {
        position = game.at(x, y)
    } else {
        position = game.at(44, y)
    }
}
}

object carTraffic {
	var property autos = []

	method generarAutos(autosMax) {
		if(autos.size() < autosMax){
			const nuevoAuto = new Car(position = game.at(-4, 2))
			game.addVisual(nuevoAuto)
			autos.add(nuevoAuto)
	}
	}

	method moverAutos() {
		if(autos.size() > 0){
			autos.forEach({z => z.moverse()})
		}
	}
}

object fiestaTraffic {
	var property autos = []

	method generarAutos(autosMax) {
		if(autos.size() < autosMax){
			const nuevoAuto = new FiestaTuneado(position = game.at(44, 6))
			game.addVisual(nuevoAuto)
			autos.add(nuevoAuto)
	}
	}

	method moverAutos() {
		if(autos.size() > 0){
			autos.forEach({z => z.moverse()})
		}
	}
}
