package org.uqbar.nplusoneproblem.repo

import javax.persistence.criteria.JoinType
import org.uqbar.nplusoneproblem.domain.Producto

class RepoProductos extends AbstractRepo<Producto> {

	static RepoProductos instance = null

	private new() {}

	static def getInstance() {
		if (instance === null) {
			instance = new RepoProductos
		}
		instance
	}

	def getProductosRecientes() {
		val criteria = entityManager.criteriaBuilder
		val preparedQuery = criteria.createQuery(typeof(Producto))
		val fromProducto = preparedQuery.from(Producto)
		// evita n + 1 queries
		fromProducto.fetch("proveedores")
		preparedQuery.select(fromProducto)
		preparedQuery.orderBy(criteria.asc(fromProducto.get("fechaIngreso")))
		val query = entityManager.createQuery(preparedQuery)
		query.maxResults = 5
		query.resultList
	}
	
}
