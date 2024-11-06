import personaje.*

object barraPuntos {
  var property position = game.at(37,23)

  method image() = "power-bar-" + toby.monedasRestantes() + ".png"

}
object barraVida {
	var property position = game.at(37,24)

	method image() = toby.barraVida()
}