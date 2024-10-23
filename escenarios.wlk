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
            const nivel2 = new Nivel2()
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
        const gameover = new Gameover()
        self.iniciarNivel(gameover)
    }

    method ganarTony(){
        self.removerNivel()
        const ganar = new Win()
        self.iniciarNivel(ganar)
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

class Background inherits Nivel {
    override method configuracionTeclado() {
        keyboard.enter().onPressDo { self.pressEnter()}
    }

    override method configuracionFondo() {
        game.addVisual(fondoPortada)
        enter.actualizarEnter()
    }

    method pressEnter() {
        const nivel1 = new Nivel1()
        escenario.removerNivel()
        escenario.iniciarNivel(nivel1) // Inicia el nuevo nivel
    }
}

class Gameover inherits Nivel { 
    override method configuracionTeclado(){ 
        keyboard.enter().onPressDo { self.pressEnter() }
    }

    override method configuracionFondo() {
        game.addVisual(fondoGameOver)
    }

    override method configuracionTeclado() {
        keyboard.enter().onPressDo { self.pressEnter()}
    }

    method pressEnter() {
        const portada = new Background()
        escenario.iniciarNivel(portada) // Inicia el nuevo nivel
    }
}

class Nivel1 inherits Nivel {
    override method configuracionInicial(){	
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
    }

    override method instanciarObjetosExtra() {
        
    }

    method removerFondo() {
        game.removeVisual(fondoNivel1) // Remueve el fondo del nivel actual si cambia de nivel
    }

    override method configuracionVehiculos() {
        const autos1 = []
        const autos2 = []
        const autos3 = []
        
        const fiestas1 = []
        const fiestas2 = []
        const fiestas3 = []
        
        const chopper1 = []
        const chopper2 = []
        const chopper3 = []

        const bus1 = []
        const bus2 = []
        const bus3 = []
        
        game.onTick(3000, "Oleada autos", {=> carTraffic.generarAutos(autos1,2, -4, 2)}) 
        game.onTick(1000, "Oleada primer auto", {=> carTraffic.generarAutos(autos2, 2, -4, 2)})
        // game.onTick(6000, "Oleada autos tres", {=> carTraffic.generarAutos(autos3, 2, -4, 2)}) 

        game.onTick(4500, "Oleada autos", {=> carTraffic.generarAutos(autos1,2, -4, 4)}) 
        game.onTick(1900, "Oleada primer auto", {=> carTraffic.generarAutos(autos2, 2, -4, 4)})
        // game.onTick(7000, "Oleada autos tres", {=> carTraffic.generarAutos(autos3, 2, -4, 4)}) 

        game.onTick(4000, "Oleada fiesta", {=> fiestaTraffic.generarAutos(fiestas1, 1, 44, 6)}) 
        game.onTick(10000, "Oleada fiesta dos", {=> fiestaTraffic.generarAutos(fiestas2, 1, 44, 6)}) 
        // game.onTick(15000, "Oleada fiesta tres", {=> fiestaTraffic.generarAutos(fiestas3, 1, 44, 6)}) 

        game.onTick(3000, "Oleada chopper", {=> chopperTraffic.generarChopper(chopper1 ,1, -4, 9)}) 
        game.onTick(9000, "Oleada chopper dos", {=> chopperTraffic.generarChopper(chopper2, 1, -4, 9)}) 
        // game.onTick(6000, "Oleada chopper tres", {=> chopperTraffic.generarChopper(chopper3, 1, -4, 9)})

        game.onTick(2000, "Oleada bus", {=> busTraffic.generarBus(bus1 ,1, 44, 19)}) 
        game.onTick(9000, "Oleada bus dos", {=> busTraffic.generarBus(bus2, 1, 44, 19)}) 
        //game.onTick(6000, "Oleada bus tres", {=> busTraffic.generarBus(bus3, 1, 44, 19)})

        game.onTick(100, "Mover autos", {=> carTraffic.moverAutos(autos1)})
        game.onTick(100, "Mover autos", {=> carTraffic.moverAutos(autos2)})
        // game.onTick(100, "Mover autos", {=> carTraffic.moverAutos(autos3)})

        game.onTick(100, "Mover fiestas", {=> fiestaTraffic.moverAutos(fiestas1)})
        game.onTick(100, "Mover fiestas", {=> fiestaTraffic.moverAutos(fiestas2)})
        // game.onTick(100, "Mover fiestas", {=> fiestaTraffic.moverAutos(fiestas3)})

        game.onTick(100, "Mover chopperas", {=> chopperTraffic.moverChopper(chopper1)})
        game.onTick(100, "Mover chopperas", {=> chopperTraffic.moverChopper(chopper2)})
        //game.onTick(100, "Mover chopperas", {=> chopperTraffic.moverChopper(chopper3)})

        game.onTick(100, "Mover bus", {=> chopperTraffic.moverChopper(bus1)})
        game.onTick(100, "Mover bus", {=> chopperTraffic.moverChopper(bus2)})
        // game.onTick(100, "Mover bus", {=> chopperTraffic.moverChopper(bus3)})
    }

    method loseLevel() { 
        if(toby.perdio()) {
            escenario.morirToby()
        }
    }

    method winLevel() {
        if(toby.gano(150)) {
            escenario.nivelPasado()
        }
    }

    override method finalizarNivel(){
        game.whenCollideDo(toby, {algo => self.loseLevel() })
    }
}

class Nivel2 inherits Nivel{}

class Win inherits Nivel{}