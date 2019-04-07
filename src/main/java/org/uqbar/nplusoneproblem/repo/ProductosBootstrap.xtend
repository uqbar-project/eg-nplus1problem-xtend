package org.uqbar.nplusoneproblem.repo

import java.time.LocalDate
import java.util.List
import org.uqbar.nplusoneproblem.domain.Fabricante
import org.uqbar.nplusoneproblem.domain.Producto

class ProductosBootstrap {
	
	def void crearDatosDePrueba() {
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

	def Fabricante crearFabricante(int i) {
		RepoFabricantes.instance.add(new Fabricante => [
			nombre = "Fabricante " + i
		])
	}
	
	def crearProducto(int i, List<Fabricante> fabricantes) {
		val producto = new Producto => [
			nombre = "Producto " + i
			fechaIngreso = LocalDate.now.minusWeeks(i)
			proveedores = if (i % 2 == 0) fabricantes.subList(0, 10).toSet else fabricantes.subList(11, 15).toSet
		]
		RepoProductos.instance.add(producto)
	}
	
}
