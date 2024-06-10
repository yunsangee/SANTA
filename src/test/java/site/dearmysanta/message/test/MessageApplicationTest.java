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
        String requestBody = "{\"phoneNumber\": \"01095740310\", \"userName\": \"������\"}";
        mockMvc.perform(MockMvcRequestBuilders.post("/message/send-one")
                .content(requestBody)
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
        
        System.out.println("requestBody Ȯ�� : " + requestBody);
    }
    
    
    
//    @Test
//    public void testGetValidationNumber() throws Exception {
//        // �׽�Ʈ�ϱ� ���� �ӽ÷� ��ȣ�� ������ȣ�� �����մϴ�.
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
        // �׽�Ʈ�� ���� ������ ��ȭ��ȣ�� ������ȣ ����
        String phoneNumber = "01095740310";
        int validationNumber = 123456;
        
        // ������ ������ȣ�� �ʿ� �߰�
        UserRestController.map.put(phoneNumber, validationNumber);

        // �׽�Ʈ�� MessageInfo ��ü ����
        MessageInfo messageInfo = new MessageInfo();
        messageInfo.setPhoneNumber(phoneNumber);
        messageInfo.setValidationNumber(validationNumber);

        // GET ��û ������
        int result = UserRestController.getValidationNumber(messageInfo);

        // ��ȯ���� ����� ���� ��ġ�ϴ��� Ȯ��
        assertEquals(validationNumber, result);
        
        System.out.println("result Ȯ�� : " + result);
    }

}

