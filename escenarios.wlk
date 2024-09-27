import personaje.*
import elementos.*
import wollok.game.*

object escenario {
var property nivel = null

    method iniciarNivel(nuevoNivel) {
        nuevoNivel.configuracionFondo()
        nuevoNivel.configuracionTeclado()
        self.nivel(nuevoNivel)
    }
}
 
class Background {
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
    method configuracionTeclado() {
        // Aquí puedes agregar configuraciones de teclado específicas para Nivel1
    }

    method configuracionFondo() {
        game.addVisual(fondoNivel1)
    }

    method removerFondo() {
        game.removeVisual(fondoNivel1) // Remueve el fondo del nivel actual si cambia de nivel
    }
}