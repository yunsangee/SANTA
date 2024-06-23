package site.dearmysanta.web.chatting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.service.common.ObjectStorageService;

@RestController
@RequestMapping("/chatting/*")
public class ChattingRestController {
	
	@Autowired
	@Qualifier("objectStorageService")
	private ObjectStorageService objectStorageService;
	
	public ChattingRestController() {
		System.out.println(this.getClass());
	}
	
//	@PostMapping(value = "rest/addChattingImage") 
//	public void addMeetingPostComment(@RequestBody ) throws Exception {
//		
//		
//		
//		
//	}
	
}
