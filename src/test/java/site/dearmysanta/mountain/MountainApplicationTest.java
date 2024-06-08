package site.dearmysanta.mountain;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.SantaApplicationTests;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.correctionPost.CorrectionPost;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.Statistics;
import site.dearmysanta.service.correctionpost.CorrectionPostService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.mountain.impl.MountainServiceImpl;
import site.dearmysanta.service.weather.WeatherService;
import site.dearmysanta.service.weather.impl.WeatherServiceImpl;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@Transactional
//@SpringBootTest(classes = MountainApplicationTest.class)
public class MountainApplicationTest {
	
	@Autowired
	MountainService mountainService;
	
	@Autowired
	CorrectionPostService correctionPostService;
	
	//@Test
	public void apiTest() throws Exception {
		
		MountainSearch mountainSearch = MountainSearch.builder().userNo(1).searchCondition(1).searchKeyword("searchKeyword1").build();
		
		mountainService.addSearchKeyword(mountainSearch);
		
		mountainSearch.setSearchKeyword("searchKeyword2");
		
		mountainService.addSearchKeyword(mountainSearch);
		
		List<MountainSearch> list =  mountainService.getSearchKeywordList(1);
		
		for(int i = 0; i < list.size(); i ++) {
			SantaLogger.makeLog("info", list.get(i).toString());
		}
		
		
		for(int i = 0; i < list.size(); i ++) {
			mountainService.deleteSearchKeyword(list.get(i));
		}
		
		list =  mountainService.getSearchKeywordList(1);
		
		for(int i = 0; i < list.size(); i ++) {
			SantaLogger.makeLog("info", list.get(i).toString());
		}
		
	}
	
	//Test
	public void likeTest() {
		Like like = Like.builder().userNo(1).postNo(1).postLikeType(2).build();
		
//		List<Mountain> list = mountainService.getMountainLikeList(like);
		
		System.out.println(mountainService.getTotalMountainLikeCount(like));
		mountainService.addMountainLike(like);
		System.out.println(mountainService.getTotalMountainLikeCount(like));
		mountainService.deleteMountainLike(like);
		System.out.println(mountainService.getTotalMountainLikeCount(like));
		
		
		
	}
	
//	@Test
	public void mountainApiTest() throws Exception {
		mountainService.getMountain("관악산");
	}
	
//	@Test
	public void getmountainTest() throws Exception{
		List<Mountain> mountain = mountainService.getMountainListByCoord( Double.valueOf(37.4979), Double.valueOf(127.0276));
		
		for(Mountain mt: mountain) {
			System.out.println(mt);
		}
	}
	
	
	@Test
	public void weatherTest() throws Exception {
		WeatherService ws = new WeatherServiceImpl();
		
		ws.getWeather(37.445044, 126.964223); //gangnam
		
//		ws.getWeather(35.192975, 129.093388888888);
//		ws.getWeatherList();
	}
	
	
//	@Test
	public void correctionPostTest() {
		 CorrectionPost correctionPost = CorrectionPost.builder()
		            .userNo(1)
		            .nickName("user123")
		            .profileImage("http://example.com/profile.jpg")
		            .postNo(1001)
		            .title("Correction Needed")
		            .contents("There is a mistake in the trail details.")
		            .mountainNo(1)
		            .mountainName("Mount Everest")
		            .status(0)
		            .build();
		 
		List<CorrectionPost> list = correctionPostService.getCorrectionPostList();
		
		for(CorrectionPost post : list) {
			System.out.println(post);
		}
		 
		 
		correctionPostService.addCorrectionPost(correctionPost);
		
		list = correctionPostService.getCorrectionPostList();
		System.out.println("==================");
		for(CorrectionPost post : list) {
			System.out.println(post);
		}
		
		correctionPostService.deleteCorrectionPost(correctionPost.getUserNo(), list.get(list.size()-1).getPostNo());
	
		list = correctionPostService.getCorrectionPostList();
		System.out.println("==================");
		for(CorrectionPost post : list) {
			System.out.println(post);
		}
		
	}
	
	
//	@Test
	public void statisticsTest() {
		String mountainName = "jirisan";
		
		List<Statistics> list = mountainService.getStatisticsList(0);
		for(Statistics statistics : list) {
			System.out.println(statistics);
		}
		
		mountainService.addMountainStatistics(mountainName, 0);
		mountainService.addMountainStatistics(mountainName, 0);
		mountainService.addMountainStatistics(mountainName, 1);
		
		list = mountainService.getStatisticsList(0);
		for(Statistics statistics : list) {
			System.out.println(statistics);
		}
		
		
	}
	
//	@Test
	public void PopularNCustomMountainTest() {
		List<String> MOUNTAIN_NAMES = Arrays.asList(
		        "jirisan", "hallasan", "seoraksan", "bukhansan", "gayasan",
		        "dobongsan", "charyeongsan", "songnisan", "taebaeksan", "odeasan"
		    );
		
		Random random = new Random();
		
		List<Statistics> list = mountainService.getStatisticsList(1);
		for(Statistics statistics : list) {
			System.out.println(statistics.getMountainName());
		}
		System.out.println("==================================");
		
		for (String mountainName : MOUNTAIN_NAMES) {
            for (int i = 0; i < 50; i++) { // Add statistics three times for each mountain
                int which = random.nextInt(2); // Randomly choose 0 or 1
                mountainService.addMountainStatistics(mountainName, which);
            }
        }
		
		list = mountainService.getStatisticsList(1);
		for(Statistics statistics : list) {
			System.out.println(statistics.getMountainName());
		}
		
		System.out.println("==================================");

	}
	
	
//	@Test
	public void mountainTest() throws IOException {
		Mountain mountain = Mountain.builder()
                .mountainNo(5)
                .mountainName("jirisan")
                .mountainLatitude(35.35)
                .mountainLongitude(127.73)
                .mountainLocation("경상남도, 전라북도")
                .mountainImage("jirisan_image.png")
                .mountainDescription("지리산은 한국의 명산 중 하나입니다.")
                .mountainAltitude(1915.0)
                .mountainTrailCount(5)
                .likeCount(100)
                .build();
		
		 Mountain mountain2 = Mountain.builder()
	                .mountainNo(6)
	                .mountainName("Geumjeongsan")
	                .mountainLatitude(35.2839)
	                .mountainLongitude(129.0563)
	                .mountainLocation("경상남도, 부산광역시")
	                .mountainImage("geumjeongsan_image.png")
	                .mountainDescription("금정산은 경상남도와 부산광역시에 걸쳐 있는 산입니다.")
	                .mountainAltitude(801.5)
	                .mountainTrailCount(8)
	                .likeCount(150)
	                .build();
		 
		 Mountain mountain3 = Mountain.builder()
	                .mountainNo(7)
	                .mountainName("Geumjeongsan")
	                .mountainLatitude(35.2839)
	                .mountainLongitude(129.0563)
	                .mountainLocation("전라북도, 전라남도")
	                .mountainImage("geumjeongsan_image.png")
	                .mountainDescription("금정산은 경상남도와 부산광역시에 걸쳐 있는 산입니다.")
	                .mountainAltitude(801.5)
	                .mountainTrailCount(8)
	                .likeCount(100)
	                .build();

		
		mountainService.addMountain(mountain);
		mountainService.addMountain(mountain2);
		mountainService.addMountain(mountain3);
		System.out.println(mountainService.getMountain(mountain.getMountainNo()));
		System.out.println("=====================");
		
		
		List<Mountain> list = mountainService.getMountainListByAddress("경상남도");
		for(Mountain mt : list) {
			System.out.println(mt);
		}
		System.out.println("=====================");
		
		list = mountainService.getMountainListByName("Geumjeongsan");
		for(Mountain mt : list) {
			System.out.println(mt);
		}
		System.out.println("=====================");
		
		mountain.setMountainTrailCount(77);
		mountainService.updateMountain(mountain);
		System.out.println(mountainService.getMountain(mountain.getMountainNo()));
		System.out.println("=====================");
		
		mountainService.updateMountainViewCount(mountain.getMountainNo());
		System.out.println(mountainService.getMountain(mountain.getMountainNo()));
		System.out.println("=====================");
		
		System.out.println(mountainService.checkMountainExist(mountain.getMountainNo()));
		
		
		
		
	}
	
}
