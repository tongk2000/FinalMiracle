package com.miracle.psw.model;

import java.util.HashMap;

public interface InterMemberDAO {

	int loginEnd(HashMap<String, String> map);  // 로그인 여부 알아오기

	MemberVO getLoginMember(String userid);		// 로그인한 사용자 정보 가져오기

	String getUserid(HashMap<String, String> map);  // userid 찾기

	int getUserExists(HashMap<String, String> map); // pwd 찾기

	int updatePwd(HashMap<String, String> map);  // pwd 변경하기

	int idDuplicateCheck(String userid);  // id 중복 체크

	

	

}
