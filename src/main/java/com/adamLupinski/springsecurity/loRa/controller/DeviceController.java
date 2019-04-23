package com.adamLupinski.springsecurity.loRa.controller;

import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;
import com.adamLupinski.springsecurity.loRa.service.DeviceService;
import com.adamLupinski.springsecurity.loRa.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/devices")
public class DeviceController {

    @Autowired
    DeviceService deviceService;

    @Autowired
    UserService userService;

    @GetMapping("/addDeviceForm")
    public String addDeviceForm(Model theModel){


        theModel.addAttribute("device", new Device());


        return "devices/device-registration-form";
    }


    @PostMapping("/processDeviceForm")
    public String processDeviceForm(@ModelAttribute("device") Device theDevice,
                                    Model theModel, HttpSession httpSession){

        User userAdmin = (User)httpSession.getAttribute("user");

        deviceService.addDevice(theDevice, userAdmin.getAccount() );

        return "devices/device-registration-confirmation";
    }


    @GetMapping("/deleteDevice")
    public String deleteDevice(@RequestParam("deviceId") Long theId){


        deviceService.deleteDevice(theId);

        return "redirect:/devices";
    }

    @GetMapping("/sendMsgToDevice")
    public String sendMessageToDevice(@RequestParam("deviceId") Long theId, @RequestParam("textMessage") String message){


        Device device =  deviceService.getDevice(theId);

        deviceService.sendMessage(device.getUniqueId(), device.getName(), "setSomeMessage", message);


        return "redirect:/myAccount";
    }

    @GetMapping("/showDevice")
    public String showDevicePage(@RequestParam("deviceId") Long id, Model model){

        Device device = deviceService.getDevice(id);


         List<User> availableUsers =  userService.getUserList(device.getAccount().getId());

            availableUsers.removeAll(device.getUsers());
        model.addAttribute("device", device);
        model.addAttribute("availableUsers", availableUsers);
        System.out.println(availableUsers);
        System.out.println("device users:" + device.getUsers());

        return "devices/device-page";
    }

    @GetMapping("/addUserToDevice")
    public String addUserToDevice(@RequestParam("userId") Long userId,@RequestParam("deviceId") Long deviceId){

        userService.addDeviceToUser(deviceId, userId);


        return "redirect:/devices";
    }
}
