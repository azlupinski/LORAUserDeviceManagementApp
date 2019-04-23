package com.adamLupinski.springsecurity.loRa.dao;

import com.adamLupinski.springsecurity.loRa.entity.Role;

public interface RoleDao {

	public Role findRoleByName(String theRoleName);
	
}
