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
     * īī�� callback
     * [GET] /oauth/kakao/callback
     */
    @GetMapping("/kakao")
    public ModelAndView kakaoCallback(@RequestParam String code) {
        String access_token = oauthService.getKakaoAccessToken(code);

        // ���⼭ OAuthService�� �ٸ� �޼��带 ȣ���Ͽ� �߰����� ������ ó���� �� ����
        try {
            oauthService.CreateKakaoUser(access_token);
        } catch (Exception e) {
            // ���� ó��
            e.printStackTrace();
            ModelAndView modelAndView = new ModelAndView("error"); // ���� �������� �����̷�Ʈ ����
            modelAndView.addObject("errorMessage", "Error while creating Kakao user");
            return modelAndView;
        }

        // user/main.jsp �������� �����̷�Ʈ
        ModelAndView modelAndView = new ModelAndView("redirect:/user/main.jsp");
        // �ʿ��� ��� �𵨿� �߰����� �����͸� ���� �� ����
        return modelAndView;
    }
    
//    @GetMapping("/naver")
//    public ModelAndView naverCallback(@RequestParam)
}
