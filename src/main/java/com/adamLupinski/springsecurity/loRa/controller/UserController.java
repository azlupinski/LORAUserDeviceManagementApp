package com.adamLupinski.springsecurity.loRa.controller;

import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;
import com.adamLupinski.springsecurity.loRa.service.AccountService;
import com.adamLupinski.springsecurity.loRa.service.DeviceService;
import com.adamLupinski.springsecurity.loRa.service.UserService;
import com.adamLupinski.springsecurity.loRa.validationObjects.CrmUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;

@Controller
@RequestMapping("/users")
public class UserController {

	@GetMapping("/showMyLoginPage")
	public String showMyLoginPage() {
		
		// return "plain-login";

		return "users/fancy-login";
		
	}
	
	// add request mapping for /access-denied
	
	@GetMapping("/access-denied")
	public String showAccessDenied() {
		
		return "access-denied";
		
	}





	@Autowired
	private UserService userService;

	@Autowired
	AccountService accountService;

	@Autowired
	private DeviceService deviceService;


	private Logger logger = Logger.getLogger(getClass().getName());

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {

		StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);

		dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
	}

	@GetMapping("/showRegistrationForm")
	public String showMyLoginPage(Model theModel) {

		theModel.addAttribute("crmUser", new CrmUser());

		return "users/registration-form";
	}

	@GetMapping("/regularUserRegistration")
	public String regularUserRegistration(Model theModel){



//		user theUser = new user();


		theModel.addAttribute("crmUser", new CrmUser());


		return "users/registration-form-for-regular-user";
	}

	@PostMapping("/processRegularUserRegistrationForm")
	public String processRegularUserRegistrationForm(@Valid @ModelAttribute("crmUser") CrmUser theCrmUser,
													 BindingResult theBindingResult,
													 Model theModel, HttpSession httpSession){

		User userAdmin = (User)httpSession.getAttribute("user");

		String crmUserName =theCrmUser.getUserName();

		logger.info("Processing registration form for: " + crmUserName);

		// form validation
		if (theBindingResult.hasErrors()){
			return "users/registration-form-for-regular-user";
		}

		// check the database if user already exists
		User existingUser = userService.findByUserName(crmUserName);
		if (existingUser != null) {
			theModel.addAttribute("crmUser", new CrmUser());
			theModel.addAttribute("registrationError", "user name already exists.");

			logger.warning("user name already exists.");
			return "users/registration-form-for-regular-user";
		}

		userService.saveRegularUser(theCrmUser, userAdmin.getAccount());

		return "users/registration-confirmation";
	}


	@PostMapping("/processRegistrationForm")
	public String processRegistrationForm(
			@Valid @ModelAttribute("crmUser") CrmUser theCrmUser,
			BindingResult theBindingResult,
			Model theModel) {

		String userName = theCrmUser.getUserName();
		logger.info("Processing registration form for: " + userName);

		// form validation
		if (theBindingResult.hasErrors()){
			return "users/registration-form";
		}

		// check the database if user already exists
		User existing = userService.findByUserName(userName);
		if (existing != null){
			theModel.addAttribute("crmUser", new CrmUser());
			theModel.addAttribute("registrationError", "user name already exists.");

			logger.warning("user name already exists.");
			return "users/registration-form";
		}
		// create user account
		userService.save(theCrmUser);

		logger.info("Successfully created user: " + userName);

		return "users/registration-confirmation";
	}



	@GetMapping("/showFormForUpdate")
	public String showFormUpdate(@RequestParam("userId") Long theId, Model theModel){

		//get customer from database
		User theUser = userService.findUserById(theId);

		// set customer as a model attribute to pre populate the form
		theModel.addAttribute("user", theUser);



		//send over to form

		return "users/update-registration-form-for-regular-user";


	}

	@PostMapping("/processUpdateRegularUserForm")
	public String processUpdateFormRegularUser(@ModelAttribute("user") User user,
											   Model theModel, HttpSession httpSession){

		System.out.println(user);

		if(user.getPassword() != null && !user.getPassword().equals(user.getMatchingPassword())){
			return "users/update-registration-form-for-regular-user";
		}



		userService.updateUser(user);

		return "redirect:/users";
	}

	@GetMapping("/deleteUser")
	public String deleteUser(@RequestParam("userId") Long theId){

		userService.deleteUser(theId);

		return "redirect:/users";
	}

	@GetMapping("/showUser")
	public String showUserPage(@RequestParam("userId") Long id, Model model){

		User user = userService.findUserById(id);
		List<Device> availableDevices = new LinkedList<>();

		availableDevices =  deviceService.getDeviceList(user.getAccount().getId());

		model.addAttribute("user", user);
		model.addAttribute("availableDevices", availableDevices);
		System.out.println(availableDevices);

		return "users/user-page";
	}

	@GetMapping("/addDeviceToUser")
	public String addDeviceToUser(@RequestParam("userId") Long userId,@RequestParam("deviceId") Long deviceId){
		userService.addDeviceToUser(deviceId, userId);

		return "redirect:/users";
	}



}









