package site.dearmysanta.web.mountain;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.service.correctionpost.CorrectionPostService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.weather.WeatherService;

@RestController
@RequestMapping("/mountain/*")
public class MountainRestController {
	
	@Value("${naverMapClientID}")
	private String clientId;
	
	@Value("${naverMapSecretKey}")
	private String clientSecret;
	
	@Autowired
	MountainService mountainService;
	
	
	@Autowired
	WeatherService weatherService;
	
	@Autowired
	CorrectionPostService correctionPostService;
	
	
	
	
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
	}//나중에 서비스로 보내기
	
	
	@PostMapping("rest/addMountainLike")
	public int addMountainLike(@RequestBody Like like) {
		SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like));
		mountainService.addMountainLike(like);
		SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like));
		return mountainService.getTotalMountainLikeCount(like);
	}//o
	
	@PostMapping("rest/deleteMountainLike")
	public int deleteMountainLike(@RequestBody Like like) {
		SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like));
		mountainService.deleteMountainLike(like);
		SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like));
		return mountainService.getTotalMountainLikeCount(like);
	}//o
	
	@PostMapping("rest/updateMountain")
	public Mountain updateMountain(@RequestBody Mountain mountain, @RequestParam int crpNo) {
		SantaLogger.makeLog("info", mountain.toString());
		mountainService.updateMountain(mountain);
		
		correctionPostService.updateCorrectionPostStatus(crpNo);
		
		System.out.println(mountainService.getMountain(mountain.getMountainNo()));
		return mountainService.getMountain(mountain.getMountainNo());
	}//o
	
	
	@GetMapping("rest/getWeather")
	public Weather getWeather(@RequestParam double lat, double lon) throws Exception {
		return weatherService.getWeather(lat, lon);
	}
	
	
	@GetMapping("rest/deleteSearchKeyword")
	public List<MountainSearch> deleteSearchKeyword(@ModelAttribute MountainSearch mountainSearch ){
		//세션에서 userId 받아오기 
		//나중에 반환형도 지우기 
		mountainService.deleteSearchKeyword(mountainSearch);
		
		return mountainService.getSearchKeywordList(1);
	}
	
	
	
	
	//checkMountainLike logic 필요 

}
