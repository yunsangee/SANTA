package site.dearmysanta.web.correctionpost;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.correctionPost.CorrectionPost;
import site.dearmysanta.service.correctionpost.CorrectionPostService;

@Controller
@RequestMapping("correctionPost/*")
public class CorrectionPostController {
	
	@Autowired
	CorrectionPostService correctionPostService;
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;;
	
	public CorrectionPostController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	
	@GetMapping("getCorrectionPostList")
	public String correctionPostList(@ModelAttribute Search search, Model model) {
		
			if(search ==null) {
				search = new Search();
			}
		  	if (search != null && search.getCurrentPage() == 0) {
		        search.setCurrentPage(1);
		    }
		  	
		  	search.setPageSize(pageSize);
		  	search.setPageUnit(pageUnit);
		
			List<CorrectionPost> list = correctionPostService.getCorrectionPostList(search);
		
			SantaLogger.makeLog("info", "correctionPostList:" + list);
			int totalCount = list.size(); // 총 사용자 수
		    int totalPages = (int) Math.ceil((double) correctionPostService.getCorrectionPostTotalCount(search) / pageSize); // 총 페이지 수 계산
		    int currentPage = search.getCurrentPage();
		   

		    int currentPageCount = pageSize; // 현재 페이지에 표시되는 회원 수

		    model.addAttribute("correctionPostList", list );
		    model.addAttribute("search", search);
		    model.addAttribute("currentPage", currentPage);
		    model.addAttribute("totalPages", totalPages);
		    model.addAttribute("totalCount", totalCount);
		    model.addAttribute("currentPageCount", currentPageCount);

		return "forward:/correctionPost/getCorrectionPostList.jsp";
	}
	

}
