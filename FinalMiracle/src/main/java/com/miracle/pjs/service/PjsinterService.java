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
	
	// int delNoticeIdx(List<String> list); // 공지사항 게시판을 지우는 메소드
	// int delNoticeIdx(HashMap<String,String> paramap); // 공지사항 게시판을 지우는 메소드
	int delNoticeIdx(HashMap<String, String[]> paramap); // 공지사항 게시판을 지우는 메소드
	
	List<ReplyVO> getComment(String idx); // 게시글의 코멘트를 달기위한 메소드
	
	int setComment(HashMap<String, String> map); // 공지사항 게시물에 댓글달기
	
	int updateReadCount(String idx); // 공지사항 글의 조회수를 늘리는 메소드 
	
	int setNoticeWrite(HashMap<String, String> team); // 글쓰기 완료 메소드
	
	int setNoticeEditWrite(HashMap<String, String> map); // 수정글쓰기 입력 메소드
	
	HashMap<String, String> getDepth(String parameter); // 수정글의 depth, groupno 구해오는 메소드
	
	int getCountReply(HashMap<String, Object> map); // 리스트의 댓글 수 가져오기
	
//==========================================================================================================================================================//	
	
	// === *** 마음의 소리 게시판 *** === //
	List<HashMap<String, String>> getMindList(HashMap<String, String> map, String str_sizePerPage, String str_currentPage); // 마음의 소리 게시판의 검색된 모든 리스트를 가져오는 메소드
	
	String getMindJSONList(HashMap<String, String> map); // 마음의 소리 JSON처리
	
	HashMap<String, String> getMindIdxTeam(HashMap<String, String> view); // 마음의 소리 글보기
	
	int setMindWrite(HashMap<String, String> team); // 마음의 소리 글 쓰기
	
	HashMap<String, String> getMindDepth(String nidx); // 수정글의 depth, groupno 구해오는 메소드
	
	int updateMindReadCount(String idx); // 조회수 올리는 메소드
	
	int updateMindCheckNum(String nidx); // 대기, 확인, 답변 변경해주는 메소드
	
	int delMindIdx(HashMap<String,String[]> paramap); // 마음의 소리 다중 삭제
	
//==========================================================================================================================================================//	
	
	// === *** 구글맵 *** === //
	List<MapVO> getMap(); // 맵 테이블의 전체값을 가져온다!
	
	List<MapVO> getMapWithSearch(HashMap<String, String> map); // 검색어를 동반한 지도리스트
	
	String getSearchJSON(HashMap<String, String> map); // 구글맵 JSON 검색처리
	
	HashMap<String, String> getMapFood(String map_idx); // 구글맵에서 음식점 마커 클릭 시 사용
	
	List<HashMap<String, String>> getMapTeam(String map_idx); // 구글맵에서 팀 정보 마커 클릭 시 사용

//==========================================================================================================================================================//	
	
	// === *** 쪽지 *** === //
	
	int getSenderMemo(HashMap<String, String> map); // 쪽지 보낸 사람의 총 보낸 편지 수를 반환

	List<HashMap<String, String>> getSenderMemoList(HashMap<String, String> map); // sender의 보낸 쪽지 리스트를 반환한다.
	
	int getReceiverMemo(HashMap<String, String> map); // 쪽지 받은 사람의 총 받은 쪽지 갯수를 반환

	List<HashMap<String, String>> getReceiverMemoList(HashMap<String, String> map); // 받은 쪽지 리스트를 반환

	HashMap<String, String> getSenderIdx(HashMap<String, String> info); // idx에 해당하는 sender의 테이블내용을 가져온다.
	
	HashMap<String, String> getReceiverIdx(HashMap<String, String> info); // idx에 해당하는 receiver의 테이블내용을 가져온다.
	
	List<String> getReceiverNames(HashMap<String, String> map); // 메모받은 사람의 리스트를 불러온다. 
	
	int delSenderMemo(HashMap<String,String[]> idx); // 해당 idx의 보낸쪽지를 삭제한다.
	
	int delReceiverMemo(HashMap<String, String[]> idx); // 해당 idx의 받은 쪽지를 삭제한다.

	int updateRreadCount(String idx, String userid); // 쪽지를 받은 사람이 읽었는지 않 읽었는지 update

	List<HashMap<String, String>> getTeam(String teamNum); // 메모쓰기 시 모든 팀 이름을 가져온다.

	//List<HashMap<String, String>> getAllMember(); // 모든 멤버이름을 가져온다.

	//String getCheckNum(HashMap<String, String> map); // 몇명이 읽었는지 반환
	
	int checkReadCount(String parameter); //readcount가 1인지 0인지 알아오자 몰라서 편법씀
	
	int insertMemo(HashMap<String, Object> map, List<String> list); // 메모입력
	
//==========================================================================================================================================================//	

	
	
	
	// 로그인한 유저의 팀정보를 가져오기 위

	HashMap<String, String> getUserTeam(HashMap<String, String> team);

	String getMessage(HashMap<String, String> map); // 알람 ajax버전

	


	

	

	

	
	

	
	

	
	
}
