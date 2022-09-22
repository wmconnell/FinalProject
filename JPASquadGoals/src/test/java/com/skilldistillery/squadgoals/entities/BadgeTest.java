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

class BadgeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Badge badge;

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
		badge = em.find(Badge.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		badge = null;
	}

	@Test
	void test_badge_not_null() {
		assertNotNull(badge);
	}
	
//	+----+-------------+----------------------------------------------------------------+------------------------+
//	| id | name        | description                                                    | conditions             |
//	+----+-------------+----------------------------------------------------------------+------------------------+
//	|  1 | Super Squad | Any squad that reaches 100 pts receives the Super Squad badge! | {point_threshold: 100} |
//	+----+-------------+----------------------------------------------------------------+------------------------+
	
	@Test
	void test_badge_mappings() {
		assertEquals(badge.getName(), "Super Squad");
		assertEquals(badge.getDescription(), "Any squad that reaches 100 pts receives the Super Squad badge!");
	}

}
