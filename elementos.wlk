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
	var property position = game.at(30,3)

	method image() = "start1.png"

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

object fondoSeleccionSkin {
	var property position = game.at(0, 0)
	method image() = "skyblueBackground1.png"	

	const skin1 = new Skins(imagen = "characterA-front.png", position = game.at(5, 13))
	const skin2 = new Skins(imagen = "characterB-front.png", position = game.at(20, 13))
	const skin3 = new Skins(imagen = "characterC-front.png", position = game.at(34, 13))

	method iniciarSkins(){
		game.addVisual(skin1)
		game.addVisual(skin2)
		game.addVisual(skin3)
	}

	method positionSkins() {
		skin1.rotateSkin("characterA-")
		skin2.rotateSkin("characterB-")
		skin3.rotateSkin("characterC-")
	}

	method borrarObjetos() {
		skin1.removeTick()
		skin2.removeTick()
		skin3.removeTick()
		game.removeVisual(skin1)
		game.removeVisual(skin2)
		game.removeVisual(skin3)
	}

	const keycap1 = new Keycap(imagen = "keycap1.png", position = game.at(7, 11))
	const keycap2 = new Keycap(imagen = "keycap2.png", position = game.at(22, 11))
	const keycap3 = new Keycap(imagen = "keycap3.png", position = game.at(36, 11))

	method positionKeycaps() {
		keycap1.visual()
		keycap2.visual()
		keycap3.visual()
	}
}

class Skins {
	var property position = game.at(0,0)
	var property facing = 1
	var property imagen
	method image() = imagen

	method rotateSkin(image) {
		game.onTick(800, "rotar skin" ,{self.actualizarImagen(image)})
	}

	method actualizarImagen(image) {
		if(facing == 1){
			imagen = image + "front.png"
			game.removeVisual(self)
			game.addVisual(self)
			facing = 2
		} else if(facing == 2){
			imagen = image + "left.png"
			game.removeVisual(self)
			game.addVisual(self)
			facing = 3
		} else if(facing == 3){
			imagen = image + "back.png"
			game.removeVisual(self)
			game.addVisual(self)
			facing = 4
		}else if(facing == 4){
			imagen = image + "right.png"
			game.removeVisual(self)
			game.addVisual(self)
			facing = 1
		}
	}

	method removeTick() {
		game.removeTickEvent("rotar skin")
	}
}

class Keycap {
	var property imagen 
	var property position = game.at(0,0)
	method image() = imagen

	method visual() = game.addVisual(self)
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

	method chocasteCon(personaje) {}
}

class Tree {
  	var property position

  	method image() = "pyramid3.png"

  	method visual() = game.addVisual(self)
  
  	method chocasteCon(personaje) {
	}
}

object blood {
	var property position = game.at(0,0)
	var property imagen = "blood1.png"
	method image() = imagen

	method afterCrash(x,y) {
		if(toby.valorVida()>0){
			game.addVisual(self)
			position = game.at(x,y)
			imagen = "blood2.png"
			game.schedule(600, {self.addRemove()})
			game.schedule(601, {imagen = "blood3.png"})
			game.schedule(602,{self.addRemove()})
			game.schedule(850, {game.removeVisual(self)})
		}
	}

	method addRemove(){
		game.removeVisual(self)
		game.addVisual(self)
	}

	method chocasteCon(personaje) {}
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
		personaje.modificarVida(20)
		personaje.restarVida(2)
		imagen = "PixelCar2Crash.png"
		game.schedule(500, {imagen = "PixelCar2Fire.png"})
		game.schedule(1000, {imagen = null})
		blood.afterCrash(position.x(), position.y())
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
	var property imagen = "spr_rally_2.png"
	method image() = imagen

  	override method chocasteCon(personaje) {
		personaje.modificarVida(20)
		personaje.restarVida(2)
		imagen = "spr_rally_2Crash.png"
		game.schedule(500, {imagen = "spr_rally_2Fire.png"})
		game.schedule(1000, {imagen = null})
		blood.afterCrash(position.x(), position.y())
	}

	override method moverse() {
		const x = position.x() - 1
		const y = position.y()
		
		if (x > -3) {
			position = game.at(x, y)
		} else {
			position = game.at(44, y)
			imagen = "spr_rally_2.png"
		}
	}
}

class Chopperita inherits Vehiculo {
	var property imagen = "spr_chopper_2.png"
	method image() = imagen
  
  	override method chocasteCon(personaje) {
		personaje.modificarVida(10)
		personaje.restarVida(1)
		imagen = "spr_chopper_2Crash.png"
		game.schedule(500, {imagen = "spr_chopper_2Fire.png"})
		game.schedule(1000, {imagen = null})
		blood.afterCrash(position.x(), position.y())
	}

	override method moverse() {
    const x = position.x() + 1
    const y = position.y()
    
    if (x < game.width() + 1) {
        position = game.at(x, y)
    } else {
        position = game.at(0, y)
		imagen = "spr_chopper_2.png"
    }
	}
}

class Colectivo inherits Vehiculo {
	var property imagen = "double decker2.png" 
	method image() = imagen
  
  	override method chocasteCon(personaje) {
		personaje.modificarVida(30)
		personaje.restarVida(3)
		imagen = "double decker2Crash.png"
		game.schedule(500, {imagen = "double decker2Fire.png"})
		game.schedule(1000, {imagen = null})
		blood.afterCrash(position.x(), position.y())
	}

	override method moverse() {
		const x = position.x() - 1
		const y = position.y()
		
		if (x > -3) {
			position = game.at(x, y)
		} else {
			position = game.at(44, y)
			imagen = "double decker2.png"
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