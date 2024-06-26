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
import site.dearmysanta.service.chatting.ChattingService;

@Service("chattingService")
public class ChattingServiceImpl implements ChattingService {
	
//	@Value("${nodejsServerUrl}")
//	private String nodeJsServerUrl;
	private String nodeJsServerUrl = "https://www.dearmysanta.site/chattingserver";
	
	@Autowired
	@Qualifier("chattingDAO")
	private ChattingDAO chattingDAO;
	
	public ChattingServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public void createChattingRoom(int roomNo) {
		RestTemplate restTemplate = new RestTemplate();
        String url = nodeJsServerUrl + "/createChattingRoom";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        String requestJson = "{\"roomNo\":\"" + roomNo + "\"}";
        HttpEntity<String> entity = new HttpEntity<>(requestJson, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
        if (response.getStatusCode().is2xxSuccessful()) {
            if (response.getBody().contains("already exists")) {
                System.out.println("Chatting room already exists.");
            } else {
            	System.out.println("Chatting room created");
            }
        }
	}

}
