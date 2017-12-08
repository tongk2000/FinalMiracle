package com.miracle.pjs.service;

import java.util.HashMap;
import java.util.List;

import com.miracle.pjs.model.MapVO;
import com.miracle.pjs.model.ReplyVO;

public interface PjsinterService {

//==========================================================================================================================================================//	
	
	// === *** 공지사항 게시판 *** === //
	List<HashMap<String, String>> getNoticeList(HashMap<String, Object> map);  // 공지사항 게시판 페이징리스트를 가져오는 메소드

	int getNoticeCount(HashMap<String, Object> map); // 공지사항 테이블의 전체 행 수를 반환하는 메소드

	String getNoticeJSONList(HashMap<String, String> map); // 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
	
	HashMap<String, String> getViewContent(String id); // 게시글을 보여줄 때 유저의 정보를 불러오기 위한 메소드
	
	HashMap<String, String> getIdxTeam(HashMap<String, String> view); // 공지사항의 해당 행을 선택하면 그 글의 정보를 보여주는 메소드
	
	int delNoticeIdx(String idx); // 공지사항 게시판을 지우는 메소드
	
	List<ReplyVO> getComment(String idx); // 게시글의 코멘트를 달기위한 메소드
	
	int setComment(HashMap<String, String> map); // 공지사항 게시물에 댓글달기
	
	int updateReadCount(String idx); // 공지사항 글의 조회수를 늘리는 메소드 

//==========================================================================================================================================================//	
	
	// === *** 마음의 소리 게시판 *** === //
	List<HashMap<String, String>> getMindList(HashMap<String, String> map, String str_sizePerPage, String str_currentPage); // 마음의 소리 게시판의 검색된 모든 리스트를 가져오는 메소드
	
	String getMindJSONList(HashMap<String, String> map); // 마음의 소리 JSON처리
	
//==========================================================================================================================================================//	
	
	// === *** 구글맵 *** === //
	List<MapVO> getMap(); // 맵 테이블의 전체값을 가져온다!
	
	List<MapVO> getMapWithSearch(HashMap<String, String> map); // 검색어를 동반한 지도리스트
	
	String getSearchJSON(HashMap<String, String> map); // 구글맵 JSON 검색처리
	
	HashMap<String, String> getMapFood(String map_idx); // 구글맵에서 음식점 마커 클릭 시 사용
	
	List<HashMap<String, String>> getMapTeam(String map_idx); // 구글맵에서 팀 정보 마커 클릭 시 사용

//==========================================================================================================================================================//	

	
	// 로그인한 유저의 팀정보를 가져오기 위한 메소드
	HashMap<String, String> getUserTeam(HashMap<String, String> team);



	
}
