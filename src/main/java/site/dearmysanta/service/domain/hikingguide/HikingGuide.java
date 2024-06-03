package site.dearmysanta.service.domain.hikingguide;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Builder;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class HikingGuide {
    private int hrNo; //
    private int userNo; // 
    private int hikingRecordNo; // 
    private int mountainTrailNo; // 
    private int userDistance; // 
    private int ascentTime; // 
    private int descentTime; // 
    private int totalTime; // 
    private Date hikingDate; // 
    private List<String> userCoordinates; //
//    private Mountain mountain; // (mountain class)
//    private Weather weather; // (weather class)
//    private MeetingPost meetingpost; // (meeting class)
}


