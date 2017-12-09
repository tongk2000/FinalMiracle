package com.miracle.pjs.model;

import java.util.HashMap;
import java.util.List;

public interface PjsinterDAO {

//==========================================================================================================================================================//	

	
	// === *** 공지사항 게시판 *** === //
	List<HashMap<String, String>> getNoticeList(HashMap<String, Object> map);  // 공지사항 게시판의 검색 리스트를 가져오는 메소드

	int getNoticeCount(HashMap<String, Object> map); // 공지사항 게시판 페이징리스트를 가져오는 메소드

	List<String> getNoticeJSONList(HashMap<String, String> map); // 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
	
	HashMap<String, String> getViewContent(String id); // 유저의 정보를 가져오는 메소드
	
	HashMap<String, String> getIdxTeam(HashMap<String, String> view); // 공지사항 게시판의 해당 행의 내용을 보여주는 메소드

	int delNoticeIdx(List<String> list); // 공지사항 게시물을 지우는 메소드
	
	List<ReplyVO> getComment(String idx); // 공지사항 게시물의 리플을 얻는 메소드 
	
	int setComment(HashMap<String, String> map); // 공지사항 게시글에 리플달기
	
	int updateReadCount(String idx); // 공지사항 게시글의 조회수 늘리는 메소드
	
	int setNoticeWrite(HashMap<String, String> team); // 글쓰기 완료 메소드
	
	int setNoticeEditWrite(HashMap<String, String> map); // 수정글쓰기 메소드
	
	HashMap<String, String> getDepth(String parameter); // 수정글쓰기의 depth, groupno를 구해온다.
	
	
//==========================================================================================================================================================//	
	
	
	// === *** 마음의 소리 게시판 *** === //
	List<HashMap<String, String>> getMindList(HashMap<String, String> map); // 마음의 소리 게시판의 리스트를 불러온다.

	int getMindCount(HashMap<String, String> map); // 마음의 소리 게시판에 검색된 행의 수를 반환한다.

	List<String> getMindJSONList(HashMap<String, String> map); // 마음의 소리 게시판 JSON 처리
	
	HashMap<String, String> getMindIdxTeam(HashMap<String, String> view); // 마음의 소리 글보기
	
	int setMindWrite(HashMap<String, String> team);// 마음의 소리 글 쓰기
	
	HashMap<String, String> getMindDepth(String nidx); // depth, groupno가져온다.
	
	int updateMindReadCount(String idx); // 조회수 올려주는 메소드
	
	int updateMindCheckNum(String nidx); // 대기, 확인, 답변완료 상태변경 메소드

	
	
//==========================================================================================================================================================//	
	
	// === *** 구글맵 *** === //
	List<MapVO> getMap(); // 구글맵 테이블의 전체 내용을 가져온다.
	
	List<MapVO> getMapWithSearch(HashMap<String, String> map); // 검색어를 포함한 지도 리스트를 받아온다.
	
	List<String> getSearchJSON(HashMap<String, String> map); // 구글맵 JSON 검색처리
	
	HashMap<String, String> getMapFood(String map_idx); // 구글맵에서 음식점 마커 클릭 시 사용

	List<HashMap<String, String>> getMapTeam(String map_idx); // 구글맵에서 팀 정보 마커 클릭 시 사용


//==========================================================================================================================================================//	

	
	// 로그인한 유저의 팀정보를 가져오는 메소드
	HashMap<String, String> getUserTeam(HashMap<String, String> team);


}
