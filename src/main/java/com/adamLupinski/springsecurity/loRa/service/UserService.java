package com.adamLupinski.springsecurity.loRa.service;

import com.adamLupinski.springsecurity.loRa.entity.Account;
import com.adamLupinski.springsecurity.loRa.entity.User;
import com.adamLupinski.springsecurity.loRa.validationObjects.CrmUser;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {

    User findByUserName(String userName);

    void save(CrmUser crmUser);

    void saveRegularUser(CrmUser crmUser, Account account);


    List<User> getUserList(int adminAccountId);

    User findUserById(Long id);

    void updateUser(User user);

    void deleteUser(Long id);

    void addDeviceToUser(Long deviceId, Long userId);

}
