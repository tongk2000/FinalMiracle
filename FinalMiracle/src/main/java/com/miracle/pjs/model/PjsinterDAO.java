package com.miracle.pjs.model;

import java.util.HashMap;
import java.util.List;

public interface PjsinterDAO {

//==========================================================================================================================================================//	

	
	// === *** 공지사항 게시판 *** === //
	List<HashMap<String, String>> getNoticeList(HashMap<String, String> map);  // 공지사항 게시판의 검색 리스트를 가져오는 메소드

	int getNoticeCount(HashMap<String, String> map); // 공지사항 게시판 페이징리스트를 가져오는 메소드

	List<String> getNoticeJSONList(HashMap<String, String> map); // 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
	
	HashMap<String, String> getViewContent(String id); // 유저의 정보를 가져오는 메소드
	
//==========================================================================================================================================================//	
	
	
	// === *** 마음의 소리 게시판 *** === //
	List<HashMap<String, String>> getMindList(HashMap<String, String> map); // 마음의 소리 게시판의 리스트를 불러온다.

	int getMindCount(HashMap<String, String> map); // 마음의 소리 게시판에 검색된 행의 수를 반환한다.

	List<String> getMindJSONList(HashMap<String, String> map); // 마음의 소리 게시판 JSON 처리

	
//==========================================================================================================================================================//	
	
	// === *** 구글맵 *** === //
	List<MapVO> getMap(); // 구글맵 테이블의 전체 내용을 가져온다.

//==========================================================================================================================================================//	

	
	// 로그인한 유저의 팀정보를 가져오는 메소드
	HashMap<String, String> getUserTeam(String userid);

}
