package site.dearmysanta.service.mountain.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.MountainTrail;
import site.dearmysanta.domain.mountain.Statistics;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.mountain.MountainDao;
import site.dearmysanta.service.mountain.MountainService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.json.JSONObject;
import org.json.JSONArray;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;

import io.github.bonigarcia.wdm.WebDriverManager;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import java.util.concurrent.TimeUnit;


@Service
@Transactional
public class MountainServiceImpl implements MountainService {
	
	@Autowired
	@Qualifier("mountainDao")
	MountainDao mountainDao;
	
	@Value("${naverMapClientID}")
	private String clientId;
	
	@Value("${naverMapSecretKey}")
	private String clientSecret;
	
	
	@Value("${bucketname}")
	private String bucketname;
	
	@Value("${mountainAPIKey}")
	private String API_KEY;
	
	
	@Value("${vWorldAPIKey}")
	private String vWorldAPIKey;
	
	@Autowired
	ObjectStorageService objectStorageService;
	
	
	private int index =0;
	
	// 나중에 테스트할 때 등산로 박는 부분 산이름 뒤에 숫자를 index로 바꿔서 사용할 것
	
	 
	//
	// mountainName, fix mountainName in mountainTrail class
	//


	public String getEmdCodeByCoordinates(double lat, double lon) throws JsonMappingException, JsonProcessingException {

		SantaLogger.makeLog("info", "getEmdCodeByCoordinates");

		String reverseGeocodeUrl = "https://api.vworld.kr/req/address?service=address&request=getAddress&key=" + vWorldAPIKey
				+ "&domain=http://dearmysanta.site" + "&point=" + lon + "," + lat + "&type=PARCEL";
		
		String location = "";

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> geocodeResponse = restTemplate.getForEntity(reverseGeocodeUrl, String.class);

		JSONObject geocodeJson = new JSONObject(geocodeResponse.getBody());
		if (geocodeJson.has("response") && geocodeJson.getJSONObject("response").has("result")) {
			JSONArray results = geocodeJson.getJSONObject("response").getJSONArray("result");
			SantaLogger.makeLog("info","results:" + results);
			if (results.length() > 0) {
				JSONObject result = results.getJSONObject(0);
				if (result.has("structure") && result.getJSONObject("structure").has("level4L")) {
					
					location = result.getJSONObject("structure").getString("level1") +" "+ result.getJSONObject("structure").getString("level2") + " " + result.getJSONObject("structure").getString("level4L");
					
					SantaLogger.makeLog("info","Level4L: " + location);
					
//					getRegionCode(location);
				}
			}
		}
		
		
		return location;

	}//need to emdCd Code to use mountainTrail API. so get do/si/dong address
	
	
	
	 public String getRegionCode(String regionName) throws JsonMappingException, JsonProcessingException {
	        String url = "http://apis.data.go.kr/1741000/StanReginCd/getStanReginCdList"
	                + "?serviceKey=" + API_KEY
	                + "&type=json"
	                + "&size=100"
	                + "&page=1"
	                + "&numOfRows=100"
	                + "&locatadd_nm=" + regionName;

	        RestTemplate restTemplate = new RestTemplate();
	        HttpHeaders headers = new HttpHeaders();
	        HttpEntity<String> entity = new HttpEntity<>(headers);

	        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

	        JSONObject responseJson = new JSONObject(response.getBody());
	        
	        JSONArray rows = responseJson.getJSONArray("StanReginCd").getJSONObject(1).getJSONArray("row");
	        String locatjuminCd = rows.getJSONObject(0).getString("locatjumin_cd");
	        String emdCd = locatjuminCd.substring(0, locatjuminCd.length()-2);
	        SantaLogger.makeLog("info",locatjuminCd.substring(0, locatjuminCd.length()-2));
	        
//	        getMountainTrailListFromVWorld(emdCd);
	        return emdCd;
	 }// do/si/dong address to emdCd
	
	 public static MountainTrail mapJsonToMountainTrail(JsonNode feature) {
		 	if(feature.get("properties") == null) {
		 		return new MountainTrail();
		 	}
	        JsonNode properties = feature.get("properties");
	        JsonNode geometry = feature.get("geometry");
	        JsonNode coordinatesArray = geometry.get("coordinates").get(0); // Access the MultiLineString

	        List<List<Double>> coordinateList = new ArrayList<>();
	        for (JsonNode coord : coordinatesArray) {
	            double longitude = coord.get(0).asDouble();
	            double latitude = coord.get(1).asDouble();
	            
//	            SantaLogger.makeLog("info","!!::" + latitude + " " + longitude);
	            List<Double> coords = new ArrayList<>();
	            coords.add(latitude);
	            coords.add(longitude);
	            coordinateList.add(coords);
	        }

	        return MountainTrail.builder()
	                .mountainName(properties.get("mntn_nm").asText())
	                .mountainTrailCoordinates(coordinateList)
	                .mountainTrailDifficulty(properties.get("cat_nam").asText())
	                .mountainTrailLength(properties.get("sec_len").asDouble())
	                .expectedAscentTime(properties.get("up_min").asInt())
	                .descentTime(properties.get("down_min").asInt())
	                .build();
	    }//make mountain trail class
	 
	 public List<MountainTrail> getMountainTrailListFromVWorld(int mountainNo, String mountainName, String emdCd) throws IOException {
			String url = "https://api.vworld.kr/req/data";
			
			String urlMountainName = mountainName.split("산")[0] + "산";
			SantaLogger.makeLog("info", "Mn & emdcd :"+  urlMountainName + " " + emdCd);
			url = url + "?service=data&request=GetFeature&data=LT_L_FRSTCLIMB&key=" + vWorldAPIKey + "&domain=http://dearmysanta.site"
	              + "&attrFilter=mntn_nm:like:" +urlMountainName+"|emdCd:=:" + emdCd+"&page=1&size=100&format=json";
			
			RestTemplate restTemplate = new RestTemplate();
	        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
	        
	        SantaLogger.makeLog("info","trail!!:"+ response);
	        ObjectMapper objectMapper = new ObjectMapper();
	        JsonNode rootNode = objectMapper.readTree(response.getBody());
            JsonNode features = rootNode.at("/response/result/featureCollection/features"); // need to use JSONOBJECT

            
            List<MountainTrail> mountainTrails = new ArrayList<>();
	        
            //features.size()
            
            
            SantaLogger.makeLog("info", "trail Exist?!?!?!"  + (features.get(0) == null  ? "No" : "yes"));
            
          
			for (int i = 0; i < features.size(); i++) {
				if (features.get(i) != null) {
					
					MountainTrail mountainTrail = mapJsonToMountainTrail(features.get(i));
					String[] mountainNames = mountainTrail.getMountainName().split("산");
		
					mountainTrail.setCoordinatesUrl(mountainNames[0]+"산" + "" +i);
					
					mountainTrail.setMountainNo(mountainNo);
					mountainTrail.setMountainName(mountainName);

					//
					// upload on objectStorage
					//
					
					
					
					
					
					objectStorageService.uploadListData(mountainTrail.getMountainTrailCoordinates(),
							mountainTrail.getCoordinatesUrl());

					
					
					
					
					mountainTrails.add(mountainTrail);
					SantaLogger.makeLog("info", "info:"+mountainNo + " "+mountainName);
					SantaLogger.makeLog("info", "mountainTrail:" + mountainTrail);
					mountainDao.addMountainTrail(mountainTrail);
				}
			}
            
//            
//            int easy = 0;
//            int normal = 0;
//            int difficult = 0;
//
            for (MountainTrail trail : mountainTrails) {
                SantaLogger.makeLog("info","trail:" + trail);
                
//                if(trail.getMountainTrailDifficulty().equals("하")) {
//                	easy += 1;
//                } else if(trail.getMountainTrailDifficulty().equals("중")) {
//                	normal += 1;
//                }if(trail.getMountainTrailDifficulty().equals("상")) {
//                	difficult += 1;
//                }
            }
//            
//            SantaLogger.makeLog("info","easy, normal, difficult:" + easy + " " + normal + " " + difficult);
			return mountainTrails;
            
		}//get MountainTrail information using mountain Trail api
	 
	 public List<MountainTrail> doAllLogic(int mountainNo, double lat, double lon,String mountainName, String locations) throws IOException{
	 //public void doAllLogic(double lat, double lon,String mountainName) throws JsonMappingException, JsonProcessingException{
		String location = getEmdCodeByCoordinates(lat, lon);
		SantaLogger.makeLog("info","====================================");
		String emdCd =  getRegionCode(location);
		SantaLogger.makeLog("info","====================================");
		
		
		return getMountainTrailListFromVWorld(mountainNo,mountainName, emdCd);
		
	}
	 
	 public Mountain mapJsonToMountain(JSONObject json) {
		 
		 	String mountainName = json.getString("frtrlNm");
		 	
//		 	mountainName = mountainName.split("산")[0]+"산";
		 	
		    SantaLogger.makeLog("info", mountainName);        // Build the Mountain object
	        return Mountain.builder()
	                .mountainNo(json.getInt("frtrlId") + 1000)
	                .mountainName( json.getString("frtrlNm"))
	                .mountainLatitude(json.getDouble("lat"))
	                .mountainLongitude(json.getDouble("lot"))
	                .mountainLocation(json.getString("addrNm"))
	                .mountainAltitude(json.getDouble("aslAltide"))
	                .build();
	    }
	
	public Mountain getMountain(String mountainName) throws Exception{ // for mountain Guide and insert DB

		Mountain mountain = new Mountain();

		
		String url = "http://apis.data.go.kr/B553662/top100FamtListBasiInfoService/getTop100FamtListBasiInfoList?serviceKey="+API_KEY +"&numOfRows=100&pageNo=1";
				//+ "&srchFrtrlNm="
				//+ mountainName;//remove later

		HttpHeaders headers = new HttpHeaders();

		HttpEntity<String> entity = new HttpEntity<>(headers);

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

		SantaLogger.makeLog("info", "response:" + response.getBody());
		
		 XmlMapper xmlMapper = new XmlMapper();
         JsonNode jsonNode = xmlMapper.readTree(response.getBody());

         //
         ObjectMapper jsonMapper = new ObjectMapper();
         String jsonString = jsonMapper.writeValueAsString(jsonNode);

         //
         JSONObject jsonObject = new JSONObject(jsonString);
         SantaLogger.makeLog("info", "jsonObject:" + jsonObject);
         
//         JSONObject body = jsonObject.getJSONObject("body");
         
         JSONObject body = jsonObject.getJSONObject("body");
         JSONObject items = body.getJSONObject("items");
         
         SantaLogger.makeLog("info",items.toString());

         // check item in item isArray
         Object itemObject = items.get("item");
         
         JSONObject item ;
         
         JSONArray jsonArray = new JSONArray();
         
         if(itemObject instanceof JSONObject) {
        	 jsonArray.put((JSONObject) itemObject);
         }else {
        	 jsonArray = (JSONArray) itemObject;
         }

         for (int i = 0; i < jsonArray.length(); i++) {
           item = jsonArray.getJSONObject(i);
           SantaLogger.makeLog("info", "item:" + item);
           mountain = mapJsonToMountain(item);
           
           SantaLogger.makeLog("info","lat, lot:" + mountain.getMountainLatitude() + " " + mountain.getMountainLongitude());
           
           SantaLogger.makeLog("info", "url:"+objectStorageService.dounLoadImageURL(bucketname, mountain.getMountainName()+"사진"));
           mountain.setMountainImage(objectStorageService.dounLoadImageURL(bucketname, mountain.getMountainName()+"사진"));
           
           
           
           
           
           //
           // for test
           //
           //mountain.setMountainImage("testImage");
           mountain.setMountainDescription("test");
           mountain.setMountainTrailCount(0);
           //
           //
           //
           
           
           SantaLogger.makeLog("info","mountain" + mountain);
           
           
           
           
           this.addMountain(mountain);
           

           mountain.setMountainTrail(doAllLogic(mountain.getMountainNo(), mountain.getMountainLatitude(),mountain.getMountainLongitude(), mountain.getMountainName(), mountain.getMountainLocation()));
        	   
           
         }
           
           
//         if (itemObject instanceof JSONArray) {
//             // item- JSONArray
////             item = ((JSONArray)itemObject).getJSONObject(1);
//        	 JSONArray itemArray = (JSONArray) itemObject;
//        	 
//        	 for (int i = 0; i < itemArray.length(); i++) {
//                 item = itemArray.getJSONObject(i);
//                 SantaLogger.makeLog("info", "item:" + item);
//                 double lat =   Double.parseDouble(item.getString("lat"));
//                 double lot = Double.parseDouble(item.getString("lot"));
//                 
//                 SantaLogger.makeLog("info","lat, lot:" + lat + " " + lot);
//                 doAllLogic(lat,lot, mountainName);
//             }
//            
//         } else {
//             // item- JSONObject
//             item = (JSONObject) itemObject;
//             SantaLogger.makeLog("info", "item:" + item);
//             double lat =   Double.parseDouble(item.getString("lat"));
//             double lot = Double.parseDouble(item.getString("lot"));
//             
//             SantaLogger.makeLog("info","lat, lot:" + lat + " " + lot);
//             doAllLogic(lat,lot,mountainName);
//         }
         
         //
         //여기서 확인하고, 있으면 등산로를 돌고, 없으면 돌지말자
         //


		return mountain;
		
	}// name, address, altitude, latitude, longitude
	
	//
	// mountain
	//
	
	//
	// policy!!!
	//
	
	//
	// getMountain  List!!
	//
	
	public void addMountain(Mountain mountain) {
		mountainDao.addMountain(mountain);
	}
	
	public Mountain getMountain(int userNo, int mountainNo) {
		
		Mountain mountain = mountainDao.getMountain(mountainNo);
		mountain.setLikeCount(mountainDao.getTotalMountainLikeCount(mountain.getMountainNo()));
		
		if(userNo != -1) {
			SantaLogger.makeLog("info", "mountainNo & userNo" + mountain.getMountainNo()+ " "+userNo);
			mountain.setIsLiked(mountainDao.isLiked(mountain.getMountainNo(), userNo));
		}
		
		return mountain;
	}
	
	//
	// only trail version
	//
	
	
	public List<Mountain> getMountainListByCoord(double lat, double lon) throws IOException{ // by address 
		String address = this.getEmdCodeByCoordinates(lat, lon).split(" ")[0];
		
		SantaLogger.makeLog("info","address:" + address);
		
		return getMountainListByAddress(address);
		
		//return mountainDao.getMountainListByAddress(address);
		//
		//
		
		//
		//
		//
		
	}
	
	
	public List<Mountain> getMountainListByAddress( String address) throws IOException{ // by address 
		
		
		
		
		List<Mountain> list =  mountainDao.getMountainListByAddress(address);
		
		for(int i = 0; i < list.size();i++) {
			List<MountainTrail> mountainTrail = list.get(i).getMountainTrail();
			
			for(int j = 0; j<mountainTrail.size();j++) {
				mountainTrail.get(j).setMountainTrailCoordinates(objectStorageService.downloadListData(bucketname,list.get(i).getMountainTrail().get(j).getCoordinatesUrl()));
			}
		
		}
		
		
		//
		// need to get from db and get data from object storage
		//
		
		
		return list;
		
	}
	
	public List<Mountain> getMountainListByName(int userNo, String mountainName){
		
		List<Mountain> list = mountainDao.getMountainListByName(mountainName);
		
		
		for(Mountain mountain : list) {

		mountain.setLikeCount(mountainDao.getTotalMountainLikeCount(mountain.getMountainNo()));
		
		if(userNo != -1) {
			SantaLogger.makeLog("info", "mountainNo & userNo" + mountain.getMountainNo()+ " "+userNo);
			mountain.setIsLiked(mountainDao.isLiked(mountain.getMountainNo(), userNo));
		}
		}
		
		return list;
	}
	
	public void updateMountain(Mountain mountain) {
		mountainDao.updateMountain(mountain);
	}
	
	public void updateMountainViewCount(int mountainNo) {
		mountainDao.updateMountainViewCount(mountainNo);
	}
	
	public int checkMountainExist(int mountainNo) {
		return mountainDao.checkMountainExist(mountainNo);
	}
	
	public List<Mountain> getPopularMountainList(List<String> mountainNames,Search search) throws Exception{
		SantaLogger.makeLog("info", "serivceImpl getpopMountain:" + mountainNames.toString());
		List<Mountain> list = new ArrayList<>();
		

		int maxSize = 10;
		for(int i = 0; i <  maxSize  ; i ++) {
			
			Mountain mountain = this.getMountainListByName(search.getUserNo() ,mountainNames.get(i)).get(0);
			mountain.setLikeCount(mountainDao.getTotalMountainLikeCount(mountain.getMountainNo()));
			
			if(search.getUserNo() != -1) {
				SantaLogger.makeLog("info", "mountainNo & userNo" + mountain.getMountainNo()+ " "+search.getUserNo());
				mountain.setIsLiked(mountainDao.isLiked(mountain.getMountainNo(), search.getUserNo()));
			}
			SantaLogger.makeLog("info", "mountainNo & isLiked:" + mountain.getMountainNo() +" " + mountain.getIsLiked());
			list.add(mountain);
		}
		
		return list;
	}//이거 산 이름으로 해야해 ?
	
	public List<Mountain> getCustomMountainList(List<String> statistics, User user){

//		 List<String> orderedMountainNames = statistics.stream()
//	                .map(Statistics::getMountainName)
//	                .collect(Collectors.toList());
//
//		SantaLogger.makeLog("info", "serviceImpl::" + orderedMountainNames.toString());
//		return mountainDao.getCustomMountainList(orderedMountainNames,user);
		SantaLogger.makeLog("info", "serviceImpl::" + statistics.toString());
		List<Mountain> list = mountainDao.getCustomMountainList(statistics,user);
		
		
		int maxSize = 10;
		for(int i = 0; i <  maxSize  ; i ++) {
			Mountain mountain = list.get(i);
			mountain.setLikeCount(mountainDao.getTotalMountainLikeCount(mountain.getMountainNo()));
			
			if(user != null) {
				mountain.setIsLiked(mountainDao.isLiked(mountain.getMountainNo(), user.getUserNo()));
		
			}
		}
		
		return list;
	}

	
	
	public void addMountainTrail(MountainTrail mountainTrail) {
		mountainDao.addMountainTrail(mountainTrail);
	}
	
	
	public int isMountain(String mountainName){
		return mountainDao.isMountain(mountainName);
	}
	//
	//like
	//
	
	public void addMountainLike(Like like) {
		mountainDao.addMountainLike(like);
	}
	
	public void deleteMountainLike(Like like) {
		mountainDao.deleteMountainLike(like);
	}
	
	public int getTotalMountainLikeCount(int mountainNo) {
		return mountainDao.getTotalMountainLikeCount(mountainNo);
	}
	
	public int isLiked(int userNo, int mountainNo) {
		return mountainDao.isLiked(userNo, mountainNo);
	}
	
	public List<Mountain> getMountainLikeList(Search search){
		
		List<Mountain> list = mountainDao.getMountainLikeList(search);
		
		for(Mountain mountain : list) {
			mountain.setLikeCount(mountainDao.getTotalMountainLikeCount(mountain.getMountainNo()));
		}
		return list;
	}
	
	public int getTotalMountainLikeListCount(int userNo) {
		return mountainDao.getTotalMountainLikeListCount(userNo);
	}
	
	//
	// searchKeyword
	//
	
	
	public void addSearchKeyword(MountainSearch mountainSearch) {
		
		if(mountainSearch.getSearchCondition() == 0 & mountainDao.isMountain(mountainSearch.getSearchKeyword()) == 1) {
			SantaLogger.makeLog("info","add mountain statistics");
			this.addMountainStatistics(mountainSearch.getSearchKeyword(),0);
		}
		
		mountainDao.addSearchKeyword(mountainSearch);
	}
	
	public void deleteSearchKeyword(MountainSearch mountainSearch) {
		mountainDao.deleteSearchKeyword(mountainSearch);
	}
	
	public List<MountainSearch> getSearchKeywordList(int userNo){
		return mountainDao.getSearchKeywordList(userNo);
	}
	
	public void updateSearchSetting(int userNo, int settingValue) {
		mountainDao.updateSearchSetting(userNo, settingValue);
	}
	
	
	
	//
	//statistics
	//
	
	public void addMountainStatistics(String mountainName, int which) {
		
		//
		// 0 : search
		// 1 : post
		//

		if(this.checkStatisticsMountainColumnExist(mountainName) == 0 & this.isMountain(mountainName) == 1 ) {
			mountainDao.addMountainStatistics(mountainName);
			SantaLogger.makeLog("info","create mountain statistics column");
		}
			
		mountainDao.updateMountainStatistics(mountainName, which);

		
	};  // need to call in search, addPost 
	
	public int checkStatisticsMountainColumnExist(String mountainName) {
		return mountainDao.checkStatisticsMountainColumnExist(mountainName);
	}
	
	public List<Statistics> getStatisticsWeekly(){  // 0: get normal list, 1: get popular searchKeyword list
		return mountainDao.getStatisticsWeekly(); 
	}

	public List<Statistics> getStatisticsDaily(){
		return mountainDao.getStatisticsDaily();
	}
	
	public List<String> getStatisticsMountainNameList(int which){
		return mountainDao.getStatisticsMountainNameList(which);}
	

}