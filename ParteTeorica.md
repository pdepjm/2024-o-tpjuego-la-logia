Parte Teorica de Wollok Road

En la entrega 2, nosotros aplicamos 2 conceptos del paradigma de objetos. El polimorfismo y el concepto de las clases.  
Por un lado, el polimorfismo lo aplicamos en las colisiones, ya que no afecta de igual forma al personaje que colisione con un colectivo a que colisione con un auto, pierde mas o menos vida. 
En las proximas entregas, tambien se vera aplicado este concepto en otros sucesos. Por ejemplo, la vida del personaje se podra ver modificada si es que "colecta" cierto objeto. El polimorfismo tambien lo utilizamos para evitar la repeticion de logica y codigo y aprovechar la herramienta de wollok.

Por otro lado, usamos el concepto de clases para no generar un gran numero de objetos para el mismo obstaculo, como por ejemplo la clase auto, colectivo etc. Ademas, estos obstaculos comparten todos el mismo comportamiento, entonces no seria util ni buena practica tener muchos objetos que hagan lo mismo. 

En el siguiente diagrama, se puede observar como es que se aplica el polimorfismo. Los obstaculos son polimorficos para toby, nuestro personaje, ya que segun cual es, reacciona distinto. Por ultimo, en el diagrama se pueden ver las distintas clases(car(auto), colectivo, chopperita, fiesta tuniado), sus atributos y los metodos. Ademas, tambien esta el objeto "toby" que interactua con todas las clases y tiene como atributos su posicion y los metodos esenciales: perdio() y modificarVida().



![image](https://github.com/user-attachments/assets/1ee3aec5-af5c-4b34-98db-aa9dffe15062)

