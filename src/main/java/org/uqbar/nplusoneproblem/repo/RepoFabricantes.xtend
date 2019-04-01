package org.uqbar.nplusoneproblem.repo

import org.uqbar.nplusoneproblem.domain.Fabricante

class RepoFabricantes extends AbstractRepo<Fabricante> {
	
	static RepoFabricantes instance = null

	private new() {}

	static def getInstance() {
		if (instance === null) {
			instance = new RepoFabricantes
		}
		instance
	}

	def getFabricantesSize() {
		val criteria = entityManager.criteriaBuilder
		val query = criteria.createQuery(Long)
		query.select(criteria.count(query.from(Fabricante)))
		entityManager.createQuery(query).singleResult
	}
	
}