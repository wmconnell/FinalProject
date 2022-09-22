package com.skilldistillery.squadgoals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_user_not_null() {
		assertNotNull(user);
	}
	
	@Test
	void test_user_mappings() {
		assertEquals(user.getUsername(), "originaltom");
		assertEquals(user.getPassword(), "myspace");
		assertEquals(user.getEmail(), "tom@myspace.com");
		assertEquals(user.getFirstName(), "Tom");
		assertEquals(user.getLastName(), "MySpace");
		assertEquals(user.getRole(), "admin");
		assertTrue(user.getActive());
	}
	
	@Test
	void test_user_relational_mappings() {
		assertTrue(user.getSquads().size() == 1);
	}

}
