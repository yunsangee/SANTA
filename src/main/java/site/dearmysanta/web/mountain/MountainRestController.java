package site.dearmysanta.web.mountain;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;

@RestController
@RequestMapping("/mountain/*")
public class MountainRestController {
	
	@Value("${naverMapClientID}")
	private String clientId;
	
	@Value("${naverMapSecretKey}")
	private String clientSecret;
	
	
	public MountainRestController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	@GetMapping("rest/searchKeywordToAddress")
	public String searchKeywordToAddress(@RequestParam String query) {
		
		SantaLogger.makeLog("info", "searchKeyword:"+query);
		System.out.println("===test===");
		
		String url = "https://openapi.naver.com/v1/search/local.json?query=" + query + "&display=1";
        
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);
        
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
        
       
        SantaLogger.makeLog("info", "response:"+response);
        
        
        
       
        JSONObject jsonObject = new JSONObject(response.getBody());
        JSONArray itemsArray = jsonObject.getJSONArray("items");
        
        SantaLogger.makeLog("info", itemsArray.getJSONObject(0).getString("address"));
        SantaLogger.makeLog("info", itemsArray.getJSONObject(0).getString("roadAddress"));
		
		return itemsArray.getJSONObject(0).getString("address");
	}

}
