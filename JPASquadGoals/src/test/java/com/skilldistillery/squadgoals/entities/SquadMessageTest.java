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

class SquadMessageTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private SquadMessage squadMessage;

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
		squadMessage = em.find(SquadMessage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		squadMessage = null;
	}

	@Test
	void test_squad_message_mappings() {
		assertNotNull(squadMessage);
		assertEquals(squadMessage.getContent(), "u up?");
	}

}
