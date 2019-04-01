package org.uqbar.nplusoneproblem.repo

import javax.persistence.EntityManager
import javax.persistence.Persistence

abstract class AbstractRepo<T> {
	
	static final protected EntityManager entityManager = Persistence.createEntityManagerFactory("Products").createEntityManager

	
	def add(T t) {
		entityManager => [
			transaction.begin
			persist(t)
			transaction.commit
		]
		t
	}
	
}