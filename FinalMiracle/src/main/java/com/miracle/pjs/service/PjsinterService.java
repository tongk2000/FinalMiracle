package com.miracle.pjs.service;

import java.util.HashMap;
import java.util.List;

import com.miracle.pjs.model.MapVO;

public interface PjsinterService {

//==========================================================================================================================================================//	
	
	// === *** 공지사항 게시판 *** === //
	List<HashMap<String, String>> getNoticeList(HashMap<String, String> map);  // 공지사항 게시판 페이징리스트를 가져오는 메소드

	int getNoticeCount(HashMap<String, String> map); // 공지사항 테이블의 전체 행 수를 반환하는 메소드

	String getNoticeJSONList(HashMap<String, String> map); // 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
	
	HashMap<String, String> getViewContent(String id); // 유저의 정보를 불러오기 위한 메소드
	
	HashMap<String, String> getIdxTeam(String idx); // 공지사항의 해당 행을 선택하면 그 글의 정보를 보여주는 메소드
	
	int delNoticeIdx(String idx); // 공지사항 게시판을 지우는 메소드

//==========================================================================================================================================================//	
	
	// === *** 마음의 소리 게시판 *** === //
	List<HashMap<String, String>> getMindList(HashMap<String, String> map, String str_sizePerPage, String str_currentPage); // 마음의 소리 게시판의 검색된 모든 리스트를 가져오는 메소드
	
	String getMindJSONList(HashMap<String, String> map); // 마음의 소리 JSON처리
	
//==========================================================================================================================================================//	
	
	// === *** 구글맵 *** === //
	List<MapVO> getMap(); // 맵 테이블의 전체값을 가져온다!
	
	List<MapVO> getMapWithSearch(HashMap<String, String> map); // 검색어를 동반한 지도리스트
	
	String getSearchJSON(HashMap<String, String> map); // 구글맵 JSON 검색처리

//==========================================================================================================================================================//	

	
	// 로그인한 유저의 팀정보를 가져오기 위한 메소드
	HashMap<String, String> getUserTeam(String userid);

	
}
