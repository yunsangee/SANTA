package site.dearmysanta.domain.certificationPost;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;

import site.dearmysanta.domain.common.Post;

@Getter
@Setter
@SuperBuilder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class CertificationPost extends Post {

    private  int certificationPostImage;
      
    //private int certificationPostNo;
  
    private String certificationPostMountainName;
    private int certificationPostHikingDifficulty;
    private String certificationPostHikingTrail;
    private String certificationPostHikingDate;
    private int certificationPostTransportation;
    
    private String certificationPostHashtagContents;

    
    
    private String certificationPostTotalTime;
    private String certificationPostDescentTime;
    private String certificationPostAscentTime;

    private int certificationPostDeletedFlag;
    private int certificationPostLikeCount;
    private List<CertificationPostComment> commentList; 
    
}
