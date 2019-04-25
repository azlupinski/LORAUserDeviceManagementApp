package com.adamLupinski.springsecurity.loRa.controller;

import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;
import com.adamLupinski.springsecurity.loRa.service.DeviceService;
import com.adamLupinski.springsecurity.loRa.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HomeController {

	@Autowired
	UserService userService;

	@Autowired
	DeviceService deviceService;

	@GetMapping("/")
	public String showWelcomePage(Model theModel, HttpSession httpSession) {
	return "index";
	}

	@GetMapping("/myAccount")
	public String showHome(Model theModel, HttpSession httpSession){


		User userAdmin = (User)httpSession.getAttribute("user");

		List<Device> theDevices = deviceService.getDeviceList(userAdmin.getAccount().getId());

		theModel.addAttribute("devices",theDevices);

		return "home";
	}



	@GetMapping("/users")
	public String showUsers(Model theModel, HttpSession httpSession){

		User userAdmin = (User)httpSession.getAttribute("user");

		List<User> theUsers = userService.getUserList(userAdmin.getAccount().getId());


		theModel.addAttribute("users",theUsers);



		return "users/user-table";
	}



	@GetMapping("/devices")
	public String showDevices(Model theModel, HttpSession httpSession){

		User userAdmin = (User)httpSession.getAttribute("user");

		List<Device> theDevices = deviceService.getDeviceList(userAdmin.getAccount().getId());


		theModel.addAttribute("devices",theDevices);



		return "devices/device-table";
	}

}










