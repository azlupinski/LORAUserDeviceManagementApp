package com.adamLupinski.springsecurity.loRa.dao;

import com.adamLupinski.springsecurity.loRa.entity.Account;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.PersistenceUnit;

@Repository
@Transactional
public class AccountDaoImpl implements AccountDao {


    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Account getAccount(int id) {

        Session currentSession = sessionFactory.getCurrentSession();

        Account account = currentSession.get(Account.class, id);
        return account;
    }
}
