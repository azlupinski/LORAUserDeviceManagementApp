package com.adamLupinski.springsecurity.loRa.dao;

import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;

import java.util.List;

public interface DeviceDao {

    public void saveDevice(Device device);

    List<Device> getDevices(int adminAccountId);

    public Device getDevice(Long id);

    public void deleteDevice(Long id);

    void update(Device device);
}
