package site.dearmysanta.domain.meeting;

import site.dearmysanta.domain.common.Post;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.experimental.SuperBuilder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

@SuperBuilder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class MeetingPost extends Post{
	private List<MultipartFile> meetingPostImage;
	private String meetingName;
	private Date recruitmentDeadline;
    private String appointedDeparture;
    private String appointedHikingMountain;
    private Date appointedHikingDate;
    private String participationAge;
    private int maximumPersonnel;
    private int participationGrade;
    private List<Integer> participationUserNos;
    private int registrationStatus;
    private int recruitmentState;
    private int participationGender;

}
