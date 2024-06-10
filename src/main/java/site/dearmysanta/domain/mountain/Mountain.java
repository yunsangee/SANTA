package site.dearmysanta.domain.mountain;

import org.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Arrays;
import java.util.List;

@Getter
@Setter
@Builder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Mountain {
    private int mountainNo; // unique mountain identifier
    private String mountainName; // mountain name
    private double mountainLatitude; // mountain latitude
    private double mountainLongitude; // mountain longitude
    private String mountainLocation; // mountainLocationList.toString();
    private String mountainImage; // mountain image
    private String mountainDescription; // mountain description
    private double mountainAltitude; // mountain altitude
    private int mountainTrailCount; // number of trails
    private int likeCount; // like count
    private int mountainViewCount; // view count
    private int certifiedPostCount; // certified post count
    private int calandarRegisteredCount; // calendar registered count
    private int meetingPostCount; // meeting post count
    private List<String> mountainLocationList;
    private List<MountainTrail> mountainTrail; // list of mountain trails

    
}
