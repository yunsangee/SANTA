package site.dearmysanta.service.weather;

import java.util.List;

import site.dearmysanta.domain.mountain.Weather;

public interface WeatherService {
	
	public Weather getWeather(double lat, double lot) throws Exception;
	
	public List<Weather> getWeatherList();

}
