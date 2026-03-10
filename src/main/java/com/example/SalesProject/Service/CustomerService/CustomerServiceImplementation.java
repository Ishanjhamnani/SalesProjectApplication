package com.example.SalesProject.Service.CustomerService;

import com.example.SalesProject.DTOs.CustomerDTO;
import com.example.SalesProject.Entity.Customer;
import com.example.SalesProject.Repository.CustomerRepository;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImplementation implements CustomerService {

    private final CustomerRepository customerRepository;

    public CustomerServiceImplementation(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    @Override
    @Cacheable(value = "customersPage", key = "#page + '-' + #length + '-' + #draw")
    public Map<String, Object> getCustomersPage(int page, int length, int draw,String search) {

        PageRequest pageable = PageRequest.of(page, length);

        Page<CustomerDTO> customerPage;

        customerPage = customerRepository.getCustomersPage(search,pageable);

        List<Map<String, Object>> data = new ArrayList<>();

        for (CustomerDTO c : customerPage.getContent()) {
            Map<String,Object> map = new HashMap<>();
            map.put("id", c.getId());
            map.put("fullName", c.getFullName());
            map.put("email", c.getEmail());
            map.put("phoneNumber", c.getPhoneNumber());
            map.put("address",c.getAddress());
            data.add(map);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("draw", draw);
        response.put("recordsTotal", customerPage.getTotalElements());
        response.put("recordsFiltered", customerPage.getTotalElements());
        response.put("data", data);

        return response;
    }

    @Override
    @CacheEvict(value = "customersPage", allEntries = true)
    public void save(Customer customer) {
        customerRepository.save(customer);
    }

    @Override
    public void deleteById(Long id) {
        if (!customerRepository.existsById(id)) {
            throw new RuntimeException("Customer not found");
        }
        customerRepository.deleteById(id);
    }

    @Override
    public void update(Long id, Customer customer) {
        Customer updatedCustomer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        updatedCustomer.setFirstName(customer.getFirstName());
        updatedCustomer.setLastName(customer.getLastName());
        updatedCustomer.setEmail(customer.getEmail());
        updatedCustomer.setPhoneNumber(customer.getPhoneNumber());
        customerRepository.save(updatedCustomer);
    }

    @Override
    public void patch(Long id, Customer newCustomer) {

        Customer existingCustomer = customerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        if (newCustomer.getFirstName() != null) {
            existingCustomer.setFirstName(newCustomer.getFirstName());
        }

        if (newCustomer.getLastName() != null) {
            existingCustomer.setLastName(newCustomer.getLastName());
        }

        if (newCustomer.getEmail() != null) {
            existingCustomer.setEmail(newCustomer.getEmail());
        }

        if (newCustomer.getPhoneNumber() != null) {
            existingCustomer.setPhoneNumber(newCustomer.getPhoneNumber());
        }

        if (newCustomer.getAddress() != null) {
            existingCustomer.setAddress(newCustomer.getAddress());
        }

        customerRepository.save(existingCustomer);
    }
}