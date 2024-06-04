package site.dearmysanta.domain.hikingguide;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.Weather;
import lombok.AllArgsConstructor;
import lombok.Builder;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class HikingGuide {
    private int hrNo; // hikingRecord Number
    private int userNo; // user Number
    private int mountainTrailNo; // mountainTrail Number
    private int userDistance; // user move distance
    private int ascentTime; // ascent time
    private int descentTime; // descent time
    private String totalTime; // ascent time + descent time + other time
    private Date hikingDate; // sysdate
    private String alertContent;// alert contents
    private double userLatitude;// userlatitude
    private double userLongitude;// user longtitude
    private Mountain mountain; // (mountain class)
    private Weather weather; // (weather class)
    private MeetingPost meetingpost; // (meeting class)
}




