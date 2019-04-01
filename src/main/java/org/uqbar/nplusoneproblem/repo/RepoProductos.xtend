package org.uqbar.nplusoneproblem.repo

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

	def getProductos() {
		val criteria = entityManager.criteriaBuilder
		val preparedQuery = criteria.createQuery(typeof(Producto))
		val from = preparedQuery.from(Producto)
		// evita n + 1 queries
		// from.join("proveedores")
		preparedQuery.select(from)
		preparedQuery.orderBy(criteria.asc(from.get("fechaIngreso")))
		val query = entityManager.createQuery(preparedQuery)
		query.maxResults = 5
		query.resultList
	}
	
}
