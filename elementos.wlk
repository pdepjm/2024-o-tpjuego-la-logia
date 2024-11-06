import estados.*
import main.* 
import personaje.*
import escenarios.*
import wollok.game.*


//Elementos de pantalla de carga.
object fondoPortada {
	var property position = game.at(0, 0)
	method image() = "Designer.jpeg"
}

object enter {
	var property position = game.at(30,-3)

	method image() = "image2.png"

	method actualizarEnter() {
			game.onTick(500, "actualizar enter", { => self.visual()})
	}

	method visual() {
		if(game.hasVisual(self)) game.removeVisual(self) else game.addVisual(self)
	}

	method borrarObjeto() {
		game.removeTickEvent("actualizar enter")
	}
}

object wasd {
	var property position = game.at(2,2)

	var property imagen = "black-wasd2.png"

	method image() = imagen

	method actualizarWASD() {
			game.onTick(500, "actualizar wasd", { => self.visual()})
	}

	method visual(){
		if(imagen == "black-wasd2.png"){
			game.removeVisual(self)
			imagen = "white-wasd2.png"
			game.addVisual(self)
		} else {
			game.removeVisual(self)
			imagen = "black-wasd2.png"
			game.addVisual(self)
		}
	}
	
	method borrarObjeto() {
		game.removeTickEvent("actualizar wasd")
	}
}

object fondoNivel1 {
	var property position = game.at(0, 0)
	method image() = "background-Level1.png"
	
}

object fondoGameOver{
	var property position = game.at(0,0) 
	method image() = "gameOverBackground1.png"
}

object fondoWin{
	var property position = game.at(0,0)
	method image() = "win3.png"
}
//Objetos de niveles

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
	}
}

class Vehiculo {
	var property position = game.at(0,0)

	method visual() = game.addVisual(self)

	method chocasteCon(personaje)
	method moverse()
}

class Moneda {
	var property position = game.at(0,0)
	method image() = "coin2.png"

	method chocasteCon(personaje) {
		personaje.agarrarMoneda()
		monedas.removerMonedas(self)
		toby.obtenerMoneda()
	}
}

object monedas { 
	var property listMonedas = []
	var property position = game.at(0,0)

	method generarMonedas(maxMonedas) {
		if(listMonedas.size() < maxMonedas){
			const x = 0.randomUpTo(game.width()-1).truncate(0)
			const y = 0.randomUpTo(game.height()-1).truncate(0)
			const nuevaMoneda = new Moneda(position = game.at(x, y))
			game.addVisual(nuevaMoneda)
			listMonedas.add(nuevaMoneda)
		}
	}

	method removerMonedas(moneda) {
		listMonedas.remove(moneda)
		game.removeVisual(moneda)
	}

	method removerTodasMonedas() {
		listMonedas.forEach({c => game.removeVisual(c)})
		listMonedas.clear()
	}
}

class Car inherits Vehiculo {
	var imagen = "PixelCar2.png"
	method image() = imagen

	override method chocasteCon(personaje) {
		personaje.modificarVida(15)
		imagen = "PixelCar2Crash.png"
		game.schedule(500, {imagen = "PixelCar2Fire.png"})
		game.schedule(1000, {imagen = null})
	}

	override method moverse() {
		const x = position.x() + 1
		const y = position.y()

		if (x < game.width() + 1) {		
			position = game.at(x, y)
		} else {
			position = game.at(0, y)
			imagen = "PixelCar2.png"
		}
	}
}

class FiestaTuneado inherits Vehiculo {
	method image() = "spr_rally_2.png"

  	override method chocasteCon(personaje) {
		personaje.modificarVida(15)
	}

	override method moverse() {
		const x = position.x() - 1
		const y = position.y()
		
		if (x > -3) {
			position = game.at(x, y)
		} else {
			position = game.at(44, y)
		}
	}
}

class Chopperita inherits Vehiculo {
	method image() = "spr_chopper_2.png"
  
  	override method chocasteCon(personaje) {
		personaje.modificarVida(10)
	}

	override method moverse() {
    const x = position.x() + 1
    const y = position.y()
    
    if (x < game.width() + 1) {
        position = game.at(x, y)
    } else {
        position = game.at(0, y)
    }
	}
}

class Colectivo inherits Vehiculo {
	method image() = "double decker2.png"
  
  	override method chocasteCon(personaje) {
		personaje.modificarVida(30)
	}

	override method moverse() {
		const x = position.x() - 1
		const y = position.y()
		
		if (x > -3) {
			position = game.at(x, y)
		} else {
			position = game.at(44, y)
		}
	}
}

//Oleadas de vehiculos

object carTraffic {
	method generarAutos(autos, autosMax, x, y) {
		if(autos.size() < autosMax){
			const nuevoAuto = new Car(position = game.at(x, y))
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

object fiestaTraffic {
	method generarAutos(fiestas, autosMax, x, y) {
		if(fiestas.size() < autosMax){
			const nuevoFiesta = new FiestaTuneado(position = game.at(x, y))
			game.addVisual(nuevoFiesta)
			fiestas.add(nuevoFiesta)
	}
	}

	method moverAutos(fiestas) {
		if(fiestas.size() > 0){
			fiestas.forEach({z => z.moverse()})
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