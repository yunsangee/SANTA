package site.dearmysanta.web.user;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.user.OAuthService;
import site.dearmysanta.service.user.UserService;

@Controller
@RequestMapping("/oauth")
public class OAuthController {

//    private final OAuthService oauthService;

    @Autowired
    private OAuthService oauthService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private MountainService mountainService;

    /**
     * 카카오 callback
     * [GET] /oauth/kakao/callback
     */
    @GetMapping("/kakao")
    public ModelAndView kakaoCallback(@RequestParam String code, HttpSession session) {
    	 String access_token = oauthService.getKakaoAccessToken(code);
    	    User user = null;

    	    try {
    	        user = oauthService.CreateKakaoUser(access_token);

    	        // 세션에 사용자 정보 저장
    	        if (user != null) {
    	            session.setAttribute("user", user);
    	            
//    	            session.setAttribute("popularMountainList", mountainService.getPopularMountainList(mountainService.getStatisticsMountainNameList(1), new Search()));
//    	            session.setAttribute("customMountainList", mountainService.getCustomMountainList(mountainService.getStatisticsMountainNameList(1), user));
    	        
    	        } else {
    	            ModelAndView modelAndView = new ModelAndView("error");
    	            modelAndView.addObject("errorMessage", "사용자 정보가 없습니다.");
    	            return modelAndView;
    	        }

    	    } catch (Exception e) {
    	        e.printStackTrace();
    	        ModelAndView modelAndView = new ModelAndView("error");
    	        modelAndView.addObject("errorMessage", "Error while creating Kakao user");
    	        return modelAndView;
    	    }

    	    ModelAndView modelAndView = new ModelAndView("redirect:/common/main.jsp");
    	    return modelAndView;
    	}
    
    //////////////////////////////////////////////////////////////////////////////////
//    @GetMapping("/oauth/kakao")
//    public void kakaoLogin(HttpServletResponse response) throws IOException {
//        // 새로운 로그인 요청 시작
//        response.sendRedirect("https://kauth.kakao.com/oauth/authorize?client_id=53ae98941fff9e24b11901e9a79432d9&redirect_uri=http://localhost:8001/oauth/kakao&response_type=code");
//    }
    
    @PostMapping("/logout/kakao")
    @ResponseBody
    public void kakaoLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String accessToken = (String) request.getSession().getAttribute("accessToken"); // Replace with actual token retrieval logic
        if (accessToken != null) {
            oauthService.kakaoLogout(accessToken);
            request.getSession().invalidate(); // 세션 무효화
        }
        response.setStatus(HttpServletResponse.SC_OK);
    }

//    @GetMapping("/naver")
//    public ModelAndView naverCallback(@RequestParam)
}
