package site.dearmysanta.web.mountain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.domain.user.User;
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
	
	private ObjectMapper objectMapper = new ObjectMapper();
	
	
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
	public int addMountainLike(@RequestBody Like like, @RequestParam int index, int isPop ,HttpSession session) {
		//SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like.getPostNo()));
		SantaLogger.makeLog("info", like.toString());
		mountainService.addMountainLike(like);
		SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like.getPostNo()));
		Object obj;
		
		if(index != -1) {

			if (isPop == 1) {
				obj = session.getAttribute("popularMountainList");
				if (obj != null) {
					List<Mountain> list = (List<Mountain>) obj;

					list.get(index).setIsLiked(1);
					session.setAttribute("popularMountainList", list);
				}
			} else {
				obj = session.getAttribute("customMountainList");
				if (obj != null) {
					List<Mountain> list = (List<Mountain>) obj;

					list.get(index).setIsLiked(1);
					session.setAttribute("customMountainList", list);
				}
			}
		}
		
		return mountainService.getTotalMountainLikeCount(like.getPostNo());
	}//o
	
	@PostMapping("rest/deleteMountainLike")
	public int deleteMountainLike(@RequestBody Like like, @RequestParam int index, int isPop, HttpSession session) {
		//SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like.getPostNo()));
		SantaLogger.makeLog("info", like.toString());
		mountainService.deleteMountainLike(like);
		//SantaLogger.makeLog("info", ""+ mountainService.getTotalMountainLikeCount(like.getPostNo()));
		
		Object obj;
		
		if(index != -1) {
		
		if(isPop == 1) {
			obj = session.getAttribute("popularMountainList");
			if(obj != null) {
				List<Mountain> list = (List<Mountain>) obj;
			
				list.get(index).setIsLiked(0);
				session.setAttribute("popularMountainList", list);
			}
		}else {
			obj = session.getAttribute("customMountainList");
			if(obj != null) {
				List<Mountain> list = (List<Mountain>) obj;
			
				list.get(index).setIsLiked(0);
				session.setAttribute("customMountainList", list);
			}
		}
		}
		
		return mountainService.getTotalMountainLikeCount(like.getPostNo());
	}//o
	
	@PostMapping("rest/updateMountain")
	public Mountain updateMountain(@RequestParam int crpNo, @RequestBody Mountain mountain, HttpSession session) {
		SantaLogger.makeLog("info", mountain.toString() + " :: " + crpNo + "/" );
		mountainService.updateMountain(mountain);
		
		correctionPostService.updateCorrectionPostStatus(crpNo);
		

		User user = (User)session.getAttribute("user");
		if(user == null) {
			SantaLogger.makeLog("info", "user null");
			
			mountain =  mountainService.getMountain(-1,mountain.getMountainNo());
		}else {
		
			SantaLogger.makeLog("info", "user  not null");
		
			mountain =  mountainService.getMountain(user.getUserNo(),mountain.getMountainNo());
		}
		return mountain;
	}//o
	
	
	@GetMapping("rest/getWeather")
	public Weather getWeather(@RequestParam double lat, double lon) throws Exception {
		return weatherService.getWeather(lat, lon);
	}
	
	
	@PostMapping("rest/deleteSearchKeyword")
	public List<MountainSearch> deleteSearchKeyword(@RequestBody MountainSearch mountainSearch ){
		//세션에서 userId 받아오기 
		//나중에 반환형도 지우기 
		SantaLogger.makeLog("info", "deleteSearchKeyword:" + mountainSearch);
		mountainService.deleteSearchKeyword(mountainSearch);
		
		return mountainService.getSearchKeywordList(1);
	}
	
	@GetMapping("/rest/checkIsMountain")
	public Map<String,Object> checkIsMountain(String mountainName, HttpSession session) throws JsonProcessingException {
		Map<String,Object> map = new HashMap<String,Object>();
		
		int isMountain = mountainService.isMountain(mountainName);
		MountainSearch mountainSearch = new MountainSearch();
		User user = (User)session.getAttribute("user");
		mountainSearch.setSearchKeyword(mountainName);
		
		if(user == null) {
			user = new User();
			user.setUserNo(-1);
		}
		
		
		
		if(isMountain == 1) {
			
			map.put("isMountain", 1);
			List<Mountain> list = mountainService.getMountainListByName(user.getUserNo(), mountainSearch.getSearchKeyword());
			List<String> weatherList = new ArrayList<>();
			
			List<String> jsonList = new ArrayList<>();
			for (Mountain mt : list) {
				SantaLogger.makeLog("info", mt.toString());

				jsonList.add(objectMapper.writeValueAsString(mt));
				weatherList.add(objectMapper.writeValueAsString(weatherService.getWeatherList(mt.getMountainLatitude(), mt.getMountainLongitude()).get(0)));	
			}
			
			map.put("mountainList", jsonList);
			map.put("weatherList", weatherList);
		}else {
			map.put("isMountain", 0);
		}
		
		
		if(user != null) {
			if(isMountain == 1) {
				mountainSearch.setSearchCondition(0);
				mountainSearch.setUserNo(user.getUserNo());
				mountainService.deleteSearchKeyword(mountainSearch);				
				mountainService.addSearchKeyword(mountainSearch);
			}
		}
		
		return map;
		
	}
	
	
	
	//checkMountainLike logic 필요 

}
