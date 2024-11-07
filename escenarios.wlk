import personaje.*
import elementos.*
import estados.*
import wollok.game.*

object escenario {
    var property nivel = null

    method iniciarNivel(nuevoNivel) {
        nuevoNivel.configuracionFondo()
        if(!background.x()) nuevoNivel.configuracionTeclado()
        nuevoNivel.instanciarObjetos()
        nuevoNivel.configuracionVisual()
        nuevoNivel.configuracionInicial()
        nuevoNivel.configuracionVehiculos()
        nuevoNivel.instanciarObjetosExtra()
        nuevoNivel.configuracionVisualExtra()
        nuevoNivel.finalizarNivel()
        nuevoNivel.ganarNivel()
        self.nivel(nuevoNivel)
    }

    method nivelPasado() {
            nivel1.removeObjects()
            toby.valorVida(100)
            toby.puntos(0)
            toby.monedasRestantes(1)
            toby.vidaRestante(1)
            self.iniciarNivel(nivel2)
    }

    method morirToby(){
        gameover.configuracionFondo()
    }

    method ganarToby(){
        nivel1.removeObjects()
        win.configuracionFondo()
    }    
}

class Nivel {
    var property objetos = []
    var property objetosExtra = []
    var property autos1 = []
    var property autos2 = []
    var property autos3 = []
    var property fiestas1 = []
    var property fiestas2 = []
    var property chopper1 = []
    var property chopper2 = []
    var property chopper3 = []
    var property bus1 = []
    var property bus2 = []

    method configuracionInicial(){} 

    method configuracionTeclado(){
        keyboard.w().onPressDo {toby.moverArriba()}
		keyboard.s().onPressDo {toby.moverAbajo()}
		keyboard.d().onPressDo {toby.moverDerecha()}
		keyboard.a().onPressDo {toby.moverIzquierda()}
        keyboard.up().onPressDo {toby.moverArriba()}
		keyboard.down().onPressDo {toby.moverAbajo()}
		keyboard.right().onPressDo {toby.moverDerecha()}
		keyboard.left().onPressDo {toby.moverIzquierda()}
	}

    method configuracionVisual() {
        objetos.forEach{o => o.visual() }
    }

    method configuracionVisualExtra() {
        objetosExtra.forEach{o => o.visual()}
    }

    method removeObjects() {
    }

    method actualizarBarras(){
        self.actualizarBarraVida()
        self.actualizarBarraPoder()
    }

    method actualizarBarraVida() {
            game.removeVisual(barraVida)
            game.addVisual(barraVida)
    }

    method actualizarBarraPoder() {
            game.removeVisual(barraPuntos)
            game.addVisual(barraPuntos)
    }

    method configuracionFondo(){}
    method instanciarObjetos(){}
    method instanciarObjetosExtra(){}
    method configuracionVehiculos(){}
    method finalizarNivel(){}
    method ganarNivel(){}
}

object background inherits Nivel {
    var property x = false
    override method configuracionTeclado() {
            keyboard.enter().onPressDo { self.pressEnter()}
            keyboard.m().onPressDo { self.pressM()}
    }

    override method configuracionFondo() {
        game.addVisual(fondoPortada)
        wasd.actualizarWASD()
        enter.actualizarEnter()
    }

    method pressEnter() {
        game.removeVisual(fondoPortada)
        wasd.borrarObjeto()
        enter.borrarObjeto()
        game.removeVisual(enter)
        game.removeVisual(wasd)
        toby.puntos(0)
        toby.valorVida(100)
        toby.monedasRestantes(1)
        toby.vidaRestante(1)
        escenario.iniciarNivel(nivel1) // Inicia el nuevo nivel
        x = true
    }

    method pressM() { 
        game.removeVisual(fondoPortada)
        wasd.borrarObjeto()
        enter.borrarObjeto()
        game.removeVisual(enter)
        game.removeVisual(wasd)
        escenario.iniciarNivel(selectSkin)
    }
}

object selectSkin inherits Nivel {
    override method configuracionTeclado() {
        keyboard.num(1).onPressDo {self.selectedCharacter() toby.whichSkin(1)}
        keyboard.num(2).onPressDo {self.selectedCharacter() toby.whichSkin(2)}
        keyboard.num(3).onPressDo {self.selectedCharacter() toby.whichSkin(3)}
        keyboard.enter().onPressDo {self.pressEnter()}
    }

    override method configuracionFondo() {
        game.addVisual(fondoSeleccionSkin)
        fondoSeleccionSkin.iniciarSkins()
        fondoSeleccionSkin.positionSkins()
        fondoSeleccionSkin.positionKeycaps()
    }

    method selectedCharacter() {
        game.removeVisual(fondoSeleccionSkin)
        fondoSeleccionSkin.borrarObjetos()
        escenario.iniciarNivel(background)
    }

    method pressEnter(){}
}

object win {
    method configuracionFondo() {
        game.addVisual(fondoWin)
    }
}

object gameover { 
    method configuracionTeclado(){ 
        keyboard.r().onPressDo { self.pressR() }
    }

    method configuracionFondo() {
        game.addVisual(fondoGameOver)
    }

    method pressR() {
        game.removeVisual(fondoGameOver)
        escenario.iniciarNivel(background) // Inicia el nuevo nivel
    }
}

object nivel1 inherits Nivel {
    override method configuracionInicial(){	
        toby.position(20, 0)
		game.addVisual(toby)
        game.addVisual(barraVida)
        game.addVisual(barraPuntos)
        game.whenCollideDo(toby, {algo => self.actualizarBarras()})
        game.onCollideDo(toby,{algo => algo.chocasteCon(toby) })
	}

    override method configuracionFondo() {
        game.addVisual(fondoNivel1)
    }

    override method instanciarObjetos() {
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
    
        game.onTick(1000, "Generar monedas", {=> monedas.generarMonedas(3)})
    }

    override method instanciarObjetosExtra() {
    }

    override method configuracionVehiculos() {        
        game.onTick(3000, "Oleada autos 1", {=> carTraffic.generarAutos(autos1,2, -4, 2)}) 
        game.onTick(1000, "Oleada autos 2", {=> carTraffic.generarAutos(autos2, 2, -4, 2)})

        game.onTick(4500, "Oleada autos 3", {=> carTraffic.generarAutos(autos1,2, -4, 4)}) 
        game.onTick(1900, "Oleada autos 4", {=> carTraffic.generarAutos(autos2, 2, -4, 4)})

        game.onTick(4500, "Oleada autos 5", {=> carTraffic.generarAutos(autos3, 2, -4, 20)})
        game.onTick(1900, "Oleada autos 6", {=> carTraffic.generarAutos(autos3, 2, -4, 20)})

        game.onTick(4000, "Oleada fiesta 1", {=> fiestaTraffic.generarAutos(fiestas1, 1, 44, 6)}) 
        game.onTick(10000, "Oleada fiesta 2", {=> fiestaTraffic.generarAutos(fiestas2, 1, 44, 6)}) 

        game.onTick(3000, "Oleada chopper 1", {=> chopperTraffic.generarChopper(chopper1 ,1, -4, 9)}) 
        game.onTick(9000, "Oleada chopper 2", {=> chopperTraffic.generarChopper(chopper2, 1, -4, 9)}) 

        game.onTick(3000, "Oleada chopper 3", {=> chopperTraffic.generarChopper(chopper3, 1, -4, 21)}) 
        game.onTick(9000, "Oleada chopper 4", {=> chopperTraffic.generarChopper(chopper3, 1, -4, 21)}) 

        game.onTick(2000, "Oleada bus 1", {=> busTraffic.generarBus(bus1 ,1, 44, 19)}) 
        game.onTick(9000, "Oleada bus 2", {=> busTraffic.generarBus(bus2, 1, 44, 19)}) 

        game.onTick(100, "Mover autos 1", {=> carTraffic.moverAutos(autos1)})
        game.onTick(100, "Mover autos 2", {=> carTraffic.moverAutos(autos2)})
        game.onTick(100, "Mover autos 3", {=> carTraffic.moverAutos(autos3)})

        game.onTick(100, "Mover fiestas 1", {=> fiestaTraffic.moverAutos(fiestas1)})
        game.onTick(100, "Mover fiestas 2", {=> fiestaTraffic.moverAutos(fiestas2)})

        game.onTick(100, "Mover chopperas 1", {=> chopperTraffic.moverChopper(chopper1)})
        game.onTick(100, "Mover chopperas 2", {=> chopperTraffic.moverChopper(chopper2)})
        game.onTick(100, "Mover chopperas 3", {=> chopperTraffic.moverChopper(chopper3)})

        game.onTick(100, "Mover bus 1", {=> busTraffic.moverBus(bus1)})
        game.onTick(100, "Mover bus 2", {=> busTraffic.moverBus(bus2)})
    }

    method loseLevel() { 
        if(toby.perdio()) {
            self.removeObjects()
            escenario.morirToby()
        }
    }

    method winLevel() {
        if(toby.gano(20)) {
            escenario.nivelPasado()
        }
    }

    override method finalizarNivel(){
        game.whenCollideDo(toby, {algo => self.loseLevel() })
    }

    override method ganarNivel(){
		game.whenCollideDo(monedas, {algo => self.winLevel()})
    }

    override method removeObjects() {
        game.removeVisual(toby)
        objetos.forEach{o => game.removeVisual(o)}
        objetosExtra.forEach{o => game.removeVisual(o)}
        autos1.forEach{a => game.removeVisual(a)}
        autos2.forEach{a => game.removeVisual(a)}
        autos3.forEach{a => game.removeVisual(a)}
        fiestas1.forEach{a => game.removeVisual(a)}
        fiestas2.forEach{a => game.removeVisual(a)}
        chopper1.forEach{a => game.removeVisual(a)}
        chopper2.forEach{a => game.removeVisual(a)}
        chopper3.forEach{a => game.removeVisual(a)}
        bus1.forEach{a => game.removeVisual(a)}
        bus2.forEach{a => game.removeVisual(a)}
        game.removeTickEvent("Oleada autos 1")
        game.removeTickEvent("Oleada autos 2")
        game.removeTickEvent("Oleada autos 3")
        game.removeTickEvent("Oleada autos 4")
        game.removeTickEvent("Oleada fiesta 1")
        game.removeTickEvent("Oleada fiesta 2")
        game.removeTickEvent("Oleada chopper 1")
        game.removeTickEvent("Oleada chopper 2")
        game.removeTickEvent("Oleada bus 1")
        game.removeTickEvent("Oleada bus 2")
        game.removeTickEvent("Mover autos 1")
        game.removeTickEvent("Mover autos 2")
        game.removeTickEvent("Mover autos 3")
        game.removeTickEvent("Mover fiestas 1")
        game.removeTickEvent("Mover fiestas 2")
        game.removeTickEvent("Mover chopperas 1")
        game.removeTickEvent("Mover chopperas 2")
        game.removeTickEvent("Mover chopperas 3")
        game.removeTickEvent("Mover bus 1")
        game.removeTickEvent("Mover bus 2")
        game.removeTickEvent("Generar monedas")
        objetos.forEach{a => objetos.remove(a)}
        objetosExtra.forEach{a => objetosExtra.remove(a)}
        autos1.forEach{a => autos1.remove(a)}
        autos2.forEach{a => autos2.remove(a)}
        fiestas1.forEach{a => fiestas1.remove(a)}
        fiestas2.forEach{a => fiestas2.remove(a)}
        chopper1.forEach{a => chopper1.remove(a)}
        chopper2.forEach{a => chopper2.remove(a)}
        bus1.forEach{a => bus1.remove(a)}
        bus2.forEach{a => autos2.remove(a)}
        game.removeVisual(barraVida)
        game.removeVisual(barraPuntos)
        game.removeVisual(fondoNivel1)
        monedas.removerTodasMonedas()
    }
}

object nivel2 inherits Nivel{
    override method configuracionInicial(){	
        toby.position(20, 0)
		game.addVisualCharacter(toby)
        game.removeVisual(barraVida)
        game.removeVisual(barraPuntos)
        game.addVisual(barraVida)
        game.addVisual(barraPuntos)
        game.whenCollideDo(toby, {algo => self.actualizarBarras()})
        game.onCollideDo(toby,{algo => algo.chocasteCon(toby) })
	}

    override method configuracionFondo() {
        game.addVisual(fondoNivel1)
    }

    override method instanciarObjetos() {
        objetos.add(new Road(position = game.at(0, 3)))
        objetos.add(new Road(position = game.at(0, 4)))
        objetos.add(new Road(position = game.at(0, 6)))
        objetos.add(new Road(position = game.at(0, 7)))
        objetos.add(new Road(position = game.at(0, 9)))
        objetos.add(new Road(position = game.at(0, 10)))
        objetos.add(new Road(position = game.at(0, 11)))
        objetos.add(new Road(position = game.at(0, 13)))
        objetos.add(new Road(position = game.at(0, 15)))
        objetos.add(new Road(position = game.at(0, 16)))
        objetos.add(new Road(position = game.at(0, 18)))
        objetos.add(new Road(position = game.at(0, 19)))
        objetos.add(new Road(position = game.at(0, 20)))
    
        game.onTick(1000, "Generar monedas", {=> monedas.generarMonedas(3)})
    }

    override method configuracionVehiculos() {        
        // Configuramos las oleadas para que coincidan con las posiciones de los caminos
        game.onTick(3000, "Oleada autos n1", {=> carTraffic.generarAutos(autos1, 2, -4, 3)}) 
        game.onTick(1000, "Oleada autos n2", {=> carTraffic.generarAutos(autos2, 2, -4, 4)})

        game.onTick(4500, "Oleada autos n3", {=> carTraffic.generarAutos(autos1, 2, -4, 6)}) 
        game.onTick(1900, "Oleada autos n4", {=> carTraffic.generarAutos(autos2, 2, -4, 7)})

        game.onTick(4000, "Oleada fiesta n1", {=> fiestaTraffic.generarAutos(fiestas1, 1, 44, 9)}) 
        game.onTick(10000, "Oleada fiesta n2", {=> fiestaTraffic.generarAutos(fiestas2, 1, 44, 10)}) 

        game.onTick(3000, "Oleada chopper n1", {=> chopperTraffic.generarChopper(chopper1, 1, -4, 11)}) 
        game.onTick(9000, "Oleada chopper n2", {=> chopperTraffic.generarChopper(chopper2, 1, -4, 13)}) 

        game.onTick(2000, "Oleada bus n1", {=> busTraffic.generarBus(bus1, 1, 44, 15)}) 
        game.onTick(9000, "Oleada bus n2", {=> busTraffic.generarBus(bus2, 1, 44, 16)}) 

        game.onTick(100, "Mover autos 1", {=> carTraffic.moverAutos(autos1)})
        game.onTick(100, "Mover autos 2", {=> carTraffic.moverAutos(autos2)})

        game.onTick(100, "Mover fiestas 1", {=> fiestaTraffic.moverAutos(fiestas1)})
        game.onTick(100, "Mover fiestas 2", {=> fiestaTraffic.moverAutos(fiestas2)})

        game.onTick(100, "Mover chopperas 1", {=> chopperTraffic.moverChopper(chopper1)})
        game.onTick(100, "Mover chopperas 2", {=> chopperTraffic.moverChopper(chopper2)})

        game.onTick(100, "Mover bus 1", {=> chopperTraffic.moverChopper(bus1)})
        game.onTick(100, "Mover bus 2", {=> chopperTraffic.moverChopper(bus2)})
    }

    method loseLevel() { 
        if(toby.perdio()) {
            nivel1.removeObjects()
            escenario.morirToby()
        }
    }

    method winLevel() {
        if(toby.gano(200)) {
            escenario.ganarToby()
        }
    }

    override method finalizarNivel() {
        game.whenCollideDo(toby, {algo => self.loseLevel()})
    }

    override method ganarNivel() {
        game.whenCollideDo(monedas, {algo => self.winLevel()})
    }
}