package site.dearmysanta.message.test;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import site.dearmysanta.domain.message.MessageInfo;
import site.dearmysanta.web.user.UserRestController;

import static org.hamcrest.CoreMatchers.any;
import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(SpringExtension.class)
@SpringBootTest
@AutoConfigureMockMvc
public class MessageApplicationTest {

    @Autowired
    private MockMvc mockMvc;

    //@Test
    public void testSendOne() throws Exception {
        //String requestBody = "{\"phoneNumber\": \"01012345678\"}";
        String requestBody = "{\"phoneNumber\": \"01095740310\", \"userName\": \"이정한\"}";
        mockMvc.perform(MockMvcRequestBuilders.post("/message/send-one")
                .content(requestBody)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
        
        System.out.println("requestBody 확인 : " + requestBody);
    }
    
    
    
//    @Test
//    public void testGetValidationNumber() throws Exception {
//        // 테스트하기 위해 임시로 번호와 인증번호를 매핑합니다.
//        UserRestController.map.put("01095740310", 787240);
//
//        String requestBody = "{\"phoneNumber\": \"01095740310\", \"validationNumber\": 787240}";
//        mockMvc.perform(MockMvcRequestBuilders.get("/message/check-one")
//                .content(requestBody)
//                .contentType(MediaType.APPLICATION_JSON))
//                .andExpect(status().isOk())
//                .andExpect(content().string("787240"));
//    }
    
    //@Test
    public void testGetValidationNumber() throws Exception {
        // 테스트를 위한 임의의 전화번호와 인증번호 생성
        String phoneNumber = "01095740310";
        int validationNumber = 123456;
        
        // 임의의 인증번호를 맵에 추가
        UserRestController.map.put(phoneNumber, validationNumber);

        // 테스트용 MessageInfo 객체 생성
        MessageInfo messageInfo = new MessageInfo();
        messageInfo.setPhoneNumber(phoneNumber);
        messageInfo.setValidationNumber(validationNumber);

        // GET 요청 보내기
        int result = UserRestController.getValidationNumber(messageInfo);

        // 반환값이 예상된 값과 일치하는지 확인
        assertEquals(validationNumber, result);
        
        System.out.println("result 확인 : " + result);
    }

}

