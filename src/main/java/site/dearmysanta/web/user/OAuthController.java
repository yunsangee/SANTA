package site.dearmysanta.web.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import site.dearmysanta.service.user.OAuthService;

@Controller
@RequestMapping("/oauth")
public class OAuthController {

    private final OAuthService oauthService;

    @Autowired
    public OAuthController(OAuthService oauthService) {
        this.oauthService = oauthService;
    }

    /**
     * 카카오 callback
     * [GET] /oauth/kakao/callback
     */
    @GetMapping("/kakao")
    public ModelAndView kakaoCallback(@RequestParam String code) {
        String access_token = oauthService.getKakaoAccessToken(code);

        // 여기서 OAuthService의 다른 메서드를 호출하여 추가적인 로직을 처리할 수 있음
        try {
            oauthService.CreateKakaoUser(access_token);
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
            ModelAndView modelAndView = new ModelAndView("error"); // 에러 페이지로 리다이렉트 예시
            modelAndView.addObject("errorMessage", "Error while creating Kakao user");
            return modelAndView;
        }

        // user/main.jsp 페이지로 리다이렉트
        ModelAndView modelAndView = new ModelAndView("redirect:/user/main.jsp");
        // 필요한 경우 모델에 추가적인 데이터를 담을 수 있음
        return modelAndView;
    }
    
//    @GetMapping("/naver")
//    public ModelAndView naverCallback(@RequestParam)
}
