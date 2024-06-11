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
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
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
    
    
    
        
//   Submit해서 들어오는건 포스트매핑
//    url타고들어오는건 겟
    @GetMapping(value ="addCertificationPost")
    public String addCertificationPost() throws Exception {
    	
    	  return "forward:/certificationPost/addCertificationPost.jsp";
    }
    
    //user에 카운트하는거?어떻ㅎ게하는데

    @PostMapping(value = "addCertificationPost")
    public String addCertificationPost(@ModelAttribute CertificationPost certificationPost, Model model) throws Exception {
        certificationPostService.addCertificationPost(certificationPost);
     
  
        return "forward:/certificationPost/getCertificationPost.jsp";
    }
   
    @PostMapping(value = "updateCertificationPost")
    public String updateCertificationPost(@ModelAttribute CertificationPost certificationPost ) throws Exception {
    	
    	certificationPostService.updateCertificationPost(certificationPost);
    	return "forward:/certificationPost/updateCertificationPost.jsp";
    	
    }

   // @PostMapping(value = "getCertificationPostList")
    @RequestMapping(value = "listCertificationPost")
  //  public String listCertificationPost(@ModelAttribute Search search, Model model) throws Exception {
    public String listCertificationPost(@RequestParam(required=false) Search search, Model model) throws Exception {
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        System.out.println(result);
        List<CertificationPost> certificationPost = (List<CertificationPost>) result.get("list");
        model.addAttribute("certificationPost", certificationPost);

         System.out.println("Certification Post: " + certificationPost);

        return "forward:/certificationPost/listCertificationPost.jsp";
    }
    
    @RequestMapping(value="getCertificationPost")
    public String getCertificationPost(@RequestParam int postNo, Model model) throws Exception {
    	
    	 Map<String, Object> certificationPost = certificationPostService.getCertificationPost(postNo);
    	 List<CertificationPostComment> certificationPostComment = certificationPostService.getCertificationPostCommentList(postNo);
    	 System.out.println("CertificationPost:"+certificationPost);


    	 model.addAttribute("certificationPost", certificationPost.get("certificationPost"));
    	 model.addAttribute("certificationPostComments", certificationPostComment);
       model.addAttribute("hashtagList", certificationPost.get("hashtagList"));
    	
         System.out.println("이거맞지"+certificationPostComment);
         
         return "forward:/certificationPost/getCertificationPost.jsp";
 					  
    	 
    }



}