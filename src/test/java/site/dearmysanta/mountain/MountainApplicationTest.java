package site.dearmysanta.mountain;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

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
	
	//@Test
	public void mountainTest() throws Exception {
		mountainService.getMountain("관악산");
	}
	
	//@Test
	public void weatherTest() throws Exception {
		WeatherService ws = new WeatherServiceImpl();
		
//		ws.getWeather(37.445044, 126.964223);
		ws.getWeatherList();
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
	
	
	@Test
	public void statisticsTest() {
		String mountainName = "jirisan";
		
		List<Statistics> list = mountainService.getStatisticsList();
		for(Statistics statistics : list) {
			System.out.println(statistics);
		}
		
		mountainService.addMountainStatistics(mountainName, 0);
		mountainService.addMountainStatistics(mountainName, 0);
		mountainService.addMountainStatistics(mountainName, 1);
		
		list = mountainService.getStatisticsList();
		for(Statistics statistics : list) {
			System.out.println(statistics);
		}
		
		
	}

}
