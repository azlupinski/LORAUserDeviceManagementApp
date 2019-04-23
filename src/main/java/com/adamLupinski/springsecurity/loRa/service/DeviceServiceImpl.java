package com.adamLupinski.springsecurity.loRa.service;

import com.adamLupinski.springsecurity.loRa.dao.DeviceDao;
import com.adamLupinski.springsecurity.loRa.dao.UserDao;
import com.adamLupinski.springsecurity.loRa.entity.Account;
import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;
import com.microsoft.azure.sdk.iot.service.devicetwin.DeviceMethod;
import com.microsoft.azure.sdk.iot.service.devicetwin.MethodResult;
import com.microsoft.azure.sdk.iot.service.exceptions.IotHubException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
public class DeviceServiceImpl implements DeviceService {
    @Autowired
    private DeviceDao deviceDao;

    @Autowired
    private UserService userService;


    @Override
    public void addDevice(Device device, Account account) {
        device.setAccount(account);
        deviceDao.saveDevice(device);
    }

    @Override
    public List<Device> getDeviceList(int adminAccountId) {
      return deviceDao.getDevices(adminAccountId);
    }

    @Override
    public Device getDevice(Long id) {
        return deviceDao.getDevice(id);
    }

    @Override
    public void deleteDevice(Long id) {


        deviceDao.deleteDevice(id);
    }

    @Override
    public void sendMessage(String iotHubConnectionString, String deviceId, String methodName, String payload) {
        try {


            final Long responseTimeout = TimeUnit.SECONDS.toSeconds(30);
            final Long connectTimeout = TimeUnit.SECONDS.toSeconds(5);

            System.out.println("Calling direct method...");

            // Create a DeviceMethod instance to call a direct method.
            DeviceMethod methodClient = DeviceMethod.createFromConnectionString(iotHubConnectionString);

            // Call the direct method.
            MethodResult result = methodClient.invoke(deviceId, methodName, responseTimeout, connectTimeout, payload);

            if (result == null) {
                throw new IOException("Direct method invoke returns null");
            }

            // Show the acknowledgement from the device.
            System.out.println("Status: " + result.getStatus());
            System.out.println("Response: " + result.getPayload());
        } catch (IotHubException e) {
            System.out.println("IotHubException calling direct method:");
            System.out.println(e.getMessage());
        } catch (IOException e) {
            System.out.println("IOException calling direct method:");
            System.out.println(e.getMessage());
        }
        System.out.println("Done!");
    }

}



