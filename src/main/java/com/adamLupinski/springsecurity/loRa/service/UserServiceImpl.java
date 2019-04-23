package com.adamLupinski.springsecurity.loRa.service;

import com.adamLupinski.springsecurity.loRa.dao.RoleDao;
import com.adamLupinski.springsecurity.loRa.dao.UserDao;
import com.adamLupinski.springsecurity.loRa.entity.Account;
import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.Role;
import com.adamLupinski.springsecurity.loRa.entity.User;
import com.adamLupinski.springsecurity.loRa.validationObjects.CrmUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

	// need to inject user dao
	@Autowired
	private UserDao userDao;

	@Autowired
	private RoleDao roleDao;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Autowired
	private DeviceService deviceService;




	@Override
	public User findByUserName(String userName) {
		// check the database if the user already exists
		return userDao.findByUserName(userName);
	}

	@Override
	public User findUserById(Long id) {

		return userDao.findUserById(id);
	}

	@Override
	public void updateUser(User user) {


		System.out.println(user);
		User originalUser = findUserById(user.getId());
		originalUser.setFirstName(user.getFirstName());
		originalUser.setLastName(user.getLastName());
		if (!user.getPassword().isEmpty()) {
			originalUser.setPassword(passwordEncoder.encode(user.getPassword()));
		}
		originalUser.setEmail(user.getEmail());



		userDao.update(originalUser);
		System.out.println("passed userService");
	}

	@Override
	public void save(CrmUser crmUser) {


	    User user =createUserFromCrm(crmUser);
		Account account = new Account();
		user.setAccount(account);
		user.setDevices(Collections.emptyList());

		// give user default role of "employee"
		user.setRoles(Arrays.asList(roleDao.findRoleByName("ROLE_ADMIN")));

		 // save user in the database
		userDao.save(user);
	}

	@Override
	public void saveRegularUser(CrmUser crmUser, Account account) {


	    User user = createUserFromCrm(crmUser);
		// give user default role of "employee"
		user.setRoles(Arrays.asList(roleDao.findRoleByName("ROLE_USER")));
		user.setDevices(Collections.emptyList());
		user.setAccount(account);


		// save user in the database
		userDao.save(user);


	}

	@Override
	public List<User> getUserList(int adminAccountId) {


		return userDao.getUsers(adminAccountId);
	}


	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		User user = userDao.findByUserName(userName);
		if (user == null) {
			throw new UsernameNotFoundException("Invalid username or password.");
		}
		return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getPassword(),
				mapRolesToAuthorities(user.getRoles()));
	}

	private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
		return roles.stream().map(role -> new SimpleGrantedAuthority(role.getName())).collect(Collectors.toList());
	}

	private User createUserFromCrm(@NotNull CrmUser crmUser){

        User user = new User();
        user.setUserName(crmUser.getUserName());
        user.setPassword(passwordEncoder.encode(crmUser.getPassword()));
        user.setFirstName(crmUser.getFirstName());
        user.setLastName(crmUser.getLastName());
        user.setEmail(crmUser.getEmail());
	    return user;
    }

	@Override
	public void deleteUser(Long id) {


		userDao.delete(id);
	}

	@Override
	public void addDeviceToUser(Long deviceId, Long userId) {
		User user = userDao.findUserById(userId);
		Device device = deviceService.getDevice(deviceId);
		List<Device> devices = user.getDevices();
		devices.add(device);
		user.setDevices(devices);
		userDao.update(user);
	}

}
