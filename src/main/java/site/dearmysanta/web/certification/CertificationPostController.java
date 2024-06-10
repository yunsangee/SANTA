package site.dearmysanta.web.certification;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.service.certification.CertificationPostService;

@Controller
@RequestMapping("/certificationPost")
public class CertificationPostController {

    @Autowired
   // @Qualifier("CertificationPostServiceImpl")
    private CertificationPostService certificationPostService;

    public CertificationPostController() {
        System.out.println(this.getClass());
    }

    @GetMapping(value = "addCertificationPost")
    public String addCertificationPost() throws Exception {
        System.out.println("/addCertificationPost : GET");
        return "forward:/certificationPost/addCertificationPostView.jsp";
    }

    @PostMapping(value = "addCertificationPost")
    public String addCertificationPost(@ModelAttribute CertificationPost certificationPost, Model model) throws Exception {
        certificationPostService.addCertificationPost(certificationPost);
        System.out.println("add : POST");
        model.addAttribute("certificationPost", certificationPost);
        return "forward:/certificationPost/addCertificationPost.jsp";
    }
}
