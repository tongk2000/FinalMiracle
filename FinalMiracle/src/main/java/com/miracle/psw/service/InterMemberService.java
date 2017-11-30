package com.miracle.psw.service;

import java.util.HashMap;

import com.miracle.psw.model.MemberVO;

public interface InterMemberService {

	int loginEnd(HashMap<String, String> map);  // 로그인 여부 알아오기

	MemberVO getLoginMember(String userid);  	// 로그인 정보 확인

	String getUserid(HashMap<String, String> map);  // id 찾기

	int getUserExists(HashMap<String, String> map); // pw 찾기

	int updatePwd(HashMap<String, String> map);  // pwd 변경하기

	

	

}
