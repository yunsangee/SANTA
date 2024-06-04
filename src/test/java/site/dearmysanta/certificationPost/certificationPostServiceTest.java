package site.dearmysanta.certificationPost;

import java.util.Arrays;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.service.certification.CertificationPostService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
public class certificationPostServiceTest {

    @Autowired
    private CertificationPostService certificationPostService;

    @Test
    public void TestaddCertificationPost() throws Exception {
        // CertificationPost ��ü�� �����մϴ�.
        CertificationPost certificationPost = CertificationPost.builder()
            .userNo(1)
            .title("Certification Post")
            .contents("This is a certification post.")
            .certificationPostMountainName("Everest")
            .certificationPostHikingTrail("Base Camp")
            .certificationPostTotalTime("4:30")
            .certificationPostAscentTime("2:00")
            .certificationPostDescentTime("2:30")
            .certificationPostHikingDate("2024-06-01")
            .certificationPostTransportation(1)
            .certificationPostHikingDifficulty(1)
            .certificationPostHashtag(Arrays.asList("hiking", "adventure"))
            .build();

        // CertificationPostService�� ����Ͽ� �Խñ��� �����ͺ��̽��� �߰��մϴ�.
        certificationPostService.addCertificationPost(certificationPost);

        // SantaLogger�� ����Ͽ� �α׸� ����մϴ�.
        SantaLogger.makeLog("info", certificationPost.toString());
    }
}
