package com.skilldistillery.squadgoals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class TagTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Tag tag;

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
		tag = em.find(Tag.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		tag = null;
	}

	@Test
	void test_tag_not_null() {
		assertNotNull(tag);
	}
	
//	+----+---------+-------------+
//	| id | name    | description |
//	+----+---------+-------------+
//	|  1 | fitness | NULL        |
//	+----+---------+-------------+
	
	@Test
	void test_tag_mappings() {
		assertEquals(tag.getName(), "fitness");
		assertNull(tag.getDescription());
	}
	
	@Test
	void test_tag_relationship_mapping() {
		assertTrue(tag.getGoals().size() == 0);
		assertTrue(tag.getSquads().size() == 1);
		assertTrue(tag.getUsers().size() == 1);
	}

}
