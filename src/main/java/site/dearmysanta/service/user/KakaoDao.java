package site.dearmysanta.service.user;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Mapper
@Component("kakaoDao")

public interface KakaoDao {

	public void KakaoUser() throws Exception; 

	public String getId(String id) throws Exception;

	public String getConnected_at(String connected_at) throws Exception;

	public Map<String, String> getProperties(Map<String, String> properties) throws Exception;

	public Map<String, Object> getKakao_account(Map<String, Object> kakao_account) throws Exception;

	public void setId(String id) throws Exception;

	public void setConnected_at(String connected_at) throws Exception;

	public void setProperties(Map<String, String> properties) throws Exception;

	public void setKakao_account(Map<String, Object> kakao_account) throws Exception;
		
}
