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
import site.dearmysanta.service.mountain.MountainDao;
import site.dearmysanta.service.mountain.MountainService;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;
import org.json.JSONArray;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;


@Service("mountainServiceImpl")
@Transactional
public class MountainServiceImpl implements MountainService {
	
	@Autowired
	@Qualifier("mountainDao")
	MountainDao mountainDao;
	
	@Value("${naverMapClientID}")
	private String clientId;
	
	@Value("${naverMapSecretKey}")
	private String clientSecret;
	

	private String API_KEY = "O5Qg2/rYlZbWpeUQO4gLBZewc6BzDHr12/dzYa2yu1lPC1ivHOukhxs6DrSjz9Esti9V5GcOfiX7NQSjJFLvJA==";
	
	//
	// mountainName, fix mountainName in mountainTrail class
	//


	public String getEmdCodeByCoordinates(double lat, double lon) throws JsonMappingException, JsonProcessingException {

		SantaLogger.makeLog("info", "getEmdCodeByCoordinates");

		String key = "C5151288-9B85-3B38-86F1-8CFD6D085112";
		String reverseGeocodeUrl = "https://api.vworld.kr/req/address?service=address&request=getAddress&key=" + key
				+ "&domain=http://dearmysanta.site" + "&point=" + lon + "," + lat + "&type=PARCEL";
		
		String location = "";

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> geocodeResponse = restTemplate.getForEntity(reverseGeocodeUrl, String.class);

		JSONObject geocodeJson = new JSONObject(geocodeResponse.getBody());
		if (geocodeJson.has("response") && geocodeJson.getJSONObject("response").has("result")) {
			JSONArray results = geocodeJson.getJSONObject("response").getJSONArray("result");
			System.out.println("results:" + results);
			if (results.length() > 0) {
				JSONObject result = results.getJSONObject(0);
				if (result.has("structure") && result.getJSONObject("structure").has("level4L")) {
					
					location = result.getJSONObject("structure").getString("level1") +" "+ result.getJSONObject("structure").getString("level2") + " " + result.getJSONObject("structure").getString("level4L");
					
					System.out.println("Level4L: " + location);
					
//					getRegionCode(location);
				}
			}
		}
		
		
		return location;

	}//need to emdCd Code to use mountainTrail API. so get do/si/dong address
	
	
	
	 public String getRegionCode(String regionName) throws JsonMappingException, JsonProcessingException {
	        String url = "http://apis.data.go.kr/1741000/StanReginCd/getStanReginCdList"
	                + "?serviceKey=" + "O5Qg2/rYlZbWpeUQO4gLBZewc6BzDHr12/dzYa2yu1lPC1ivHOukhxs6DrSjz9Esti9V5GcOfiX7NQSjJFLvJA=="
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
	        System.out.println(locatjuminCd.substring(0, locatjuminCd.length()-2));
	        
//	        getMountainTrailListFromVWorld(emdCd);
	        return emdCd;
	 }// do/si/dong address to emdCd
	
	 public static MountainTrail mapJsonToMountainTrail(JsonNode feature) {
	        JsonNode properties = feature.get("properties");
	        JsonNode geometry = feature.get("geometry");
	        JsonNode coordinatesArray = geometry.get("coordinates").get(0); // Access the MultiLineString

	        List coordinateList = new ArrayList();
	        for (JsonNode coord : coordinatesArray) {
	            double longitude = coord.get(0).asDouble();
	            double latitude = coord.get(1).asDouble();
	            
//	            System.out.println("!!::" + latitude + " " + longitude);
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
	 
	 public List<MountainTrail> getMountainTrailListFromVWorld(String mountainName, String emdCd) throws JsonMappingException, JsonProcessingException {
			String url = "https://api.vworld.kr/req/data";
			String key = "C5151288-9B85-3B38-86F1-8CFD6D085112";
			
			url = url + "?service=data&request=GetFeature&data=LT_L_FRSTCLIMB&key=" + key + "&domain=http://dearmysanta.site"
	              + "&attrFilter=mntn_nm:like:" +mountainName+"|emdCd:=:" + emdCd+"&page=1&size=100&format=json";
			
			RestTemplate restTemplate = new RestTemplate();
	        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
	        
//	        System.out.println("trail!!:"+ response);
	        ObjectMapper objectMapper = new ObjectMapper();
	        JsonNode rootNode = objectMapper.readTree(response.getBody());
            JsonNode features = rootNode.at("/response/result/featureCollection/features"); // need to use JSONOBJECT

            List<MountainTrail> mountainTrails = new ArrayList<>();
	        
            for (JsonNode feature : features) {
                MountainTrail mountainTrail = mapJsonToMountainTrail(feature);
                mountainTrails.add(mountainTrail);
            }
//            
//            int easy = 0;
//            int normal = 0;
//            int difficult = 0;
//
//            for (MountainTrail trail : mountainTrails) {
//                System.out.println(trail);
//                
//                if(trail.getMountainTrailDifficulty().equals("하")) {
//                	easy += 1;
//                } else if(trail.getMountainTrailDifficulty().equals("중")) {
//                	normal += 1;
//                }if(trail.getMountainTrailDifficulty().equals("상")) {
//                	difficult += 1;
//                }
//            }
//            
//            System.out.println("easy, normal, difficult:" + easy + " " + normal + " " + difficult);
			return mountainTrails;
            
		}//get MountainTrail information using mountain Trail api
	 
	 public List<MountainTrail> doAllLogic(double lat, double lon,String mountainName) throws JsonMappingException, JsonProcessingException{
	 //public void doAllLogic(double lat, double lon,String mountainName) throws JsonMappingException, JsonProcessingException{
		String location = getEmdCodeByCoordinates(lat, lon);
		System.out.println("====================================");
		String emdCd =  getRegionCode(location);
		System.out.println("====================================");
		
		return getMountainTrailListFromVWorld(mountainName, emdCd);
		
	}
	 
	 public Mountain mapJsonToMountain(JSONObject json) {
	        // Build the Mountain object
	        return Mountain.builder()
	                .mountainNo(json.getInt("mtnCd"))
	                .mountainName(json.getString("frtrlNm"))
	                .mountainLatitude(json.getDouble("lat"))
	                .mountainLongitude(json.getDouble("lot"))
	                .mountainLocation(json.getString("addrNm"))
	                .mountainAltitude(json.getDouble("aslAltide"))
	                .build();
	    }
	
	public Mountain getMountain(String mountainName) throws Exception{ // for mountain Guide and insert DB

		Mountain mountain = new Mountain();

		
		String url = "http://apis.data.go.kr/B553662/top100FamtListBasiInfoService/getTop100FamtListBasiInfoList?serviceKey="+API_KEY +"&numOfRows=100&pageNo=1"
				+ "&srchFrtrlNm="
				+ mountainName;//remove later

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
         
         System.out.println(items);

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
           
           if(mountainDao.checkMountainExist(mountain.getMountainNo()) == 0) {
        	   mountain.setMountainTrail(doAllLogic(mountain.getMountainLatitude(),mountain.getMountainLongitude(), mountainName));
        	   
        	   //
        	   //DB에 ADD
        	   //
           }else {
        	   
           }
           
           
           
           
           
           //
           // 일단 MountainClass에 Mapping & return list
           //
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
	
	public Mountain getMountain(int mountainNo) {
		return mountainDao.getMountain(mountainNo);
	}
	
	
	public List<Mountain> getMountainListByAddress(String address){ // by address 
		return mountainDao.getMountainListByAddress(address);
		
	}
	
	public List<Mountain> getMountainListByName(String mountainName){
		return mountainDao.getMountainListByName(mountainName);
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
	
	public List<Mountain> getPopularMountainList(List<String> mountainNames) throws Exception{
		List<Mountain> list = new ArrayList<>();
		for(String mountainName : mountainNames) {
			list.add(this.getMountain(mountainName));
		}
		
		return list;
	}//이거 산 이름으로 해야해 ?
	
	public List<Mountain> getCustomMountainList(User user){
		return mountainDao.getCustomMountainList(user);
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
	
	public int getTotalMountainLikeCount(Like like) {
		return mountainDao.getTotalMountainLikeCount(like);
	}
	
	public List<Mountain> getMountainLikeList(Like like){
		return mountainDao.getMountainLikeList(like);
	}
	
	//
	// searchKeyword
	//
	
	
	public void addSearchKeyword(MountainSearch mountainSearch) {
		
		if(mountainSearch.getSearchCondition() == 0) {
			System.out.println("add mountain statistics");
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

		if(this.checkStatisticsMountainColumnExist(mountainName) == 0) {
			mountainDao.addMountainStatistics(mountainName);
			System.out.println("create mountain statistics column");
		}
			
		mountainDao.updateMountainStatistics(mountainName, which);

		
	};  // need to call in search, addPost 
	
	public int checkStatisticsMountainColumnExist(String mountainName) {
		return mountainDao.checkStatisticsMountainColumnExist(mountainName);
	}
	
	public List<Statistics> getStatisticsList(int which){  // 0: get normal list, 1: get popular searchKeyword list
		return mountainDao.getStatisticsList(which); 
	}
	

}