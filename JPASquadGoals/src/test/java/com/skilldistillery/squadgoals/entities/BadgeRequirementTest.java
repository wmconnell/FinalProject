package com.skilldistillery.squadgoals.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BadgeRequirementTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private BadgeRequirement requirement;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPASquadGoals");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		requirement = em.find(BadgeRequirement.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		requirement = null;
	}

	@Test
	void test_requirement_not_null() {
		assertNotNull(requirement);
	}
	
	@Test
	void test_requirement_relationship_mappings() {
		assertTrue(requirement.getBadge().getId() == 1);
	}

}
