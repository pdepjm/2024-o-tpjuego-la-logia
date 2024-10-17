import personaje.*

object puntos {

  method position() = game.at(42,23)

  method text() = "Puntos: "
}

object vida {

  method position() = game.at(42,24)

  method text() = toby.valorVida()

}
