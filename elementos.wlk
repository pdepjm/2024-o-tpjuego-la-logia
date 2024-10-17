import estados.*
import wollok.game.*

object fondoPortada {
	var property position = game.at(0, 0)
	var property imagen = "Designer.jpeg"

	method image() = imagen
}

object fondoGameOver{
	var property position = game.at(0,0)
	var property imagen = "995812.png"
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

class Car {
    var property position = game.at(0, 0)

    method image() = "PixelCar2.png"

    method visual() = game.addVisual(self)

    method chocasteCon(personaje) {
        game.say(personaje, "Te chocaste con un auto")
		personaje.modificarVida(15)
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
		personaje.modificarVida(15)
		
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
		personaje.modificarVida(10)
		
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
		personaje.modificarVida(30)
		
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
	method generarAutos(fiestas, autosMax, x, y) {
		if(fiestas.size() < autosMax){
			const nuevoAuto = new Car(position = game.at(x, y))
			game.addVisual(nuevoAuto)
			fiestas.add(nuevoAuto)
	}
	}

	method moverAutos(fiestas) {
		if(fiestas.size() > 0){
			fiestas.forEach({z => z.moverse()})
		}
	}
}

object fiestaTraffic {
	method generarAutos(autos, autosMax, x, y) {
		if(autos.size() < autosMax){
			const nuevoAuto = new FiestaTuneado(position = game.at(x, y))
			game.addVisual(nuevoAuto)
			autos.add(nuevoAuto)
	}
	}

	method moverAutos(autos) {
		if(autos.size() > 0){
			autos.forEach({z => z.moverse()})
		}
	}
}

object chopperTraffic {

	method generarChopper(choppers, chopperMax, x, y) {
		if(choppers.size() < chopperMax){
			const nuevaChoppe = new Chopperita(position = game.at(x, y))
			game.addVisual(nuevaChoppe)
			choppers.add(nuevaChoppe)
	}
	}

	method moverChopper(choppers) {
		if(choppers.size() > 0){
			choppers.forEach({z => z.moverse()})
		}
	}
}

object busTraffic {

	method generarBus(bus, busMax, x, y) {
		if(bus.size() < busMax){
			const nuevoBus = new Colectivo(position = game.at(x, y))
			game.addVisual(nuevoBus)
			bus.add(nuevoBus)
	}
	}

	method moverBus(bus) {
		if(bus.size() > 0){
			bus.forEach({z => z.moverse()})
		}
	}
}