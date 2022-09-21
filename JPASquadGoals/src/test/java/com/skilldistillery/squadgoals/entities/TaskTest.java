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

class TaskTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Task task;

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
		task = em.find(Task.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		task = null;
	}

	@Test
	void test_task_not_null() {
		assertNotNull(task);
	}
	
//	+----+---------------+-----------------------+--------------+--------------+----------------+------------+----------+-----------+---------+
//	| id | title         | description           | created_date | updated_date | completed_date | start_date | end_date | completed | goal_id |
//	+----+---------------+-----------------------+--------------+--------------+----------------+------------+----------+-----------+---------+
//	|  1 | Buy the pizza | Chicago style, please | NULL         | NULL         | NULL           | NULL       | NULL     |         0 |       1 |
//	+----+---------------+-----------------------+--------------+--------------+----------------+------------+----------+-----------+---------+
	
	@Test
	void test_task_mappings() {
		assertEquals(task.getTitle(), "Buy the pizza");
		assertEquals(task.getDescription(), "Chicago style, please");
		assertFalse(task.getCompleted());
	}

}
