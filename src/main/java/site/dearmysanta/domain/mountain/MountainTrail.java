package site.dearmysanta.domain.mountain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MountainTrail {
	
	private int mountainTrailNo;
	private int mountainNo;
	private String mountainName;
	private String coordinatesUrl; // trail_coordinate_url
	private List<List<Double>> mountainTrailCoordinates;
	
	private String mountainTrailDifficulty;
	private double mountainTrailLength;
	
	private int expectedAscentTime;
	private int descentTime;
	
	private String isClosed;

}
