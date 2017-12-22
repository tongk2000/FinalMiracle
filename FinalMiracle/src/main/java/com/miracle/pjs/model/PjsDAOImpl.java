package com.miracle.pjs.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PjsDAOImpl implements PjsinterDAO {
//	
	@Autowired
	private SqlSessionTemplate sqlsession;

//==========================================================================================================================================================//	
	
	
	// === *** 공지사항 게시판 *** === //
	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, Object> map) {
		// 공지사항 게시판 페이징리스트를 가져오는 메소드
		for(int i=0; i<map.size(); i++) {
			System.out.println("=============================map.get===================="+map.size());
		}
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getNoticeList", map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public int getNoticeCount(HashMap<String, Object> map) {
		// 공지사항 게시판의 전체 행 수를 반환
		for(int i=0; i<map.size(); i++) {
			System.out.println("=============================map.get===================="+map.size());
		}
		int cnt = sqlsession.selectOne("pjsfinal.getNoticeCount", map);
		return cnt;
	}/* ================================================================================================================================================== */
	@Override
	public List<String> getNoticeJSONList(HashMap<String, String> map) {
		// 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
		List<String> list = sqlsession.selectList("pjsfinal.getNoticeJSONList",map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getViewContent(String id) {
		// 공지사항 게시판에서 유저의 정보를 가져오는 메소드
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getViewContent", id);
		return map;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getIdxTeam(HashMap<String, String> view) {
		// 공지사항 게시판의 해당 행의 내용을 보여주는 메소드
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getIdxTeam", view);
		return map;
	}/* ================================================================================================================================================== */
	/*@Override
	public int delNoticeIdx(List<String> list) {
		// 공지사항 게시물을 지우는 메소드
		int n = sqlsession.update("pjsfinal.delNoticeIdx", list);
		return n;
	}*//* ================================================================================================================================================== */
	/*@Override
	public int delNoticeIdx(HashMap<String,String> paramap) {
		// 공지사항 게시물을 지우는 메소드
		
		int sum = 0;
		int n = 0;
		
		for(int i=0; i<paramap.size(); i++) {
			String paraidx = paramap.get("paraidx"+i);
			n = sqlsession.update("pjsfinal.delNoticeIdx", paraidx);
			sum += n;
		}
		
	//	int n = sqlsession.update("pjsfinal.delNoticeIdx", paramap);
		return sum;
	}*//* ================================================================================================================================================== */
	@Override
	public int delNoticeIdx(HashMap<String, String> paramap, String[] idxArr) {
		// 공지사항 게시물을 지우는 메소드
		// System.out.println("====> idxes : " + idxes);
		int n =0;
		for(int i=0; i<idxArr.length; i++) {
			String idx = paramap.get("idxArr"+i);
			n = sqlsession.update("pjsfinal.delNoticeIdx", idx);
			if(n==0) 
				return 0;
		}
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public List<ReplyVO> getComment(HashMap<String, Object> map) {
		// 공지사항 게시물의 리플을 얻어오는 메소드
		List<ReplyVO> list = sqlsession.selectList("pjsfinal.getComment", map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public int setComment(HashMap<String, String> map) {
		// 공지사항 게시글에 리플달기
		int n = sqlsession.insert("pjsfinal.setComment", map);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public int updateReadCount(String nidx) {
		// 공지사항 글의 조회수를 늘리는 메소드
		int n = sqlsession.update("pjsfinal.updateReadCount", nidx);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public int setNoticeWrite(HashMap<String, String> team) {
		// 글쓰기 완료 메소드
		int n = sqlsession.insert("pjsfinal.setNoticeWrite",team);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public int setNoticeEditWrite(HashMap<String, String> map) {
		// 수정글쓰기 입력 메소드
		for(int i=0; i<map.size(); i++) {
			System.out.println(map.get("userid"));
			System.out.println(map.get("nidx"));
			System.out.println(map.get("teamNum"));
			System.out.println(map.get("subject"));
			System.out.println(map.get("content"));
		}
		int n = sqlsession.insert("pjsfinal.setNoticeEditWrite",map);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getDepth(String parameter) {
		// 수정글쓰기의 depth를 가져온다.
		HashMap<String, String> depth = sqlsession.selectOne("pjsfinal.getDepth", parameter);
		return depth;
	}
	@Override
	public int getCountReply(HashMap<String, Object> map) {
		// 댓글 수 가져오기
		int count = sqlsession.selectOne("pjsfinal.getCountReply", map);
		return count;
	}
	
	
	
//==========================================================================================================================================================//	
	
	
	// === *** 마음의 소리 게시판 *** === //
	@Override
	public List<HashMap<String, String>> getMindList(HashMap<String, String> map) {
		// 마음의 소리 게시판 전체리스트 반환
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getMindList", map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public int getMindCount(HashMap<String, String> map) {
		// 마음의 소리 게시판에 검색된 행의 수를 반환한다.
		int cnt = sqlsession.selectOne("pjsfinal.getMindCount",map); 
		return cnt;
	}/* ================================================================================================================================================== */
	@Override
	public List<String> getMindJSONList(HashMap<String, String> map) {
		// 마음의 소리 게시판 JSON처리
		List<String> list = sqlsession.selectList("pjsfinal.getMindJSONList",map);
		return list;
	}
	@Override
	public HashMap<String, String> getMindIdxTeam(HashMap<String, String> view) {
		// 마음의 소리 글보기
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getMindIdxTeam", view);
		return map;
	}
	@Override
	public int setMindWrite(HashMap<String, String> team) {
		// 마음의 소리 글쓰기
		System.out.println("==========map============="+team.get("nidx"));
		System.out.println("==========map============="+team.get("userid"));
		System.out.println("==========map============="+team.get("subject"));
		System.out.println("==========map============="+team.get("content"));
		int n = sqlsession.insert("pjsfinal.setMindWrite", team);
		return n;
	}
	@Override
	public HashMap<String, String> getMindDepth(String nidx) {
		// depth와 groupno 가져온다.
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getMindDepth",nidx);
		return map;
	}
	@Override
	public int updateMindReadCount(String idx) {
		// 조회수 올려주는 메소드
		System.out.println("===============idx==========================="+idx);
		int n = sqlsession.update("pjsfinal.updateMindReadCount", idx);
		return n;
	}
	@Override
	public int updateMindCheckNum(String nidx) {
		// 대기, 확인, 답변완료 변경 메소드
		int n = sqlsession.update("pjsfinal.updateMindCheckNum", nidx);
		return n;
	}
	@Override
	public int delMindIdx(HashMap<String,String> paramap , String[] idxArr) {
		// 마음의 소리 다중행 삭제
		int n=0;
		for(int i=0; i<idxArr.length; i++) {
			String idx = paramap.get("idxArr"+i);
			n = sqlsession.update("pjsfinal.delMindIdx", idx);
		}
		return n;
	}
	
	

//==========================================================================================================================================================//	
	
	
	// === *** 구글맵 *** === //
	@Override
	public List<MapVO> getMap(HashMap<String, String> map) {
		// 구글맵 테이블의 팀 내용을 가져온다.
		List<MapVO> list = sqlsession.selectList("pjsfinal.getMap",map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public List<MapVO> getMapWithSearch(HashMap<String, String> map) {
		// 검색어를 포함한 지도 리스트를 받아온다.
		List<MapVO> list = sqlsession.selectList("pjsfinal.getMapWithSearch", map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public List<String> getSearchJSON(HashMap<String, String> map) {
		// 구글맵 JSON 검색처리
		List<String> list = sqlsession.selectList("pjsfinal.getSearchJSON", map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getMapFood(String map_idx) {
		// 구글맵에서 음식점 마커 클릭 시 사용
		HashMap<String, String> googleMapFood = sqlsession.selectOne("pjsfinal.getMapFood",map_idx);
		System.out.println("=======================구글맵 맛집정보 ====================="+googleMapFood);
		return googleMapFood;
	}/* ================================================================================================================================================== */
	@Override
	public List<HashMap<String, String>> getMapTeam(String map_idx) {
		// 구글맵에서 팀 정보 마커 클릭 시 사용
		List<HashMap<String, String>> googleMapTeam = sqlsession.selectList("pjsfinal.getMapTeam",map_idx);
		System.out.println("==================구글맵 사이즈====================="+googleMapTeam.size());
		return googleMapTeam;
	}
	
//==========================================================================================================================================================//	

	
	

	
//==========================================================================================================================================================//	

	// === *** 쪽지 *** === //
	@Override
	public int getSenderMemo(HashMap<String, String> map) {
		// 쪽지 보낸 사람의 쪽지 수 반환
		int n = sqlsession.selectOne("pjsfinal.getSenderMemo",map); // userid, teamNum 을 보냄!
		return n;
	}
	@Override
	public List<HashMap<String, String>> getSenderMemoList(HashMap<String, String> map) {
		// sender가 보낸 쪽지 리스트를 반환한다.
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getSenderMemoList", map);
		return list;
	}
	@Override
	public int getReceiverMemo(HashMap<String, String> map) {
		// 받은 쪽지의 갯수를 리턴한다.
		int n = sqlsession.selectOne("pjsfinal.getReceiverMemo", map);
		return n;
	}
	@Override
	public List<HashMap<String, String>> getReceiverMemoList(HashMap<String, String> map) {
		// 받은 쪽지의 리스트를 반환
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getReceiverMemoList",map);
		return list;
	}
	@Override
	public HashMap<String, String> getSenderIdx(HashMap<String, String> info) {
		// idx에 해당하는 정보를 반환한다.
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getSenderIdx",info);
		return map;
	}
	@Override
	public HashMap<String, String> getReceiverIdx(HashMap<String, String> info) {
		// idx에 Receiver 해당하는 정보를 반환한다.
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getReceiverIdx", info);
		return map;
	}
	@Override
	public List<String> getReceiverNames(HashMap<String, String> map) {
		// 쪽지 받은 사람의 리스트를 불러온다.
		List<String> nameArr = sqlsession.selectList("pjsfinal.getReceiverNames", map);
		
		return nameArr;
	}
	@Override
	public int delSenderMemo(HashMap<String,String[]> idx) {
		// 해당 idx의 보낸 쪽지를 삭제한다.
		int n = sqlsession.update("pjsfinal.delSenderMemo", idx);
		return n;
	}
	@Override
	public int delReceiverMemo(HashMap<String, String[]> idx) {
		// 해당 idx의 받은 쪽지를 삭제한다.
		int n = sqlsession.update("pjsfinal.delReceiverMemo", idx);
		return n;
	}
	@Override
	public int updateRreadCount(String idx, String userid) {
		// 쪽지를 받은 사람이 읽었는지 않 읽었는지 update
		int n = sqlsession.update("pjsfinal.updateRreadCount", idx);
		return n;
	}
	@Override
	public List<HashMap<String, String>> getTeam(String teamNum) {
		// 메모쓰기 시 전체 팀 이름을 가져온다.
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getTeam", teamNum);
		return list;
	}
	/*@Override
	public List<HashMap<String, String>> getAllMember() {
		// 메모쓰기 시 전체 멤버 이름을 가져온다.
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getAllMember");
		return list;
	}*/
	/*@Override
	public String getCheckNum(HashMap<String, String> map) {
		// 몇명이 읽었는지 반환
		int check = sqlsession.selectOne("pjsfinal.getCheckNum", map);
		String list = String.valueOf(check);
		return list;
	}*/
	@Override
	public String getMessage(HashMap<String, String> map) {
		// 메세지 알람
		String n = sqlsession.selectOne("pjsfinal.getMessage", map);
		return n;
	}
	@Override
	public int checkReadCount(String parameter) {
		// readcount가 0인지 1인지
		int readcount = sqlsession.selectOne("pjsfinal.checkReadCount", parameter);
		return readcount;
	}
	@Override
	public int insertsender(HashMap<String, Object> map) {
		// sender 삽입
		int n = sqlsession.insert("pjsfinal.insertsender",map);
		return n;
	}
	@Override
	public String getSenderLastIdx(HashMap<String, Object> map) {
		// 최신 idx 가져오기
		String idx = sqlsession.selectOne("pjsfinal.getSenderLastIdx", map);
		return idx;
	}
	@Override
	public int insertreceiver(HashMap<String, Object> map) {
		// receiver 삽입
		int n = sqlsession.insert("pjsfinal.insertreceiver",map);
		return n;
	}

	
	
	
//==========================================================================================================================================================//	
	
	@Override
	public HashMap<String, String> getUserTeam(HashMap<String, String> map) {
		// 로그인한 유저의 팀정보를 가져오는 메소드
		HashMap<String, String> userTeam = sqlsession.selectOne("pjsfinal.getUserTeam", map);
		return userTeam;
	}
	@Override
	public int setNoticeWriteWithFile(HashMap<String, String> team) {
		// 공지사항 파일올리기
		int n = sqlsession.insert("pjsfinal.setNoticeWriteWithFile", team);
		return n;
	}
	@Override
	public String getfilenamelist(HashMap<String, Object> map) {
		// 파일이 있는지 없는지 가져오기
		String file = sqlsession.selectOne("pjsfinal.getfilenamelist", map);
		return file;
	}
	@Override
	public FileVO getViewWithNoAddCount(HashMap<String, String> map) {
		// 파일 다운로드
		FileVO vo = sqlsession.selectOne("pjsfinal.getViewWithNoAddCount", map);
		return vo;
	}
	@Override
	public String getmemoReadCount(String string) {
		// 메모 읽었는지 여부반환
		String memo = sqlsession.selectOne("pjsfinal.getmemoReadCount", string);
		return memo;
	}
	@Override
	public NoticeFileVO getfilename(String nidx) {
		// 뷰에 뿌릴 파일 가져오기
		NoticeFileVO file = sqlsession.selectOne("pjsfinal.getfilename", nidx);
		return file;
	}
	@Override
	public int setUpdateWrite(HashMap<String, String> team) {
		// 공지사항 수정하기
		int n = sqlsession.update("pjsfinal.setUpdateWrite",team);
		return n;
	}
	@Override
	public int setMindWriteWithFile(HashMap<String, String> team) {
		// 마음의 소리 글쓰기 파일첨부
		int n=sqlsession.insert("pjsfinal.setMindWriteWithFile", team);
		return n;
	}
	@Override
	public int getReplyCount(HashMap<String, Object> map) {
		// 리플 글 총 수
		int n = sqlsession.selectOne("pjsfinal.getReplyCount", map);
		return n;
	}
	@Override
	public int setMindViewEdit(HashMap<String, String> team) {
		// 마음의 소리 글 수정
		int n = sqlsession.update("pjsfinal.setMindViewEdit", team);
		return n ;
	}
	@Override
	public String getMindfilenamelist(HashMap<String, String> map) {
		// 마음의 소리 파일 있는지 없는지 반환
		String n = sqlsession.selectOne("pjsfinal.getMindfilenamelist",map);
		return n;
	}
	@Override
	public MindFileVO getMindfilename(String idx) {
		// 마음의 소리 파일vo반환
		MindFileVO vo = sqlsession.selectOne("pjsfinal.getMindfilename",idx);
		return vo;
	}
	@Override
	public String getMindWrite(HashMap<String, String> team) {
		// 첨부파일의 fk_idx를 가져온다.
		String a = sqlsession.selectOne("pjsfinal.getMindWrite", team);
		return a ;
	}
	@Override
	public FileVO getmindViewWithNoAddCount(HashMap<String, String> map) {
		// 마음의 소리 filevo가져오기
		FileVO vo = sqlsession.selectOne("pjsfinal.getmindViewWithNoAddCount", map);
		return vo;
	}
	@Override
	public HashMap<String, String> getNoticeInfo(HashMap<String, String> view) {
		// 공지사항 정보가져오기
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getNoticeInfo", view);
		return map;
	}
	@Override
	public String getCountNum(HashMap<String, Object> map) {
		// 게시물의 총 수를 반환
		String num = sqlsession.selectOne("pjsfinal.getCountNum", map);
		return num;
	}
	@Override
	public String getNiticefileNum() {
		// 파일의 최대값
		String num = sqlsession.selectOne("pjsfinal.getNiticefileNum");
		return num;
	}
	@Override
	public String getMindfileNum() {
		// TODO Auto-generated method stub
		String n = sqlsession.selectOne("pjsfinal.getMindfileNum");
		return n;
	}
	

	
	

}
