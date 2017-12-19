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

//	int delNoticeIdx(List<String> list); // 공지사항 게시물을 지우는 메소드
//	int delNoticeIdx(HashMap<String,String> paramap); // 공지사항 게시물을 지우는 메소드
	int delNoticeIdx(HashMap<String, String> paramap, String[] idxArr); // 공지사항 게시물을 지우는 메소드
	
	List<ReplyVO> getComment(HashMap<String, Object> map); // 공지사항 게시물의 리플을 얻는 메소드 
	
	int setComment(HashMap<String, String> map); // 공지사항 게시글에 리플달기
	
	int updateReadCount(String idx); // 공지사항 게시글의 조회수 늘리는 메소드
	
	int setNoticeWrite(HashMap<String, String> team); // 글쓰기 완료 메소드
	
	int setNoticeEditWrite(HashMap<String, String> map); // 수정글쓰기 메소드
	
	HashMap<String, String> getDepth(String parameter); // 수정글쓰기의 depth, groupno를 구해온다.
	
	int getCountReply(HashMap<String, Object> map); // 댓글 수 가져오기
	
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
	
	int delMindIdx(HashMap<String,String> paramap , String[] idxArr); // 마음의 소리 다중행 삭제
	
	
//==========================================================================================================================================================//	
	
	// === *** 구글맵 *** === //
	List<MapVO> getMap(HashMap<String, String> map); // 구글맵 테이블의 전체 내용을 가져온다.
	
	List<MapVO> getMapWithSearch(HashMap<String, String> map); // 검색어를 포함한 지도 리스트를 받아온다.
	
	List<String> getSearchJSON(HashMap<String, String> map); // 구글맵 JSON 검색처리
	
	HashMap<String, String> getMapFood(String map_idx); // 구글맵에서 음식점 마커 클릭 시 사용

	List<HashMap<String, String>> getMapTeam(String map_idx); // 구글맵에서 팀 정보 마커 클릭 시 사용


//==========================================================================================================================================================//	

	
	
	
//==========================================================================================================================================================//	
	
	// === *** 쪽지 *** === //
	int getSenderMemo(HashMap<String, String> map);

	List<HashMap<String, String>> getSenderMemoList(HashMap<String, String> map); // sender가 보낸 쪽지 리스트를 반환한다.

	int getReceiverMemo(HashMap<String, String> map); // 쪽지를 받은 사람의 받은 쪽지 갯수를 리턴한다.

	List<HashMap<String, String>> getReceiverMemoList(HashMap<String, String> map); // 받은 쪽지의 리스트를 반환한다.
	
	HashMap<String, String> getSenderIdx(HashMap<String, String> info); // idx에 해당하는 정보를 가져온다.

	HashMap<String, String> getReceiverIdx(HashMap<String, String> info); // idx에 receiver의 해당하는 정보를 가져온다.
	
	List<String> getReceiverNames(HashMap<String, String> map); // 쪽지 받은 사람의 이름 리스트를 받아온다.
	
	int delSenderMemo(HashMap<String,String[]> idx); // 해당 idx의 보낸쪽지를 삭제한다.
	
	int delReceiverMemo(HashMap<String, String[]> idx); // 해당 idx의 받은 쪽지를 삭제한다.
	
	int updateRreadCount(String idx, String userid); // 쪽지를 받은 사람이 읽었는지 않 읽었는지 update
	
	List<HashMap<String, String>> getTeam(String teamNum); // 메모쓰기 시 팀멤버 이름을 가져온다.

	//List<HashMap<String, String>> getAllMember(); // 메모쓰기 시 전체 멤버이름을 가져온다.

	//String getCheckNum(HashMap<String, String> map); // 몇명이 읽었는지 반환
	
	String getMessage(HashMap<String, String> map);// 메세지 알람
	
	int checkReadCount(String parameter); //readcount가 0인지 1인지

	int insertsender(HashMap<String, Object> map); // sender insert
	
	String getSenderLastIdx(HashMap<String, Object> map); // sender의 가장 최신 idx가져오기
	
	int insertreceiver(HashMap<String, Object> map); // receiver입력
	
//==========================================================================================================================================================//	

	
	
	
	
	
	
	// 로그인한 유저의 팀정보를 가져오는 메소드
	HashMap<String, String> getUserTeam(HashMap<String, String> team);

	int setNoticeWriteWithFile(HashMap<String, String> team); // 공지사항 파일올리기

	String getfilenamelist(HashMap<String, Object> map); // 파일이 있는지 없는지 가져오기

	FileVO getViewWithNoAddCount(HashMap<String, String> map); // 파일 다운로드

	String getmemoReadCount(String string); // 메모 읽었는지 여부 반환

	NoticeFileVO getfilename(String nidx); // 뷰에 뿌릴 파일 가져오기

	int setUpdateWrite(HashMap<String, String> team); // 공지사항 수정하기

	int setMindWriteWithFile(HashMap<String, String> team); // 마음의 소리 파일첨부

	int getReplyCount(HashMap<String, Object> map); // 리플 글 총 수

	int setMindViewEdit(HashMap<String, String> team); // 글 수정

	String getMindfilenamelist(HashMap<String, String> map); // 마음의 소리에 파일이 있는지 없는지 반환

	MindFileVO getMindfilename(String idx); // 마음의 소리에 파일vo 반환

	String getMindWrite(HashMap<String, String> team); // 첨부파일의 fk_idx를 가져온다.

	FileVO getmindViewWithNoAddCount(HashMap<String, String> map); // 마음의 소리 파일 가져오기

	

	

	

	
	
	

	

	



}