class Personaje{
    const property fuerza
    const inteligencia
    var property rol

    method potencialOfensivo() = fuerza * 10 + rol.extra()
    method esInteligente()  
    method esGroso() =  self.esInteligente() or rol.esGroso(self)
}
class Humano inherits Personaje{
    override method esInteligente() = inteligencia > 50
    

}
class Orco inherits Personaje{
    override method potencialOfensivo() = super() * 1.1
    override method esInteligente() = false
   
}
object guerrero {
    method extra() = 100 
    method esGroso(unPersonaje) = unPersonaje.fuerza()>50

}
class Cazador {
    const mascota

    method extra() = mascota.potencialOfensivo()
    method esGroso(unPersonaje) = mascota.esLongeva()

}
object brujo {
    method extra()  = 0
    method esGroso(unPersonaje) = true  
}
class Mascota{
    const fuerza
    var edad
    const garras 

    method potencialOfensivo() = if(garras) fuerza * 2 else fuerza
    method cumplirAnios(){edad +=1}
    method esLongeva() = edad > 10
}
object noTieneMascota {
    method potencialOfensivo() = 0
    method esLongeva() = false
}
class Localidad {
  var ejercito
  method poderDefensivo() = ejercito.poderOfensivo()  
  method serOcupada(unEjercito)
}
class Aldea inherits Localidad {
  const maxTropa 
  method initialize(){
    if(maxTropa < 10 ){
        self.error('la poblacion debe ser mayor a 10')
    }
  }
  override method serOcupada(unEjercito) {
    if (maxTropa < unEjercito.tamanio()){
        ejercito = new Ejercito(tropa = unEjercito.losMasPoderosos())
        unEjercito.quitarLosMasFuertes()}
    else {ejercito = unEjercito}    
     }
}
class Ciudad inherits Localidad{
    override method poderDefensivo() = super() + 300
    override method serOcupada(unEjercito) {ejercito = unEjercito}
}
class Ejercito{
    const tropa = []
    method tamanio() = tropa.size()
    method poderOfensivo() = tropa.sum({p =>p.potencialOfensivo()})
    method invadir(unaLocalidad){
        if (self.puedeInvadir(unaLocalidad)){unaLocalidad.serOcupada(self)}
    }
    method puedeInvadir(unaLocalidad) = self.poderOfensivo() > unaLocalidad.poderDefensivo()
    method losMasPoderosos() = self.ordenadosMasPoderosos().take(10)
    method ordenadosMasPoderosos() = tropa.sortBy({t1,t2=> t1.potencialOfensivo() > t2.potencialOfensivo()})
    method quitarLosMasFuertes(){tropa.removeAll(self.losMasPoderosos())}
}