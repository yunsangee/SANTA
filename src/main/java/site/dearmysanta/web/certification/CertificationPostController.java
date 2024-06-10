package site.dearmysanta.web.certification;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.service.certification.CertificationPostService;

@Controller
@RequestMapping("/certificationPost/*")
public class CertificationPostController {

    @Autowired
    @Qualifier("CertificationPostServiceImpl")
    private CertificationPostService certificationPostService;

    public CertificationPostController() {
        System.out.println(this.getClass());
    }

    @PostMapping(value = "addCertificationPost")
    public String addCertificationPost(@ModelAttribute CertificationPost certificationPost, Model model) throws Exception {
        certificationPostService.addCertificationPost(certificationPost);
        System.out.println("add : POST");
        model.addAttribute("certificationPost", certificationPost);
        return "forward:/certificationPost/addCertificationPost.jsp";
    }

    @PostMapping(value = "getCertificationPostList")
    public String getCertificationPostList(@ModelAttribute Search search, Model model) throws Exception {
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        List<CertificationPost> certificationPost = (List<CertificationPost>) result.get("list");
        model.addAttribute("certificationPost", certificationPost);

        // 디버깅을 위해 데이터 출력
        System.out.println("Certification Post: " + certificationPost);

        return "forward:/certificationPost/listCertificationPost.jsp";
    }
}