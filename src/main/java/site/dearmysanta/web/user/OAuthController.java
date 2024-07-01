package site.dearmysanta.web.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public ModelAndView kakaoCallback(@RequestParam String code, HttpSession session, RedirectAttributes redirectAttributes, HttpServletResponse response) {
        String access_token = oauthService.getKakaoAccessToken(code);
        
        session.setAttribute("accessToken", access_token);
        
        User user = null;

        try {
        	user = oauthService.CreateKakaoUser(access_token);
           System.out.println(user);
           
           session.setAttribute("user", user);
        	
        	String userId = user.getUserId();
        	System.out.println(userId);
        	
            // 중복된 사용자 확인
            List<User> existingUsers = userService.getUserByUserId(userId);
            
            System.out.println(existingUsers);
            
            if (existingUsers.size() > 1) {
            	System.out.println("existing:");
                throw new RuntimeException("중복된 아이디입니다.");
                
            } else if (existingUsers.size() == 1) {
            	
            	User checkUser = existingUsers.get(0);
            	
            	if (checkUser.getUserPassword().equals( "kakao")) {
            		
            		session.setAttribute("user", checkUser);
            		
            		return new ModelAndView("forward:/common/main.jsp");
            		
            	} else {
            		
            	System.out.println("existing2:");
                throw new RuntimeException("가입된 이메일입니다.");
            	}
            	
            }  else if(existingUsers.size() == 0) {
            		userService.addUser(user);
            	    session.setAttribute("user", user);
            }         
        
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("existing6:");
            redirectAttributes.addFlashAttribute("errorMessage", "Error while creating Kakao user");
            return new ModelAndView("redirect:/user/errorPage.jsp");
        }
       
	    
	    // 쿠키 설정
	    Cookie cookie = new Cookie("userNo", ""+user.getUserNo());
	    cookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일로 설정
	    cookie.setPath("/"); // 애플리케이션의 모든 경로에 대해 유효
	    cookie.setHttpOnly(false); // 클라이언트 측에서도 접근 가능하도록 설정 (보안 필요 시 true)
	    cookie.setSecure(false); // 
	    response.addCookie(cookie);
	    
	    // 쿠키 설정
	    Cookie nickNameCookie = new Cookie("nickName", user.getNickName());
	    nickNameCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일로 설정
	    nickNameCookie.setPath("/"); // 애플리케이션의 모든 경로에 대해 유효
	    nickNameCookie.setHttpOnly(false); // 클라이언트 측에서도 접근 가능하도록 설정 (보안 필요 시 true)
	    nickNameCookie.setSecure(false); // 
	    response.addCookie(nickNameCookie);
	    
	 // 쿠키 설정
	    Cookie profileCookie = new Cookie("profile", user.getProfileImage());
	    profileCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일로 설정
	    profileCookie.setPath("/"); // 애플리케이션의 모든 경로에 대해 유효
	    profileCookie.setHttpOnly(false); // 클라이언트 측에서도 접근 가능하도록 설정 (보안 필요 시 true)
	    profileCookie.setSecure(false); // 
	    response.addCookie(profileCookie);
	    
	    System.out.println("쿠키확인 닉네임 : " + nickNameCookie);
	    
	    System.out.println("쿠키확인 userNo : " + cookie);
	    
	    System.out.println("쿠키 프로필 사진 : " + profileCookie);
        
        
        return new ModelAndView("forward:/");
    }

	//////////////////////////////////////////////////////////////////////////////////
//    @GetMapping("/oauth/kakao")
//    public void kakaoLogin(HttpServletResponse response) throws IOException {
//        // 새로운 로그인 요청 시작
//        response.sendRedirect("https://kauth.kakao.com/oauth/authorize?client_id=53ae98941fff9e24b11901e9a79432d9&redirect_uri=http://localhost:8001/oauth/kakao&response_type=code");
//    }

	@GetMapping("/logout/kakao")
	@ResponseBody
	public ModelAndView kakaoLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		
		User sessionUser = (User) session.getAttribute("user");
		
		System.out.println("user : " + sessionUser);
		
		String accessToken = (String) request.getSession().getAttribute("accessToken"); // Replace with actual token
																						// retrieval logic
		if (accessToken != null) {
			oauthService.kakaoLogout(accessToken);
			request.getSession().invalidate(); // 세션 무효화
			return new ModelAndView("redirect:/common/main.jsp");
		}
		response.setStatus(HttpServletResponse.SC_OK);
	
		return new ModelAndView("redirect:/common/main.jsp");
	}
	
	

//    @GetMapping("/naver")
//    public ModelAndView naverCallback(@RequestParam)
}