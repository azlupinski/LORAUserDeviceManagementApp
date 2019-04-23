package com.adamLupinski.springsecurity.loRa.service;

import com.adamLupinski.springsecurity.loRa.entity.Account;
import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;

import java.util.List;

public interface DeviceService {

    void addDevice(Device device, Account account);

    List<Device> getDeviceList(int adminAccountId);

    Device getDevice(Long id);

    void deleteDevice(Long id);

    void sendMessage( String  iotHubConnectionString, String deviceId, String methodName, String payload);


}
