package site.dearmysanta.domain.mountain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import site.dearmysanta.domain.common.Search;

@Getter
@Setter
@Builder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Weather {
	private String skyCondition; //SKY
	private int temperature; // TMN(min) , TMX(max)
	private String sunriseTime;
	private String sunsetTime;
	
	private double latitude;
	private double longitude;
	
	private String precipitation; //PCP
	private int precipitationType; //PTY
	private double precipitationProbability; //POP
	
	private String isHeatWave;
	private String isColdWave;
	
}
