package com.adamLupinski.springsecurity.loRa.dao;

import com.adamLupinski.springsecurity.loRa.entity.User;

import java.util.List;

public interface UserDao {

    public  List<User> getUsers(int adminAccountId);

    User findByUserName(String userName);

    User findUserById(Long id);
    
    void save(User user);

    void update(User user);

    void delete(Long id);

}
