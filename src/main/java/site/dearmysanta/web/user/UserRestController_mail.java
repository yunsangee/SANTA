package site.dearmysanta.web.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.service.mail.MailService;

@RestController
@RequestMapping("/user/*")

public class UserRestController_mail {

    @Autowired
    private MailService mailService;

    @GetMapping("rest/sendVerification")
    public String sendVerificationEmail(@RequestParam("email") String email) {
        try {
            mailService.makeRandomNumber(email);
            mailService.mailSend(email);
            SantaLogger.makeLog("info", "Verification email sent to: " + email);
            return "Verification email sent successfully.";
        } catch (Exception e) {
            SantaLogger.makeLog("error", "Error sending verification email to: " + email + ". " + e.getMessage());
            return "Failed to send verification email.";
        }
    }

    @PostMapping("rest/verify")
    public String verifyCode(@RequestParam("email") String email, @RequestParam("code") int code) {
        boolean isVerified = mailService.checkAuth(email, code);
        if (isVerified) {
            SantaLogger.makeLog("info", "Email verified: " + email);
            return "인증되었습니다.";
        } else {
            SantaLogger.makeLog("info", "Email verification failed for: " + email);
            return "인증번호 확인에 실패하였습니다. 다시 시도해주세요.";
        }
    }
}
