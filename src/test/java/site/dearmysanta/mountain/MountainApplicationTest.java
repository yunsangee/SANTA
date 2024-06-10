package site.dearmysanta.mountain;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.stream.IntStream;

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
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.correctionPost.CorrectionPost;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.Statistics;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.domain.user.User;
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
	
	@Autowired
	WeatherService weatherService;
	
	//@Test
	public void apiTest() throws Exception {
		
		MountainSearch mountainSearch = MountainSearch.builder().userNo(1).searchCondition(1).searchKeyword("searchKeyword1").build();
		
		mountainService.addSearchKeyword(mountainSearch);
		
		mountainSearch.setSearchKeyword("searchKeyword2");
		
		mountainService.addSearchKeyword(mountainSearch);
//		
//		List<MountainSearch> list =  mountainService.getSearchKeywordList(1,search);
//		
//		for(int i = 0; i < list.size(); i ++) {
//			SantaLogger.makeLog("info", list.get(i).toString());
//		}
//		
//		
//		for(int i = 0; i < list.size(); i ++) {
//			mountainService.deleteSearchKeyword(list.get(i));
//		}
		
//		list =  mountainService.getSearchKeywordList(1);
		
//		for(int i = 0; i < list.size(); i ++) {
//			SantaLogger.makeLog("info", list.get(i).toString());
//		}
		
	}
	
	//Test
	public void likeTest() {
		Like like = Like.builder().userNo(1).postNo(1).postLikeType(2).build();
		
//		List<Mountain> list = mountainService.getMountainLikeList(like);
		
		SantaLogger.makeLog("info",""+mountainService.getTotalMountainLikeCount(like));
		mountainService.addMountainLike(like);
		SantaLogger.makeLog("info",""+mountainService.getTotalMountainLikeCount(like));
		mountainService.deleteMountainLike(like);
		SantaLogger.makeLog("info",""+mountainService.getTotalMountainLikeCount(like));
		
		
		
	}
	
	@Test
	public void mountainApiTest() throws Exception {
		mountainService.getMountain("북한산");
	}
	
//	@Test
	public void getmountainTest() throws Exception{
		List<Mountain> mountain = mountainService.getMountainListByCoord( Double.valueOf(37.4979), Double.valueOf(127.0276));
		
		for(Mountain mt: mountain) {
			SantaLogger.makeLog("info",mt.toString());
		}
	}
	
	
	@Test
	public void weatherTest() throws Exception {
//		WeatherService ws = new WeatherServiceImpl();
		
		List<Weather> list= weatherService.getWeatherList(37.445044, 126.964223); //gangnam
		
		for(Weather weather : list) {
			SantaLogger.makeLog("info", weather.toString());
		}
		
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
			SantaLogger.makeLog("info",post.toString());
		}
		 
		 
		correctionPostService.addCorrectionPost(correctionPost);
		
		list = correctionPostService.getCorrectionPostList();
		SantaLogger.makeLog("info","==================");
		for(CorrectionPost post : list) {
			SantaLogger.makeLog("info",post.toString());
		}
		
		correctionPostService.deleteCorrectionPost(correctionPost.getUserNo(), list.get(list.size()-1).getPostNo());
	
		list = correctionPostService.getCorrectionPostList();
		SantaLogger.makeLog("info","==================");
		for(CorrectionPost post : list) {
			SantaLogger.makeLog("info",post.toString());
		}
		
	}
	
	
//	@Test
	public void statisticsTest() {
//		String mountainName = "jirisan";
		
		List<Statistics> list = mountainService.getStatisticsList(0);
		for(Statistics statistics : list) {
			SantaLogger.makeLog("info",statistics.toString());
		}
		
//		mountainService.addMountainStatistics(mountainName, 0);
//		mountainService.addMountainStatistics(mountainName, 0);
//		mountainService.addMountainStatistics(mountainName, 1);
		
		list = mountainService.getStatisticsList(1);
		for(Statistics statistics : list) {
			SantaLogger.makeLog("info",statistics.toString());
		}
//		
//		list = mountainService.getStatisticsList(1);
//		for(Statistics statistics : list) {
//			SantaLogger.makeLog("info",statistics.toString());
//		}
//		
		
		SantaLogger.makeLog("info", "==========");
		User user = User.builder().address("경상남도 울산시").hikingDifficulty(0).build();
		
		user.setAddress(user.getAddress().split(" ")[0]);
		
		List<Mountain> lm = mountainService.getCustomMountainList(list,user);
		
		for(Mountain mt : lm) {
			SantaLogger.makeLog("info",mt.toString());
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
			SantaLogger.makeLog("info",statistics.getMountainName());
		}
		SantaLogger.makeLog("info","==================================");
		
		for (String mountainName : MOUNTAIN_NAMES) {
            for (int i = 0; i < 50; i++) { // Add statistics three times for each mountain
                int which = random.nextInt(2); // Randomly choose 0 or 1
                mountainService.addMountainStatistics(mountainName, which);
            }
        }
		
		list = mountainService.getStatisticsList(1);
		for(Statistics statistics : list) {
			SantaLogger.makeLog("info",statistics.getMountainName());
		}
		
		SantaLogger.makeLog("info","==================================");

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
		SantaLogger.makeLog("info",mountainService.getMountain(mountain.getMountainNo()).toString());
		SantaLogger.makeLog("info","=====================");
		
		
		List<Mountain> list = mountainService.getMountainListByAddress("경상남도");
		for(Mountain mt : list) {
			SantaLogger.makeLog("info",mt.toString());
		}
		SantaLogger.makeLog("info","=====================");
		
		list = mountainService.getMountainListByName("Geumjeongsan");
		for(Mountain mt : list) {
			SantaLogger.makeLog("info",mt.toString());
		}
		SantaLogger.makeLog("info","=====================");
		
		mountain.setMountainTrailCount(77);
		mountainService.updateMountain(mountain);
		SantaLogger.makeLog("info",mountainService.getMountain(mountain.getMountainNo()).toString());
		SantaLogger.makeLog("info","=====================");
		
		mountainService.updateMountainViewCount(mountain.getMountainNo());
		SantaLogger.makeLog("info",mountainService.getMountain(mountain.getMountainNo()).toString());
		SantaLogger.makeLog("info","=====================");
		
		SantaLogger.makeLog("info",""+mountainService.checkMountainExist(mountain.getMountainNo()));
		
		
		
		
	}
	
	
//	@Test
	public void listSearchTest() {
		
//		mountainService.addMountain(Mountain.builder()
//                .mountainNo(5)
//                .mountainName("Taebaeksan")
//                .mountainLatitude(37.1022)
//                .mountainLongitude(128.9854)
//                .mountainLocation("강원도")
//                .mountainImage("taebaeksan_image.png")
//                .mountainDescription("태백산은 한국의 대표적인 산 중 하나입니다.")
//                .mountainAltitude(1566.7)
//                .mountainTrailCount(4)
//                .likeCount(150)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(6)
//                .mountainName("Juwangsan")
//                .mountainLatitude(36.3639)
//                .mountainLongitude(129.2131)
//                .mountainLocation("경상북도")
//                .mountainImage("juwangsan_image.png")
//                .mountainDescription("주왕산은 기암괴석으로 유명한 산입니다.")
//                .mountainAltitude(721.0)
//                .mountainTrailCount(5)
//                .likeCount(250)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(7)
//                .mountainName("Songnisan")
//                .mountainLatitude(36.5359)
//                .mountainLongitude(127.8299)
//                .mountainLocation("충청북도")
//                .mountainImage("songnisan_image.png")
//                .mountainDescription("속리산은 충북에 위치한 산입니다.")
//                .mountainAltitude(1058.4)
//                .mountainTrailCount(3)
//                .likeCount(180)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(8)
//                .mountainName("Gyeryongsan")
//                .mountainLatitude(36.3462)
//                .mountainLongitude(127.2494)
//                .mountainLocation("충청남도")
//                .mountainImage("gyeryongsan_image.png")
//                .mountainDescription("계룡산은 신령스러운 산으로 알려져 있습니다.")
//                .mountainAltitude(845.1)
//                .mountainTrailCount(5)
//                .likeCount(220)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(9)
//                .mountainName("Daedunsan")
//                .mountainLatitude(36.2783)
//                .mountainLongitude(127.4061)
//                .mountainLocation("충청남도")
//                .mountainImage("daedunsan_image.png")
//                .mountainDescription("대둔산은 케이블카로 유명한 산입니다.")
//                .mountainAltitude(878.4)
//                .mountainTrailCount(4)
//                .likeCount(210)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(10)
//                .mountainName("Gyejoksan")
//                .mountainLatitude(36.3994)
//                .mountainLongitude(127.3925)
//                .mountainLocation("대전광역시")
//                .mountainImage("gyejoksan_image.png")
//                .mountainDescription("계족산은 대전의 대표적인 산입니다.")
//                .mountainAltitude(429.0)
//                .mountainTrailCount(3)
//                .likeCount(170)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(11)
//                .mountainName("Sobaeksan")
//                .mountainLatitude(36.8956)
//                .mountainLongitude(128.4358)
//                .mountainLocation("충청북도, 경상북도")
//                .mountainImage("sobaeksan_image.png")
//                .mountainDescription("소백산은 한국의 대표적인 명산 중 하나입니다.")
//                .mountainAltitude(1439.5)
//                .mountainTrailCount(6)
//                .likeCount(300)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(12)
//                .mountainName("Naejangsan")
//                .mountainLatitude(35.4978)
//                .mountainLongitude(126.9319)
//                .mountainLocation("전라북도")
//                .mountainImage("naejangsan_image.png")
//                .mountainDescription("내장산은 단풍으로 유명한 산입니다.")
//                .mountainAltitude(763.5)
//                .mountainTrailCount(5)
//                .likeCount(240)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(13)
//                .mountainName("Wolchulsan")
//                .mountainLatitude(34.7643)
//                .mountainLongitude(126.7056)
//                .mountainLocation("전라남도")
//                .mountainImage("wolchulsan_image.png")
//                .mountainDescription("월출산은 바위로 유명한 산입니다.")
//                .mountainAltitude(809.0)
//                .mountainTrailCount(4)
//                .likeCount(230)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(14)
//                .mountainName("Deogyusan")
//                .mountainLatitude(35.8683)
//                .mountainLongitude(127.7542)
//                .mountainLocation("전라북도, 경상남도")
//                .mountainImage("deogyusan_image.png")
//                .mountainDescription("덕유산은 겨울철 눈꽃으로 유명한 산입니다.")
//                .mountainAltitude(1614.0)
//                .mountainTrailCount(6)
//                .likeCount(270)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(15)
//                .mountainName("Juwangsan")
//                .mountainLatitude(36.3873)
//                .mountainLongitude(129.2221)
//                .mountainLocation("경상북도")
//                .mountainImage("juwangsan_image.png")
//                .mountainDescription("주왕산은 주왕굴로 유명한 산입니다.")
//                .mountainAltitude(720.6)
//                .mountainTrailCount(5)
//                .likeCount(220)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(16)
//                .mountainName("Hwangmaesan")
//                .mountainLatitude(35.4803)
//                .mountainLongitude(127.8331)
//                .mountainLocation("경상남도")
//                .mountainImage("hwangmaesan_image.png")
//                .mountainDescription("황매산은 철쭉으로 유명한 산입니다.")
//                .mountainAltitude(1108.4)
//                .mountainTrailCount(4)
//                .likeCount(190)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(17)
//                .mountainName("Sangwonsan")
//                .mountainLatitude(35.2135)
//                .mountainLongitude(128.3539)
//                .mountainLocation("경상남도")
//                .mountainImage("sangwonsan_image.png")
//                .mountainDescription("상원산은 상원사로 유명한 산입니다.")
//                .mountainAltitude(960.0)
//                .mountainTrailCount(3)
//                .likeCount(180)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(18)
//                .mountainName("Gayasan")
//                .mountainLatitude(35.8028)
//                .mountainLongitude(128.0933)
//                .mountainLocation("경상북도, 경상남도")
//                .mountainImage("gayasan_image.png")
//                .mountainDescription("가야산은 합천해인사로 유명한 산입니다.")
//                .mountainAltitude(1433.0)
//                .mountainTrailCount(5)
//                .likeCount(260)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(19)
//                .mountainName("Gariwangsan")
//                .mountainLatitude(37.6486)
//                .mountainLongitude(128.4932)
//                .mountainLocation("강원도")
//                .mountainImage("gariwangsan_image.png")
//                .mountainDescription("가리왕산은 동계올림픽 경기장으로 유명한 산입니다.")
//                .mountainAltitude(1561.0)
//                .mountainTrailCount(3)
//                .likeCount(170)
//                .build());
//
//        mountainService.addMountain(Mountain.builder()
//                .mountainNo(20)
//                .mountainName("Jirisan")
//                .mountainLatitude(35.3172)
//                .mountainLongitude(127.7300)
//                .mountainLocation("경상남도, 전라북도")
//                .mountainImage("jirisan_image.png")
//                .mountainDescription("지리산은 한국의 명산 중 하나입니다.")
//                .mountainAltitude(1915.0)
//                .mountainTrailCount(5)
//                .likeCount(100)
//                .build());
//        
//        IntStream.rangeClosed(5, 20).forEach(postNo -> {
//            Like like = Like.builder()
//                    .userNo(1)
//                    .postNo(postNo)
//                    .postLikeType(2)
//                    .build();
//            
//            mountainService.addMountainLike(like);
//        });
		
//		IntStream.rangeClosed(1, 20).forEach(i -> {
//            String searchKeyword = "searchKeyword" + i;
//            MountainSearch mountainSearch = MountainSearch.builder()
//                    .userNo(1)
//                    .searchCondition(1)
//                    .searchKeyword(searchKeyword)
//                    .build();
//
//            mountainService.addSearchKeyword(mountainSearch);
//        });
		
		Search search = Search.builder().currentPage(2).pageSize(5).pageUnit(3).build();
		
		Like like =Like.builder().userNo(1).build();
		
		List<Mountain> list = mountainService.getMountainLikeList(like,search);
		for(int i = 0; i < list.size(); i ++) {
			SantaLogger.makeLog("info", list.get(i).toString());
		}
		
		SantaLogger.makeLog("info","=========");
		
		List<MountainSearch> list2 = mountainService.getSearchKeywordList(1,search);
		
		for(int i = 0; i < list.size(); i ++) {
			SantaLogger.makeLog("info", list2.get(i).toString());
		}
		
	}
	
}
