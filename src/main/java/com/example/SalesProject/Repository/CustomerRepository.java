package com.example.SalesProject.Repository;

import com.example.SalesProject.DTOs.CustomerDTO;
import com.example.SalesProject.Entity.Customer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Long> {

    @Query(
            value = """
            SELECT
                id,
                CONCAT(first_name, ' ', last_name) AS fullName,
                email,
                phone_number AS phoneNumber,
                address
            FROM customers
            WHERE (:search IS NULL OR :search = ''
                OR LOWER(CONCAT(first_name, ' ', last_name)) LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(email)        LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(phone_number) LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(address)      LIKE LOWER(CONCAT('%', :search, '%')))
        """,
            countQuery = """
            SELECT COUNT(*) FROM customers
            WHERE (:search IS NULL OR :search = ''
                OR LOWER(CONCAT(first_name, ' ', last_name)) LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(email)        LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(phone_number) LIKE LOWER(CONCAT('%', :search, '%'))
                OR LOWER(address)      LIKE LOWER(CONCAT('%', :search, '%')))
        """,
            nativeQuery = true
    )
    Page<CustomerDTO> getCustomersPage(@Param("search") String search, Pageable pageable);
}