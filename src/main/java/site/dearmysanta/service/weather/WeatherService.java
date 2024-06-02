package site.dearmysanta.service.weather;

import java.util.List;

import site.dearmysanta.domain.mountain.Weather;

public interface WeatherService {
	
	public Weather getWeather();
	
	public List<Weather> getWeatherList();

}
