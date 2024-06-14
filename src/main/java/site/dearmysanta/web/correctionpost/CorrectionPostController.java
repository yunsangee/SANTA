package site.dearmysanta.web.correctionpost;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.service.correctionpost.CorrectionPostService;

@Controller
@RequestMapping("correctionPost/*")
public class CorrectionPostController {
	
	@Autowired
	CorrectionPostService correctionPostService;
	
	public CorrectionPostController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	
	@GetMapping("getCorrectionPostList")
	public String correctionPostList(Model model) {
		
		model.addAttribute("correctionPostList", correctionPostService.getCorrectionPostList());
		
		return "forward:/correctionPost/getCorrectionPostList.jsp";
	}
	

}
