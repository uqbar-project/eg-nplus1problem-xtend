package org.uqbar.nplusoneproblem.endpoint

import org.uqbar.nplusoneproblem.repo.ProductosBootstrap
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
		ok(RepoProductos.instance.productosRecientes.toJson)
	}

	def static void main(String[] args) {
		new ProductosBootstrap().crearDatosDePrueba
		XTRest.start(8080, ProductosController)
	}
	
}
