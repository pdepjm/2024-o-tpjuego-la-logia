import personaje.*

object puntos {

  method position() = game.at(42,23)
  
  method text() = "Puntos: " + toby.puntos()
}

object vida {

  method position() = game.at(41,24)

  method text() = "Vida: " + toby.valorVida().toString()
}