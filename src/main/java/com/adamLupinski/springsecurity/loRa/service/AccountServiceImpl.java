package com.adamLupinski.springsecurity.loRa.service;

import com.adamLupinski.springsecurity.loRa.dao.AccountDao;
import com.adamLupinski.springsecurity.loRa.entity.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AccountServiceImpl implements AccountService{


    @Autowired
    AccountDao accountDao;


    @Override
    @Transactional
    public Account getAccount(int id) {
        return accountDao.getAccount(id);
    }
}
