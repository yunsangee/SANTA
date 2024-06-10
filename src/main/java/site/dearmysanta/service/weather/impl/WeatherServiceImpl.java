package site.dearmysanta.service.weather.impl;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
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

@Service
@Transactional
public class WeatherServiceImpl implements WeatherService{
	
	@Value("${mountainAPIKey}")
	private String key;
	
	@Value("${openWeatherAPIKey}")
	private String weatherKey;
	
	public String getClosestTime(String[] givenTimes,int type){
		LocalDateTime now = LocalDateTime.now();
		LocalDateTime closestTime = null;
        long closestTimeDiff = Long.MAX_VALUE;
        for (String givenTime : givenTimes) {

        	LocalDate today = LocalDate.now();
        	LocalTime localTime = LocalTime.parse(givenTime, DateTimeFormatter.ofPattern("HH:mm"));

            // Combine the current date and parsed time into a LocalDateTime object
            LocalDateTime time = LocalDateTime.of(today, localTime);
//            SantaLogger.makeLog("info","time:" + time);
            
            if(time.compareTo(now) == 1) {  // if givenTime is later than now
            	continue;
            }

            long diff = Math.abs(Duration.between(now, time).toMillis());

            if (diff < closestTimeDiff) {
                closestTimeDiff = diff;
                closestTime = time;
            }
        }
        
//        SantaLogger.makeLog("info","closestTime:" + closestTime);

        if(type == 1) {
        	return closestTime.format(DateTimeFormatter.ofPattern("HH:mm"));
        }

        // 문자열 형식으로 변환
        String dateString = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String timeString = closestTime.format(DateTimeFormatter.ofPattern("HHmm"));

        // 출력
//        SantaLogger.makeLog("info","현재 날짜: " + dateString);
//        SantaLogger.makeLog("info","현재 시간: " + timeString);
        
        return timeString;
	}
	
	public Weather getWeather(double lat, double lot) throws Exception {
//		
		
		Weather weather = new Weather();
		
		LocalDateTime now = LocalDateTime.now();
		
		String[] givenTimes = {"02:10", "05:10", "08:10", "11:10", "14:10", "17:10", "20:10", "23:10"};

        


        // 문자열 형식으로 변환
        String dateString = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String timeString = this.getClosestTime(givenTimes,0);

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
	
	public List<Weather> getWeatherList(double lat, double lon) {
		
		//List<Weather> weatherList = new ArrayList<>();

        //String url = "https://api.openweathermap.org/data/2.5/forecast" + "?lat=" + lat + "&lon=" + lon + "&lang=kr&units=metric&appid=" +weatherKey;

        
//		SantaLogger.makeLog("info", weatherKey);       
		
		String[] givenTimes = {"00:00",
        		"03:00",
        		"06:00",
        		"09:00",
        		"12:00",
        		"15:00",
        		"18:00",
        		"21:00"};
        
        String timeString = this.getClosestTime(givenTimes,1);
        				
       
        
        
        List<Weather> weatherList = new ArrayList<>();

        String url = "https://api.openweathermap.org/data/3.0/onecall" + "?lat=" + lat + "&lon=" + lon + "&exclude=minutely,hourly&lang=kr&units=metric&appid=" + weatherKey;

        HttpHeaders headers = new HttpHeaders();
        HttpEntity<String> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        JSONObject jsonObject = new JSONObject(response.getBody());
        JSONArray dailyArray = jsonObject.getJSONArray("daily");

        for (int i = 0; i < dailyArray.length(); i++) {
            JSONObject dailyObject = dailyArray.getJSONObject(i);
            Weather weather = new Weather();
            
            long dateUnix = dailyObject.getLong("dt");
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MM/dd");
            LocalDateTime dateDateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(dateUnix), ZoneId.systemDefault());
            weather.setDate(dateDateTime.format(dateFormatter));

            // 온도 데이터 추출
            JSONObject temp = dailyObject.getJSONObject("temp");
            weather.setTemperature(temp.getInt("day"));

            List<Integer> minMaxTemp = new ArrayList<>();
            minMaxTemp.add(temp.getInt("min"));
            minMaxTemp.add(temp.getInt("max"));
            minMaxTemp.add(temp.getInt("morn"));
            weather.setMinMaxTemperature(minMaxTemp);

            // 하늘 상태 추출
            JSONArray weatherArray = dailyObject.getJSONArray("weather");
            if (weatherArray.length() > 0) {
                weather.setSkyCondition(weatherArray.getJSONObject(0).getString("description"));
            }

            // 일출, 일몰 시간 설정
            long sunriseUnix = dailyObject.getLong("sunrise");
            long sunsetUnix = dailyObject.getLong("sunset");

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalDateTime sunriseDateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(sunriseUnix), ZoneId.systemDefault());
            LocalDateTime sunsetDateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(sunsetUnix), ZoneId.systemDefault());

            weather.setSunriseTime(sunriseDateTime.format(formatter));
            weather.setSunsetTime(sunsetDateTime.format(formatter));

            // 위도와 경도 설정
            weather.setLatitude(lat);
            weather.setLongitude(lon);

            // 강수 데이터 추출
            if (dailyObject.has("rain")) {
                weather.setPrecipitation(dailyObject.getDouble("rain") + " mm");
            }
            if (dailyObject.has("pop")) {
                weather.setPrecipitationProbability(dailyObject.getDouble("pop") * 100); // 퍼센트로 변환
            }

            String description = weather.getSkyCondition().toLowerCase();
            if (description.contains("rain")) {
                weather.setPrecipitationType(1);
            } else if (description.contains("snow")) {
                weather.setPrecipitationType(3);
            } else if (description.contains("shower")) {
                weather.setPrecipitationType(4);
            } else {
                weather.setPrecipitationType(0);
            }

            weatherList.add(weather);
        }

        return weatherList;
    }
    
   
}
