package org.uqbar.nplusoneproblem.endpoint

import java.time.LocalDate
import java.util.List
import org.uqbar.nplusoneproblem.domain.Fabricante
import org.uqbar.nplusoneproblem.domain.Producto
import org.uqbar.nplusoneproblem.repo.RepoFabricantes
import org.uqbar.nplusoneproblem.repo.RepoProductos
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils

@Controller
class ProductosController {

	extension JSONUtils = new JSONUtils

	@Get("/productosRecientes")
	def Result buscarPeliculas() {
		ok(RepoProductos.instance.productos.toJson)
	}

	def static void main(String[] args) {
		crearDatosDePrueba
		XTRest.start(8080, ProductosController)
	}
	
	def static void crearDatosDePrueba() {
		val repoFabricantes = RepoFabricantes.instance
		if (repoFabricantes.fabricantesSize > 0) return;
		
		val fabricantes = newArrayList;
		(1..25).forEach [ i |
			fabricantes.add(crearFabricante(i))
		]
		
		(1..50).forEach [ i |
			crearProducto(i, fabricantes)			
		]
	}

	def static Fabricante crearFabricante(int i) {
		RepoFabricantes.instance.add(new Fabricante => [
			nombre = "Fabricante " + i
		])
	}
	
	def static crearProducto(int i, List<Fabricante> fabricantes) {
		val producto = new Producto => [
			nombre = "Producto " + i
			fechaIngreso = LocalDate.now.minusWeeks(i)
			proveedores = if (i % 2 == 0) fabricantes.subList(0, 10).toSet else fabricantes.subList(11, 15).toSet
		]
		RepoProductos.instance.add(producto)
	}
}
