package com.example.SalesProject.Service.CustomerService;
import com.example.SalesProject.Entity.Customer;
import java.util.Map;

public interface CustomerService {

    Map<String, Object> getCustomersPage(int page, int length, int draw,String search);

    void save(Customer customer);

    void deleteById(Long id);

    void update(Long id, Customer customer);

    void patch(Long id, Customer customer);
}