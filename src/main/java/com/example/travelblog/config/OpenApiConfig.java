package com.example.travelblog.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

/**
 * OpenAPI/Swagger Configuration (2025 Best Practices)
 * Provides interactive API documentation
 */
@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI travelBlogOpenAPI() {
        Server devServer = new Server();
        devServer.setUrl("http://localhost:8080");
        devServer.setDescription("Development Server");

        Server prodServer = new Server();
        prodServer.setUrl("https://travelblog.example.com");
        prodServer.setDescription("Production Server");

        Contact contact = new Contact();
        contact.setName("Travel Blog Support");
        contact.setEmail("support@travelblog.com");
        contact.setUrl("https://travelblog.com");

        License license = new License()
            .name("MIT License")
            .url("https://opensource.org/licenses/MIT");

        Info info = new Info()
            .title("MyTour Travel Blog API")
            .version("2.0.0")
            .contact(contact)
            .description("Modern Travel Blog Application API with comprehensive travel package management")
            .termsOfService("https://travelblog.com/terms")
            .license(license);

        return new OpenAPI()
            .info(info)
            .servers(List.of(devServer, prodServer));
    }
}



