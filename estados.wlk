import personaje.*

object barraPuntos {

  var property position = game.at(37,23)

  method image() = "power-bar-" + toby.barraPuntos() + ".png"

}
object barraVida {
	var property position = game.at(37,24)

	method image() = "health-bar-" + toby.barraVida() + ".png"
}