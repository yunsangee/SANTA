package site.dearmysanta.web.correctionpost;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.correctionPost.CorrectionPost;
import site.dearmysanta.service.correctionpost.CorrectionPostService;

@RestController
@RequestMapping("correctionPost/*")
public class CorrectionPostRestController {
	
	@Autowired
	CorrectionPostService correctionPostSerivce;
	
	public CorrectionPostRestController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	@GetMapping("rest/addCorrectionPost")
	public String addCorrectionPost(@ModelAttribute CorrectionPost correctionPost) {
		SantaLogger.makeLog("info", "addCorrectionPost");
		SantaLogger.makeLog("info", correctionPost.toString());
		correctionPostSerivce.addCorrectionPost(correctionPost);
		return "success";
	}
	
	
	@PostMapping("rest/deleteCorrectionPost")
	public void deleteCorrectionPost(@RequestBody CorrectionPost correctionPost) {
		correctionPostSerivce.deleteCorrectionPost(correctionPost.getUserNo(), correctionPost.getPostNo());
	}

}
