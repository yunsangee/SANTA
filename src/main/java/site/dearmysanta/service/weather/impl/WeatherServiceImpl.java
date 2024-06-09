package site.dearmysanta.service.weather.impl;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.mountain.CoordinateConverter;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.service.weather.WeatherService;

import java.time.*;
import java.time.format.DateTimeFormatter;

@Service("weatherServiceImpl")
@Transactional()
public class WeatherServiceImpl implements WeatherService{
	
	private String key = "O5Qg2/rYlZbWpeUQO4gLBZewc6BzDHr12/dzYa2yu1lPC1ivHOukhxs6DrSjz9Esti9V5GcOfiX7NQSjJFLvJA==" ;
	private String sunKey = "O5Qg2/rYlZbWpeUQO4gLBZewc6BzDHr12/dzYa2yu1lPC1ivHOukhxs6DrSjz9Esti9V5GcOfiX7NQSjJFLvJA==";
	
	public Weather getWeather(double lat, double lot) throws Exception {
//		
		
		Weather weather = new Weather();
		
		LocalDateTime now = LocalDateTime.now();
		
		String[] givenTimes = {"02:10", "05:10", "08:10", "11:10", "14:10", "17:10", "20:10", "23:10"};

        LocalDateTime closestTime = null;
        long closestTimeDiff = Long.MAX_VALUE;
        for (String givenTime : givenTimes) {

        	LocalDate today = LocalDate.now();
        	LocalTime localTime = LocalTime.parse(givenTime, DateTimeFormatter.ofPattern("HH:mm"));

            // Combine the current date and parsed time into a LocalDateTime object
            LocalDateTime time = LocalDateTime.of(today, localTime);
            SantaLogger.makeLog("info","time:" + time);
            
            if(time.compareTo(now) == 1) {  // if givenTime is later than now
            	continue;
            }

            long diff = Math.abs(Duration.between(now, time).toMillis());

            if (diff < closestTimeDiff) {
                closestTimeDiff = diff;
                closestTime = time;
            }
        }
        
        SantaLogger.makeLog("info","closestTime:" + closestTime);


        // 문자열 형식으로 변환
        String dateString = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String timeString = closestTime.format(DateTimeFormatter.ofPattern("HHmm"));

        // 출력
        SantaLogger.makeLog("info","현재 날짜: " + dateString);
        SantaLogger.makeLog("info","현재 시간: " + timeString);
        
        int[] result = CoordinateConverter.convertLatLonToXY(lat, lot);
        
        System.out.printf("Latitude: %f, Longitude: %f ---> X: %d, Y: %d\n", lat, lot, result[0], result[1]);
        
        String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?ServiceKey="+key+"&pageNo=1&nomOfRows=1000&dataType=JSON"
				+ "&base_date=" + dateString + "&base_time=" + timeString + "&nx="+result[0] + "&ny=" + result[1];
        
        HttpHeaders headers = new HttpHeaders();

		HttpEntity<String> entity = new HttpEntity<>(headers);

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

		SantaLogger.makeLog("info","res:" + response);

		JSONObject responseJson = new JSONObject(response.getBody());
		SantaLogger.makeLog("info",responseJson.toString());
		JSONArray items = responseJson.getJSONObject("response").getJSONObject("body").getJSONObject("items")
				.getJSONArray("item");

		for (int i = 0; i < items.length(); i++) {
			JSONObject item = items.getJSONObject(i);
			String category = item.getString("category");
			switch (category) {
			case "TMP":
				weather.setTemperature(item.getInt("fcstValue"));
				break;
			case "SKY":
				weather.setSkyCondition(String.valueOf(item.getInt("fcstValue")));
				break;
			case "PCP":
				weather.setPrecipitation(item.getString("fcstValue"));
				break;
			case "PTY":
				weather.setPrecipitationType(item.getInt("fcstValue"));
				break;
			case "POP":
				weather.setPrecipitationProbability(item.getDouble("fcstValue"));
				break;
			}
		}
		
        SantaLogger.makeLog("info",weather.toString());
        
        
        String urlStr = "http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getLCRiseSetInfo" + "?ServiceKey=" + key + "&locdate=" + dateString + "&latitude=" + lat + "&longitude=" + lot + "&_type=json";
        
        response = restTemplate.exchange(urlStr, HttpMethod.GET, entity, String.class); 
        responseJson = new JSONObject(response.getBody());
		SantaLogger.makeLog("info",responseJson.toString());
		
		
		JSONObject item = responseJson.getJSONObject("response").getJSONObject("body").getJSONObject("items")
				.getJSONObject("item");

        
        weather.setSunriseTime(item.getString("sunrise"));

        weather.setSunsetTime(item.getString("sunset"));;
        
        weather.setLatitude(lat);
        weather.setLongitude(lot);
        

        SantaLogger.makeLog("info",weather.toString());
      
        
        return weather;
		

		
	}
	
	public List<Weather> getWeatherList(){
		
		List<Weather> forecasts = new ArrayList<>();
		for (int i = 0; i < 5; i++) {
            LocalDate date = LocalDate.now().plusDays(i);
            String dateString = date.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            
            String url = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?ServiceKey=" + key +
                         "&pageNo=1&numOfRows=1000&dataType=JSON" +
                         "&base_date=" + dateString + "&base_time=" + "0200" + "&nx=58&ny=127";
            
            HttpHeaders headers = new HttpHeaders();
            HttpEntity<String> entity = new HttpEntity<>(headers);
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            
            JSONObject responseJson = new JSONObject(response.getBody());
            
            SantaLogger.makeLog("info",responseJson.toString());
            JSONArray items = responseJson.getJSONObject("response").getJSONObject("body").getJSONObject("items").getJSONArray("item");
            
            Weather weather = new Weather();
            for (int j = 0; j < items.length(); j++) {
                JSONObject item = items.getJSONObject(j);
                String category = item.getString("category");
                switch (category) {
                    case "TMP":
                        weather.setTemperature(item.getInt("fcstValue"));
                        break;
                    case "SKY":
                        weather.setSkyCondition(String.valueOf(item.getInt("fcstValue")));
                        break;
                    case "PCP":
                        weather.setPrecipitation(item.getString("fcstValue"));
                        break;
                    case "PTY":
                        weather.setPrecipitationType(item.getInt("fcstValue"));
                        break;
                    case "POP":
                        weather.setPrecipitationProbability(item.getDouble("fcstValue"));
                        break;
                }
            }
            forecasts.add(weather);
        }
        
        // Print the forecasts for verification
        for (Weather forecast : forecasts) {
            SantaLogger.makeLog("info","Temperature: " + forecast.getTemperature());
            SantaLogger.makeLog("info","Sky Condition: " + forecast.getSkyCondition());
            SantaLogger.makeLog("info","Precipitation: " + forecast.getPrecipitation());
            SantaLogger.makeLog("info","Precipitation Type: " + forecast.getPrecipitationType());
            SantaLogger.makeLog("info","Precipitation Probability: " + forecast.getPrecipitationProbability());
        }
		
        return forecasts;
	}
}
