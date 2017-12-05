package com.miracle.psw.model;

import java.util.HashMap;

public interface InterMemberDAO {

	int loginEnd(HashMap<String, String> map);  // 로그인 여부 알아오기

	MemberVO getLoginMember(String userid);		// 로그인한 사용자 정보 가져오기

	String getUserid(HashMap<String, String> map);  // userid 찾기

	int getUserExists(HashMap<String, String> map); // pwd 찾기

	int updatePwd(HashMap<String, String> map);  // pwd 변경하기

	int idDuplicateCheck(String userid);  // id 중복 체크

	int registerMember(MemberVO mvo);  				// 회원가입(tbl_member)
	int registerMemberDetail(MemberDetailVO mdvo);  // 회원가입(tbl_member_detail)

	MemberVO findMemberByIdx(int idx);  		// 회원번호로 회원정보 조회(tbl_member)
	MemberDetailVO findMemberByIdx2(int idx);   // 회원번호로 회원정보 조회(tbl_member_detail)

	int updateMember(MemberVO mvo);				// 회원정보 수정(tbl_member)
	int updateMember2(MemberDetailVO mdvo);		// 회원정보 수정(tbl_member_detail)

	
	

	

	

	

}



