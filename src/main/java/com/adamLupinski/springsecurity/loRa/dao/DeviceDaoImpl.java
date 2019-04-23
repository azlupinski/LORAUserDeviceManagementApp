package com.adamLupinski.springsecurity.loRa.dao;

import com.adamLupinski.springsecurity.loRa.entity.Device;
import com.adamLupinski.springsecurity.loRa.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.PersistenceUnit;
import java.util.List;

@Repository
@Transactional
public class DeviceDaoImpl implements DeviceDao {

    @Autowired
    private SessionFactory sessionFactory;


    @Override
    public void saveDevice(Device device) {
        Session currentSession = sessionFactory.getCurrentSession();

        currentSession.save(device);

    }

    @Override
    public List<Device> getDevices(int adminAccountId) {
        Session currentSession = sessionFactory.getCurrentSession();


        @SuppressWarnings("unchecked")
        Query<Device> theQuery = currentSession.createQuery("from Device where account.id =:adminId ");
        theQuery.setParameter("adminId", adminAccountId);


        List<Device> devices = theQuery.getResultList();

        return devices;
    }

    @Override
    public Device getDevice(Long id) {
        // get the current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        // now retrieve/read from database using username
        Query<Device> theQuery = currentSession.createQuery("from Device where id=:id", Device.class);
        theQuery.setParameter("id", id);
        Device theDevice = null;
        try {
            theDevice = theQuery.getSingleResult();
        } catch (Exception e) {
            theDevice = null;
            e.printStackTrace();
        }
        System.out.println(theDevice.getUsers().size());
        return theDevice;
    }

    @Override
    public void deleteDevice(Long id) {
        Session currentSession = sessionFactory.getCurrentSession();

        Query query = currentSession.createQuery("delete from Device where id=:id");
        query.setParameter("id", id);
        query.executeUpdate();
    }

    @Override
    public void update(Device device) {

        Session currentSession = sessionFactory.getCurrentSession();

        currentSession.update(device);
        System.out.println("update device compleete");

    }
}
