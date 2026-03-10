package com.example.SalesProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;


@SpringBootApplication
@EnableCaching
public class SalesProjectApplication {


    public static void main(String[] args) {
        SpringApplication.run(SalesProjectApplication.class, args);
    }

}
