package site.dearmysanta;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
@Configuration
@PropertySource(value="classpath:/static/config/mountain/naver.properties")
public class SantaApplication {

	public static void main(String[] args) {
		SpringApplication.run(SantaApplication.class, args);
	}

}