package site.dearmysanta.service.chatting.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import site.dearmysanta.service.chatting.ChattingDAO;

@Service("chattingService")

public class ChattingServiceImpl {
	
	@Value("${nodejsServerUrl}")
	private String nodeJsServerUrl;
	
	@Autowired
	@Qualifier("chattingDAO")
	private ChattingDAO chattingDAO;
	
	public ChattingServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public void createChattingRoom(int roomNo) {
		RestTemplate restTemplate = new RestTemplate();
        String url = nodeJsServerUrl + "/createChatRoom";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestJson = "{\"roomNo\":\"" + roomNo + "\"}";
        HttpEntity<String> entity = new HttpEntity<>(requestJson, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
        if (response.getStatusCode().is2xxSuccessful()) {
            System.out.println("Chat room created successfully.");
        } else {
            System.out.println("Failed to create chat room.");
        }
	}

}
