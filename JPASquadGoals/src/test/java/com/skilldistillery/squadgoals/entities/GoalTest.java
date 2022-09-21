package com.skilldistillery.squadgoals.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class GoalTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Goal goal;

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
		goal = em.find(Goal.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		goal = null;
	}

	@Test
	void test_goal_not_null() {
		assertNotNull(goal);
	}
	
//	+----+-------------+-----------------------------------+---------------------+---------------------+----------------+---------------------+---------------------+-----------+------------+------------+-----------+
//	| id | title       | description                       | created_date        | updated_date        | completed_date | start_date          | end_date            | completed | visibility | attendance | recurring |
//	+----+-------------+-----------------------------------+---------------------+---------------------+----------------+---------------------+---------------------+-----------+------------+------------+-----------+
//	|  1 | Pizza party | Some wholesome, after-school fun! | 2022-09-20 19:54:01 | 2022-09-20 19:54:01 | NULL           | 2022-09-23 19:30:00 | 2022-09-23 21:00:00 |         0 | public     | public     | NULL      |
//	+----+-------------+-----------------------------------+---------------------+---------------------+----------------+---------------------+---------------------+-----------+------------+------------+-----------+
	
	@Test
	void test_goal_mappings() {
		assertEquals(goal.getTitle(), "Pizza party");
		assertEquals(goal.getDescription(), "Some wholesome, after-school fun!");
		assertFalse(goal.getCompleted());
		assertEquals(goal.getVisibility(), "public");
		assertEquals(goal.getAttendance(), "public");
	}
}
