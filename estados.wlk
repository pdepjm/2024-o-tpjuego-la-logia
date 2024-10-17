import personaje.*

object puntos {

  method position() = game.at(42,23)

  method text() = "Puntos: "
}

object vida {

  method position() = game.at(42,24)

  method text() = toby.valorVida().toString()
}

object vida2 {
  method position() = game.at(41,24)
  method text() = "Vida: "
}
