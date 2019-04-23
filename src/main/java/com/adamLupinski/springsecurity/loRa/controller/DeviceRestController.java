package com.adamLupinski.springsecurity.loRa.controller;

import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;
import com.adamLupinski.springsecurity.loRa.service.DeviceService;
import com.adamLupinski.springsecurity.loRa.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/devices")
public class DeviceRestController {

    @Autowired
    private DeviceService deviceService;



    @RequestMapping(path = "/takeAll/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<String> getAllUsersForDevice(@PathVariable Long id){
        Device device = deviceService.getDevice(id);
        return device.getUsers().stream().map(User::getUserName).collect(Collectors.toList());
    }



}
