package org.frog;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan(basePackages = "org.frog.controller")
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
