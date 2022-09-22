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

class ImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Image image;

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
		image = em.find(Image.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		image = null;
	}

	@Test
	void test_image_not_null() {
		assertNotNull(image);
	}
	
//	+----+-------------------------------------------------------------------+---------+-----------+
//	| id | url                                                               | goal_id | review_id |
//	+----+-------------------------------------------------------------------+---------+-----------+
//	|  1 | https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg |    NULL |      NULL |
//	+----+-------------------------------------------------------------------+---------+-----------+
	
	@Test
	void test_image_mappings() {
		assertEquals(image.getUrl(), "https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg");
	}
	
	@Test
	void test_image_relationship_mappings() {
		assertTrue(image.getGoals().size() == 0);
		assertTrue(image.getReviews().size() == 0);
		assertTrue(image.getSquad() == null);
		assertTrue(image.getUser().getId() == 1);
	}

}
