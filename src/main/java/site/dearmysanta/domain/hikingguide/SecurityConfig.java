package site.dearmysanta.domain.hikingguide;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration @EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable() // Disable CSRF for simplicity, enable it and configure properly for production
            .authorizeRequests(authorizeRequests ->
                authorizeRequests
                    .antMatchers("/hiking/react/**").permitAll() // Allow unauthenticated access to /hiking/react/*
                    .anyRequest().permitAll()
            );
        return http.build();
    }
}