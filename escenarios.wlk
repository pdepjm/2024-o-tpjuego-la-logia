import personaje.*
import elementos.*
import wollok.game.*

object escenario {
var property nivel = null

    method iniciarNivel(nuevoNivel) {
        nuevoNivel.configuracionFondo()
        nuevoNivel.configuracionTeclado()
        nuevoNivel.configuracionInicial()
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
}


class Nivel1 {
    method configuracionInicial(){		
		game.addVisualCharacter(main)
	}
	
	method configuracionTeclado(){
		keyboard.w().onPressDo {main.moverArriba()}
		keyboard.s().onPressDo {main.moverAbajo()}
		keyboard.d().onPressDo {main.moverDerecha()}
		keyboard.a().onPressDo {main.moverIzquierda()}
	}

    method configuracionFondo() {
        game.boardGround(fondoNivel1)
    }

    method removerFondo() {
        game.removeVisual(fondoNivel1) // Remueve el fondo del nivel actual si cambia de nivel
    }
}