import personaje.*
import elementos.*
import estados.*
import wollok.game.*

object escenario {
var property nivel = null

    method iniciarNivel(nuevoNivel) {
        nuevoNivel.configuracionFondo()
        nuevoNivel.configuracionTeclado()
        nuevoNivel.instanciarObjetos()
        nuevoNivel.configuracionVisual()
        nuevoNivel.configuracionInicial()
        nuevoNivel.instanciarObjetosExtra()
        nuevoNivel.configuracionVisualExtra()
        self.nivel(nuevoNivel)
    }
}
 
class Background {
    method configuracionInicial() {
    }

    method configuracionTeclado() {
        keyboard.enter().onPressDo { self.pressEnter() }
    }

    method configuracionFondo() {
        game.addVisual(fondoPortada)
    }

    method pressEnter() {
        const nivel1 = new Nivel1()
        game.removeVisual(fondoPortada) // Elimina el fondo actual
        escenario.iniciarNivel(nivel1) // Inicia el nuevo nivel
    }

    method instanciarObjetos() {
    }

    method configuracionVisual() {
    }

    method configuracionVisualExtra() {
    }

    method instanciarObjetosExtra() {
    }
}


class Nivel1 {
    var property objetos = []
    var property objetosExtra = [] 

    method configuracionInicial(){		
		game.addVisualCharacter(main)
        game.addVisual(puntos)
        game.addVisual(vida)
        game.onCollideDo(main,{algo => algo.chocasteCon(main)})
        game.onTick(10000, "Oleada autos dos", {=> carTraffic.generarAutos(5)}) 
        game.onTick(8000, "Oleada autos", {=> carTraffic.generarAutos(3)}) 
        game.onTick(4000, "Oleada autos dos", {=> carTraffic.generarAutos(3)}) 

        game.onTick(15000, "Oleada fiesta dos", {=> fiestaTraffic.generarAutos(5)}) 
        game.onTick(9000, "Oleada fiesta", {=> fiestaTraffic.generarAutos(2)}) 
        game.onTick(4000, "Oleada fiesta dos", {=> fiestaTraffic.generarAutos(3)}) 

        game.onTick(100, "Mover autos", {=> carTraffic.moverAutos()})
        game.onTick(150, "Mover autos", {=> fiestaTraffic.moverAutos()})
	}
	
	method configuracionTeclado(){
		keyboard.w().onPressDo {main.moverArriba()}
		keyboard.s().onPressDo {main.moverAbajo()}
		keyboard.d().onPressDo {main.moverDerecha()}
		keyboard.a().onPressDo {main.moverIzquierda()}
        keyboard.up().onPressDo {main.moverArriba()}
		keyboard.down().onPressDo {main.moverAbajo()}
		keyboard.right().onPressDo {main.moverDerecha()}
		keyboard.left().onPressDo {main.moverIzquierda()}
	}

    method configuracionFondo() {
        game.addVisual(fondoNivel1)
    }

    method instanciarObjetos() {
        
        objetos.add(new Road(position = game.at(0, 2)))
        objetos.add(new Road(position = game.at(0, 4)))
        objetos.add(new Road(position = game.at(0, 6)))
        objetos.add(new Road(position = game.at(0, 7)))
        objetos.add(new Road(position = game.at(0, 9)))
        objetos.add(new Road(position = game.at(0, 11)))
        objetos.add(new Road(position = game.at(0, 12)))
        objetos.add(new Road(position = game.at(0, 14)))
        objetos.add(new Road(position = game.at(0, 15)))
        objetos.add(new Road(position = game.at(0, 17)))
        objetos.add(new Road(position = game.at(0, 19)))
        objetos.add(new Road(position = game.at(0, 20)))
        objetos.add(new Road(position = game.at(0, 21)))
    }

    method instanciarObjetosExtra() {
        
        // objetosExtra.add(new Tree(position = game.at(8, 0)))
        // objetosExtra.add(new Tree(position = game.at(25, 1)))
        // objetosExtra.add(new Tree(position = game.at(38, 1)))
        // objetosExtra.add(new Tree(position = game.at(5, 3)))
        // objetosExtra.add(new Tree(position = game.at(30, 3)))
        // objetosExtra.add(new Tree(position = game.at(41, 3)))
        // objetosExtra.add(new Tree(position = game.at(40, 5)))
        // objetosExtra.add(new Tree(position = game.at(25, 5)))
        // objetosExtra.add(new Tree(position = game.at(15, 5)))
        // objetosExtra.add(new Tree(position = game.at(39, 8)))
        // objetosExtra.add(new Tree(position = game.at(31, 8)))
        // objetosExtra.add(new Tree(position = game.at(14, 8)))
        // objetosExtra.add(new Tree(position = game.at(36, 10)))
        // objetosExtra.add(new Tree(position = game.at(22, 10)))
        // objetosExtra.add(new Tree(position = game.at(4, 10)))
        // objetosExtra.add(new Tree(position = game.at(41, 13)))
        // objetosExtra.add(new Tree(position = game.at(25, 13)))
        // objetosExtra.add(new Tree(position = game.at(2, 13)))
        // objetosExtra.add(new Tree(position = game.at(40, 18)))
        // objetosExtra.add(new Tree(position = game.at(23, 18)))
        // objetosExtra.add(new Tree(position = game.at(9, 18)))
        // objetosExtra.add(new Tree(position = game.at(1, 16)))
        // objetosExtra.add(new Tree(position = game.at(19, 16)))
        // objetosExtra.add(new Tree(position = game.at(1, 23)))
        // objetosExtra.add(new Tree(position = game.at(19, 23)))
        // objetosExtra.add(new Tree(position = game.at(40, 23)))

        // objetosExtra.add(new Car(position = game.at(-4, 2)))
        // objetosExtra.add(new Car(position = game.at(-4, 4)))
        // objetosExtra.add(new Car(position = game.at(-4, 7)))
        // objetosExtra.add(new Car(position = game.at(-4, 12)))

        // objetosExtra.add(new FiestaTuneado(position = game.at(44, 6)))
        // objetosExtra.add(new FiestaTuneado(position = game.at(44, 11)))

        // objetosExtra.add(new Chopperita(position = game.at(-4, 9)))
        // objetosExtra.add(new Chopperita(position = game.at(-4, 17)))

        // objetosExtra.add(new Colectivo(position = game.at(-4, 14)))
    }

    method configuracionVisual() {
        objetos.forEach{o => o.visual() }
    }

    method configuracionVisualExtra() {
        objetosExtra.forEach{o => o.visual()}
    }

    method removerFondo() {
        game.removeVisual(fondoNivel1) // Remueve el fondo del nivel actual si cambia de nivel
    }
}