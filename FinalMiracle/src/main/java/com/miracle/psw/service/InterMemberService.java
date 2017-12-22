package com.miracle.psw.service;

import java.util.HashMap;

import com.miracle.psw.model.MemberDetailVO;
import com.miracle.psw.model.MemberVO;

public interface InterMemberService {

	int loginEnd(HashMap<String, String> map);  // 로그인 여부 알아오기

	MemberVO getLoginMember(String userid);  	// 로그인 정보 확인

	String getUserid(HashMap<String, String> map);  // id 찾기

	int getUserExists(HashMap<String, String> map); // pw 찾기

	int updatePwd(HashMap<String, String> map);  // pwd 변경하기

	boolean idDuplicateCheck(String userid);  // id 중복체크

	int registerMember(MemberVO mvo, MemberDetailVO mdvo) throws Throwable;  // 회원가입

	HashMap<String, Object> findMemberByIdx(int idx);  // 회원 번호로 한사람의 회원정보 불러오기

	int updateMember(MemberVO mvo, MemberDetailVO mdvo) throws Throwable;  // 회원정보 수정

	int alterImg(HashMap<String, Object> map);  // 회원 사진 변경하기

	



	

	

}
