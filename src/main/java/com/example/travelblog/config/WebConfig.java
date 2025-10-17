package com.example.travelblog.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

/**
 * Modern Web MVC Configuration (2025 Best Practices)
 * Centralized configuration for web resources and view resolvers
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(@SuppressWarnings("null") ViewResolverRegistry registry) {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/jsp/");
        resolver.setSuffix(".jsp");
        resolver.setContentType("text/html;charset=UTF-8");
        resolver.setOrder(Ordered.HIGHEST_PRECEDENCE);
        resolver.setCache(false);
        resolver.setExposeContextBeansAsAttributes(true);
        resolver.setExposedContextBeanNames("*");
        
        registry.viewResolver(resolver);
    }

    @Override
    public void addResourceHandlers(@SuppressWarnings("null") ResourceHandlerRegistry registry) {
        // CSS resources
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/")
                .setCachePeriod(3600)
                .resourceChain(true);

        // JavaScript resources
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/")
                .setCachePeriod(3600)
                .resourceChain(true);

        // Images - from webapp directory
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/", "classpath:/static/images/")
                .setCachePeriod(3600)
                .resourceChain(true);

        // Videos - from webapp directory
        registry.addResourceHandler("/videos/**")
                .addResourceLocations("/videos/", "classpath:/static/videos/")
                .setCachePeriod(3600)
                .resourceChain(true);

        // Fonts
        registry.addResourceHandler("/fonts/**")
                .addResourceLocations("classpath:/static/fonts/")
                .setCachePeriod(86400)
                .resourceChain(true);

        // Other assets
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/static/assets/")
                .setCachePeriod(3600)
                .resourceChain(true);

        // Generic resources
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("classpath:/static/")
                .setCachePeriod(3600)
                .resourceChain(true);
    }

    @Override
    public void addViewControllers(@SuppressWarnings("null") ViewControllerRegistry registry) {
        registry.addViewController("/error").setViewName("error");
        registry.addViewController("/403").setViewName("error/403");
        registry.addViewController("/404").setViewName("error/404");
        registry.addViewController("/500").setViewName("error/500");
        registry.setOrder(Ordered.LOWEST_PRECEDENCE);
    }

    @Override
    public void addCorsMappings(@SuppressWarnings("null") CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOrigins("http://localhost:3000", "http://localhost:8080")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}

