package site.dearmysanta.service.user.impl;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.service.user.KakaoService;

@Service("kakaoServiceImpl")
@Transactional

public class KakaoServiceImpl implements KakaoService {

	@Override
	public void KakaoUser() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getId(String id) throws Exception {
		// TODO Auto-generated method stub
		return id;
	}

	@Override
	public String getConnected_at(String connected_at) throws Exception {
		// TODO Auto-generated method stub
		return connected_at;
	}

	@Override
	public Map<String, String> getProperties(Map<String, String> properties) throws Exception {
		// TODO Auto-generated method stub
		return properties;
	}

	@Override
	public Map<String, Object> getKakao_account(Map<String, Object> kakao_account) throws Exception {
		// TODO Auto-generated method stub
		return kakao_account;
	}

	@Override
	public void setId(String id) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setConnected_at(String connected_at) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setProperties(Map<String, String> properties) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void setKakao_account(Map<String, Object> kakao_account) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
