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
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.mountain.impl.MountainServiceImpl;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@SpringBootTest(classes = MountainApplicationTest.class)
public class MountainApplicationTest {
	
	@Autowired
	MountainService mountainService;
	
	@Test
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
	

}
