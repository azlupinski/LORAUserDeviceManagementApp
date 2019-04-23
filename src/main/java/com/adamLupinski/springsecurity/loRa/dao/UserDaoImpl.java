package com.adamLupinski.springsecurity.loRa.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.adamLupinski.springsecurity.loRa.entity.User;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class UserDaoImpl implements UserDao {

	// need to inject the session factory
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<User> getUsers(int adminAccountId) {
		Session currentSession = sessionFactory.getCurrentSession();


		@SuppressWarnings("unchecked")
		Query<User> theQuery = currentSession.createQuery("from User where account.id =:adminId ");
		theQuery.setParameter("adminId", adminAccountId);

		List<User> users = theQuery.getResultList();

		return users;
	}

	@Override
	public User findByUserName(String theUserName) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using username
		Query<User> theQuery = currentSession.createQuery("from User where userName=:uName", User.class);
		theQuery.setParameter("uName", theUserName);
		User theUser = null;
		try {
			theUser = theQuery.getSingleResult();
		} catch (Exception e) {
			theUser = null;
		}

		return theUser;
	}

	@Override
	public void save(User theUser) {
		// get current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// create the user ... finally LOL
		currentSession.save(theUser);
	}

	@Override
	public void update(User user) {

		Session currentSession = sessionFactory.getCurrentSession();



		currentSession.update(user);
		System.out.println("update compleete");

	}

	@Override
	public void delete(Long id) {
		Session currentSession = sessionFactory.getCurrentSession();

		Query query = currentSession.createQuery("delete from User where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();

	}

	@Override
	public User findUserById(Long id) {
		// get the current hibernate session
		Session currentSession = sessionFactory.getCurrentSession();

		// now retrieve/read from database using username
		Query<User> theQuery = currentSession.createQuery("from User where id=:id", User.class);
		theQuery.setParameter("id", id);
		User theUser = null;
		try {
			theUser = theQuery.getSingleResult();
		} catch (Exception e) {
			theUser = null;
			e.printStackTrace();
		}
		theUser.getDevices().size();

		return theUser;
	}


}
