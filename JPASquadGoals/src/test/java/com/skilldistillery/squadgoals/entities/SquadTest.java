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
		squad = em.find(Squad.class, 1);
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
	
//	+----+---------+-------------------------------------+--------+-----------+--------+------------------+
//	| id | name    | bio                                 | active | leader_id | points | profile_image_id |
//	+----+---------+-------------------------------------+--------+-----------+--------+------------------+
//	|  1 | The OGs | We're just two wild and crazy guys! |      1 |         1 |    150 |                3 |
//	+----+---------+-------------------------------------+--------+-----------+--------+------------------+
	
	@Test
	void test_squad_mappings() {
		assertEquals(squad.getName(), "The OGs");
		assertEquals(squad.getBio(), "We're just two wild and crazy guys!");
		assertTrue(squad.getActive());
	}
	
	@Test
	void test_squad_relationship_mappings() {
		assertTrue(squad.getGoals().size() == 1);
		assertTrue(squad.getTasks().size() == 2);
		assertTrue(squad.getTags().size() == 3);
		assertTrue(squad.getBadges().size() == 1);
		assertTrue(squad.getSquadMessages().size() == 2);
		assertEquals(squad.getProfilePic().getUrl(), "https://static.wikia.nocookie.net/snl/images/6/66/Wild_and_crazy_guys.jpg/revision/latest?cb=20140804162910");
	}

}
