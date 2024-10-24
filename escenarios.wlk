import personaje.*
import elementos.*
import estados.*
import wollok.game.*

object escenario {
    var property nivel = null
    var cont = 1

    method iniciarNivel(nuevoNivel) {
        nuevoNivel.configuracionFondo()
        nuevoNivel.configuracionTeclado()
        nuevoNivel.instanciarObjetos()
        nuevoNivel.configuracionVisual()
        nuevoNivel.configuracionInicial()
        nuevoNivel.configuracionVehiculos()
        nuevoNivel.instanciarObjetosExtra()
        nuevoNivel.configuracionVisualExtra()
        nuevoNivel.finalizarNivel()
        self.nivel(nuevoNivel)
    }

    method nivelPasado() {
        if(cont == 1){
            self.removerNivel()
            self.iniciarNivel(nivel2)
            cont += 1
        }else {
            self.ganarTony()
        }
    }

    method removerNivel(){
        if(nivel != null)
            nivel.removerVisualEscenario()
    }

    method morirToby(){
        self.removerNivel()
        self.iniciarNivel(gameover)
    }

    method ganarTony(){
        self.removerNivel()
        self.iniciarNivel(win)
    }    
}

class Nivel {
    var property objetos = []
    var property objetosExtra = []

    method configuracionInicial(){} 

    method configuracionTeclado(){
		keyboard.w().onPressDo {toby.moverArriba()}
		keyboard.s().onPressDo {toby.moverAbajo()}
		keyboard.d().onPressDo {toby.moverDerecha()}
		keyboard.a().onPressDo {toby.moverIzquierda()}
	}

    method configuracionVisual() {
        objetos.forEach{o => o.visual() }
    }

    method configuracionVisualExtra() {
        objetosExtra.forEach{o => o.visual()}
    }

    method removerVisualEscenario() {
        game.clear()
    }

    method configuracionFondo(){}
    method instanciarObjetos(){}
    method instanciarObjetosExtra(){}
    method configuracionVehiculos(){}
    method finalizarNivel(){}
    
}

object background inherits Nivel {
    override method configuracionTeclado() {
        keyboard.enter().onPressDo { self.pressEnter()}
    }

    override method configuracionFondo() {
        game.addVisual(fondoPortada)
        enter.borrarObjeto()
        enter.actualizarEnter()
    }

    method pressEnter() {
        game.removeVisual(fondoPortada)
        enter.borrarObjeto()
        game.removeVisual(enter)
        escenario.iniciarNivel(nivel1) // Inicia el nuevo nivel
    }
}

object gameover inherits Nivel { //Hacer esto un objeto
    override method configuracionTeclado(){ 
        keyboard.enter().onPressDo { self.pressEnter() }
    }

    override method configuracionFondo() {
        game.addVisual(fondoGameOver)
    }

    method pressEnter() {
        game.removeVisual(fondoGameOver)
        escenario.iniciarNivel(background) // Inicia el nuevo nivel
    }
}

object nivel1 inherits Nivel {
    var property autos1 = []
    var property autos2 = []
    
    var property fiestas1 = []
    var property fiestas2 = []
    
    var property chopper1 = []
    var property chopper2 = []

    var property bus1 = []
    var property bus2 = []

    override method configuracionInicial(){	
        toby.position(20, 0)
		game.addVisualCharacter(toby)
        game.addVisual(puntos)
        game.addVisual(vida)
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
    
        game.onTick(5000, "Generar monedas", {=> monedas.generarMonedas(3)})
    }

    override method instanciarObjetosExtra() {
    }

    method removerFondo() {
        game.removeVisual(fondoNivel1) // Remueve el fondo del nivel actual si cambia de nivel
    }

    override method configuracionVehiculos() {        
        game.onTick(3000, "Oleada autos 1", {=> carTraffic.generarAutos(autos1,2, -4, 2)}) 
        game.onTick(1000, "Oleada autos 2", {=> carTraffic.generarAutos(autos2, 2, -4, 2)})
        // game.onTick(6000, "Oleada autos tres", {=> carTraffic.generarAutos(autos3, 2, -4, 2)}) 

        game.onTick(4500, "Oleada autos 3", {=> carTraffic.generarAutos(autos1,2, -4, 4)}) 
        game.onTick(1900, "Oleada autos 4", {=> carTraffic.generarAutos(autos2, 2, -4, 4)})
        // game.onTick(7000, "Oleada autos tres", {=> carTraffic.generarAutos(autos3, 2, -4, 4)}) 

        game.onTick(4000, "Oleada fiesta 1", {=> fiestaTraffic.generarAutos(fiestas1, 1, 44, 6)}) 
        game.onTick(10000, "Oleada fiesta 2", {=> fiestaTraffic.generarAutos(fiestas2, 1, 44, 6)}) 
        // game.onTick(15000, "Oleada fiesta tres", {=> fiestaTraffic.generarAutos(fiestas3, 1, 44, 6)}) 

        game.onTick(3000, "Oleada chopper 1", {=> chopperTraffic.generarChopper(chopper1 ,1, -4, 9)}) 
        game.onTick(9000, "Oleada chopper 2", {=> chopperTraffic.generarChopper(chopper2, 1, -4, 9)}) 
        // game.onTick(6000, "Oleada chopper tres", {=> chopperTraffic.generarChopper(chopper3, 1, -4, 9)})

        game.onTick(2000, "Oleada bus 1", {=> busTraffic.generarBus(bus1 ,1, 44, 19)}) 
        game.onTick(9000, "Oleada bus 2", {=> busTraffic.generarBus(bus2, 1, 44, 19)}) 
        //game.onTick(6000, "Oleada bus tres", {=> busTraffic.generarBus(bus3, 1, 44, 19)})

        game.onTick(100, "Mover autos 1", {=> carTraffic.moverAutos(autos1)})
        game.onTick(100, "Mover autos 2", {=> carTraffic.moverAutos(autos2)})
        // game.onTick(100, "Mover autos", {=> carTraffic.moverAutos(autos3)})

        game.onTick(100, "Mover fiestas 1", {=> fiestaTraffic.moverAutos(fiestas1)})
        game.onTick(100, "Mover fiestas 2", {=> fiestaTraffic.moverAutos(fiestas2)})
        // game.onTick(100, "Mover fiestas", {=> fiestaTraffic.moverAutos(fiestas3)})

        game.onTick(100, "Mover chopperas 1", {=> chopperTraffic.moverChopper(chopper1)})
        game.onTick(100, "Mover chopperas 2", {=> chopperTraffic.moverChopper(chopper2)})
        //game.onTick(100, "Mover chopperas", {=> chopperTraffic.moverChopper(chopper3)})

        game.onTick(100, "Mover bus 1", {=> chopperTraffic.moverChopper(bus1)})
        game.onTick(100, "Mover bus 2", {=> chopperTraffic.moverChopper(bus2)})
        // game.onTick(100, "Mover bus", {=> chopperTraffic.moverChopper(bus3)})
    }

    method loseLevel() { 
        if(toby.perdio()) {
            self.removeObjects()
            monedas.removerTodasLasMonedas()
            game.removeVisual(fondoNivel1)
            escenario.iniciarNivel(gameover)
        }
    }

    method removeObjects() {
        objetos.forEach{o => game.removeVisual(o)}
        objetosExtra.forEach{o => game.removeVisual(o)}
        autos1.forEach{a => game.removeVisual(a)}
        autos2.forEach{a => game.removeVisual(a)}
        fiestas1.forEach{a => game.removeVisual(a)}
        fiestas2.forEach{a => game.removeVisual(a)}
        chopper1.forEach{a => game.removeVisual(a)}
        chopper2.forEach{a => game.removeVisual(a)}
        bus1.forEach{a => game.removeVisual(a)}
        bus2.forEach{a => game.removeVisual(a)}
        game.removeVisual(toby)
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
        game.removeTickEvent("Mover fiestas 1")
        game.removeTickEvent("Mover fiestas 2")
        game.removeTickEvent("Mover chopperas 1")
        game.removeTickEvent("Mover chopperas 2")
        game.removeTickEvent("Mover bus 1")
        game.removeTickEvent("Mover bus 2")
        game.removeTickEvent("Generar monedas")
        objetos.clear()
        objetosExtra.clear()
        autos1.clear()
        autos2.clear()
        fiestas1.clear()
        fiestas2.clear()
        chopper1.clear()
        chopper2.clear()
        bus1.clear()
        bus2.clear()
    }

    method winLevel() {
        if(toby.gano(150)) {
            game.removeVisual(fondoNivel1) 
            escenario.iniciarNivel(win)
        }
    }

    override method finalizarNivel(){
        game.whenCollideDo(toby, {algo => self.loseLevel() })
    }
}

object nivel2 inherits Nivel{}

object win inherits Nivel{}