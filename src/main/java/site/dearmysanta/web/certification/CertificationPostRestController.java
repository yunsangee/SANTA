package site.dearmysanta.web.certification;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.user.etc.UserEtcService;

@RestController
@RequestMapping("/certificationPost/*")

public class CertificationPostRestController {

    @Autowired
    @Qualifier("CertificationPostServiceImpl")
    private CertificationPostService certificationPostService;
    
    
    @Autowired
    @Qualifier("userEtcServiceImpl")
    private UserEtcService userEtcService;
    
    public CertificationPostRestController() {
        System.out.println(this.getClass());
    }
    
    @PostMapping(value = "rest/listCertificationPost")
    public Map<String, Object> listCertificationPost(@RequestParam(required = false) Search search, Model model) throws Exception {
    	if (search == null) {
            search = new Search(); // 기본 검색 조건 설정 또는 처리
        }
        
        if (search.getSearchKeyword() == null) {
            search.setSearchKeyword(""); // 검색어가 null인 경우 빈 문자열로 설정
        }
        
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        System.out.println(result);
        List<CertificationPost> certificationPost = (List<CertificationPost>) result.get("list");
        model.addAttribute("certificationPost", certificationPost);

        System.out.println("Certification Post: " + certificationPost);

        return result;
    }
    
    @GetMapping(value="rest/updateCertificationPostDeleteFlag")
    public void updateCertificationPostDeleteFlag(@RequestParam int postNo, @RequestParam int userNo) throws Exception {
    	certificationPostService.updateCertificationPostDeleteFlag(postNo);
       userEtcService.updateCertificationCount(userNo, 1);
	}
    
    @GetMapping(value="rest/listMyCertificationPost")
    public List<CertificationPost> listMyCertificationPost(@RequestParam int userNo) throws Exception {
    	List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
        System.out.println("오잉:" + myCertificationPost);
        return myCertificationPost;
    }
    }
    
    
 
    
    
    
    
    
    
