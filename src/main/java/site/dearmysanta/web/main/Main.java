package site.dearmysanta.web.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Main {
	
	@GetMapping("/")
	public String mainController() {
		return "redirect:/mountain/mapMountain.html";
	}
	
}
