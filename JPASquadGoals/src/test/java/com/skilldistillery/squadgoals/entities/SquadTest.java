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

class SquadTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Squad squad;

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
		squad = em.find(Squad.class, Long.valueOf(1));
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		squad = null;
	}

	@Test
	void test_squad_not_null() {
		assertNotNull(squad);
	}
	
	@Test
	void test_squad_mappings() {
		assertEquals(squad.getsquadname(), "originaltom");
		assertEquals(squad.getPassword(), "myspace");
		assertEquals(squad.getEmail(), "tom@myspace.com");
		assertEquals(squad.getFirstName(), "Tom");
		assertEquals(squad.getLastName(), "MySpace");
		assertEquals(squad.getRole(), "admin");
		assertTrue(squad.getActive());
	}

}
