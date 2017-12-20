package com.miracle.pjs.service;

import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.miracle.pjs.model.FileVO;
import com.miracle.pjs.model.MapVO;
import com.miracle.pjs.model.MindFileVO;
import com.miracle.pjs.model.NoticeFileVO;
import com.miracle.pjs.model.PjsinterDAO;
import com.miracle.pjs.model.ReplyVO;
import com.miracle.pjs.util.MyUtil;

@Service
public class PjsserviceImpl implements PjsinterService {
	
	@Autowired
	private PjsinterDAO dao;

// === *** 공지사항 게시판 *** === //
//==========================================================================================================================================================//	
	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, Object> map) {
		// 공지사항 게시판 페이징리스트를 가져오는 메소드
		List<HashMap<String, String>> list = dao.getNoticeList(map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public int getNoticeCount(HashMap<String, Object> map) {
		// 테이블의 행수를 반환
		int cnt = dao.getNoticeCount(map);
		return cnt;
	}/* ================================================================================================================================================== */
	@Override
	public String getNoticeJSONList(HashMap<String, String> map) {
		// 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
		List<String> list = dao.getNoticeJSONList(map);
		JSONArray jsonList = null;
		String searchString = "";
		if(list!=null&&list.size()>0) {
			jsonList = new JSONArray();
			for(String obj : list) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("search", obj);
				jsonList.put(jsonObj);
			}
			searchString = jsonList.toString();
		}
		else 
			searchString = "해당하는 검색정보가 없습니다.";
		return searchString;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getViewContent(String id) {
		// 유저의 정보를 가져오기 위한 메소드
		HashMap<String, String> map = dao.getViewContent(id);
		return map;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getIdxTeam(HashMap<String, String> view) {
		// 공지사항 게시판의 해당 글을 클릭하면 그 글의 내용을 보여주는 메소드
		HashMap<String, String> map = dao.getIdxTeam(view);
		return map;
	}/* ================================================================================================================================================== */
	/*@Override
	public int delNoticeIdx(List<String> list) {
		// 공지사항 게시물을 지우는 메소드
		int n = dao.delNoticeIdx(list);
		return n;
	}*//* ================================================================================================================================================== */
	/*@Override
	public int delNoticeIdx(HashMap<String,String> paramap) {
		// 공지사항 게시물을 지우는 메소드
		int n = dao.delNoticeIdx(paramap);
		return n;
	}*//* ================================================================================================================================================== */
	@Override
	public int delNoticeIdx(HashMap<String, String> paramap, String[] idxArr) {
		// 공지사항 게시물을 지우는 메소드
		int n = dao.delNoticeIdx(paramap, idxArr);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public List<ReplyVO> getComment(HashMap<String, Object> map) {
		// 게시물을 볼 때 그 글의 리플을 보는 메소드
		List<ReplyVO> list = dao.getComment(map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public int setComment(HashMap<String, String> map) {
		// 공지사항 게시글에 리플 달기
		int n = dao.setComment(map);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public int updateReadCount(String nidx) {
		// 공지사항 글의 조회수 늘리는 메소드
		int n = dao.updateReadCount(nidx);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public int setNoticeWrite(HashMap<String, String> team) {
		// 공지사항 글쓰기 완료 메소드
		int n = dao.setNoticeWrite(team);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public int setNoticeEditWrite(HashMap<String, String> map) {
		// 수정글쓰기 입력 메소드
		int n = dao.setNoticeEditWrite(map);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getDepth(String parameter) {
		// 수정글의 depth, groupno를 구해온다.
		HashMap<String, String> depth = dao.getDepth(parameter);
		return depth;
	}
	@Override
	public int getCountReply(HashMap<String, Object> map) {
		// 리스트의 댓글 수 가져오기
		int count = dao.getCountReply(map);
		return count;
	}
	
	
//==========================================================================================================================================================//	

	
	
	
	
	
// === *** 마음의 소리 게시판 *** === //	
//==========================================================================================================================================================//	
	@Override
	public List<HashMap<String, String>> getMindList(HashMap<String, String> map, String str_sizePerPage, String str_currentPage) {
		// 마음의 소리 게시판의 검색된 모든 리스트를 가져오는 메소드 
		int sizePerPage=0;
		int currentPage=0;
		try{
			sizePerPage = Integer.parseInt(str_sizePerPage);
			if(sizePerPage==0) 
				sizePerPage=10;
			if(sizePerPage!=10&&sizePerPage!=5&&sizePerPage!=3)
				sizePerPage=10;
		}
		catch(NumberFormatException e) {
			sizePerPage = 10;
		}
		if(str_currentPage==null || "".equals(str_currentPage)) {
			currentPage = 1;
		}
		else {
			currentPage = Integer.parseInt(str_currentPage);	
		}
		int totalCount = dao.getMindCount(map);
		int totalPage=(int)Math.ceil((double)totalCount/sizePerPage);
		int blockSize=3;
		int sNum = ((currentPage - 1)*sizePerPage)+1;
		int eNum = sNum + sizePerPage - 1;
		String pagebar = MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentPage, map.get("searchType"), map.get("searchString"), null, "mindList.mr");
		map.put("sNum", String.valueOf(sNum));
		map.put("eNum", String.valueOf(eNum));
		
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("pagebar", pagebar);
	
		List<HashMap<String, String>> list = dao.getMindList(map);
		list.add(hashMap);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public String getMindJSONList(HashMap<String, String> map) {
		// 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
		List<String> list = dao.getMindJSONList(map);
		JSONArray jsonList = null;
		String searchString = "";
		if(list!=null&&list.size()>0) {
			jsonList = new JSONArray();
			for(String obj : list) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("search", obj);
				jsonList.put(jsonObj);
			}
			searchString = jsonList.toString();
		}
		else 
			searchString = "해당하는 검색정보가 없습니다.";
		return searchString;
	}
	@Override
	public HashMap<String, String> getMindIdxTeam(HashMap<String, String> view) {
		// 마음의 소리 글보기
		HashMap<String, String> map = dao.getMindIdxTeam(view);
		return map;
	}
	/*@Override
	public int setMindWrite(HashMap<String, String> team) {
		// 마음의 소리 글쓰기
		int n = dao.setMindWrite(team);
		return n;
	}*/
	@Override
	public HashMap<String, String> getMindDepth(String nidx) {
		// depth와 groupno가져오는 메소드
		HashMap<String, String> map = dao.getMindDepth(nidx);
		return map;
	}
	@Override
	public int updateMindReadCount(String idx) {
		// 조회수 올려주는 메소드
		int n = dao.updateMindReadCount(idx);
		return n;
	}
	@Override
	public int updateMindCheckNum(String nidx) {
		// 대기, 확인, 답변 변경해주는 메소드
		int n = dao.updateMindCheckNum(nidx);
		return n;
	}
	@Override
	public int delMindIdx(HashMap<String,String> paramap , String[] idxArr) {
		// 마음의 소리 다중 행 삭제
		int n = dao.delMindIdx(paramap,idxArr);
		return n;
	}
	
//==========================================================================================================================================================//	

	
	
	
	
// === *** 구글맵  *** === //	
//==========================================================================================================================================================//	
	@Override
	public List<MapVO> getMap(HashMap<String, String> map) {
		// 구글맵 테이블의 모든 정보를 가져온다.
		List<MapVO> list = dao.getMap(map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public List<MapVO> getMapWithSearch(HashMap<String, String> map) {
		// 검색어가 포함된 지도 리스트
		List<MapVO> list = dao.getMapWithSearch(map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public String getSearchJSON(HashMap<String, String> map) {
		// 구글맵 JSON 검색처리
		List<String> list = dao.getSearchJSON(map);
		JSONArray arr = new JSONArray();
		if(list!=null&&list.size()>0) {
			for(String obj : list) {
				JSONObject jsonobj = new JSONObject();
				jsonobj.put("searchString", obj);
				arr.put(jsonobj);
			}
		}
		String googleMap = arr.toString();
		return googleMap;
	}/* ================================================================================================================================================== */
	@Override
	public HashMap<String, String> getMapFood(String map_idx) {
		// 구글맵에서 음식점 마커 클릭 시 사용
		HashMap<String, String> googleMapFood = dao.getMapFood(map_idx);
		return googleMapFood;
	}/* ================================================================================================================================================== */
	@Override
	public List<HashMap<String, String>> getMapTeam(String map_idx) {
		// 구글맵에서 팀 정보 마커 클릭 시 사용
		List<HashMap<String, String>> googleMapTeam = dao.getMapTeam(map_idx);
		return googleMapTeam;
	}
	
//==========================================================================================================================================================//	

	
	
	
// === *** 쪽지 *** === //
//==========================================================================================================================================================//	
	@Override
	public int getSenderMemo(HashMap<String, String> map) {
		// 쪽지 보낸 사람의 보낸 쪽지 수를 반환하는 메소드
		int n = dao.getSenderMemo(map);
		return n;
	}
	@Override
	public List<HashMap<String, String>> getSenderMemoList(HashMap<String, String> map) {
		// sender가 보낸 쪽지 리스트를 반환한다.
		List<HashMap<String, String>> list = dao.getSenderMemoList(map);
		return list;
	}
	@Override
	public int getReceiverMemo(HashMap<String, String> map) {
		// 쪽지를 받은 사람의 받은 쪽지 갯수를 리턴
		int n = dao.getReceiverMemo(map);
		return n;
	}
	@Override
	public List<HashMap<String, String>> getReceiverMemoList(HashMap<String, String> map) {
		// 받은 쪽지 리스트를 반환
		List<HashMap<String, String>> list = dao.getReceiverMemoList(map);
		return list;
	}
	@Override
	public HashMap<String, String> getSenderIdx(HashMap<String, String> info) {
		// idx에 해당하는 sender테이블의 정보를 가져온다.
		HashMap<String, String> map = dao.getSenderIdx(info);
		return map;
	}
	@Override
	public HashMap<String, String> getReceiverIdx(HashMap<String, String> info) {
		// idx에 해당하는 Receiver테이블의 정보를 가져온다.
		HashMap<String, String> map = dao.getReceiverIdx(info);
		return map;
	}
	@Override
	public List<String> getReceiverNames(HashMap<String, String> map) {
		// 메모 받은 사람의 리스트를 받아온다.
		List<String> nameArr = dao.getReceiverNames(map);
		return nameArr;
	}
	@Override
	public int delSenderMemo(HashMap<String,String[]> idx) {
		// 해당 idx 보낸쪽지를 삭제한다.
		int n = dao.delSenderMemo(idx);
		return n;
	}
	@Override
	public int delReceiverMemo(HashMap<String, String[]> idx) {
		// 해당 idx의 받은 쪽지를 삭제한다.
		int n = dao.delReceiverMemo(idx);
		return n;
	}
	@Override
	public int updateRreadCount(String idx, String userid) {
		// 쪽지를 받은 사람이 읽었는지 않 읽었는지 update
		int n = dao.updateRreadCount(idx, userid);
		return n;
	}
	@Override
	public List<HashMap<String, String>> getTeam(String teamNum) {
		// 쪽지를 쓸 팀이름을 가져온다.
		List<HashMap<String, String>> list = dao.getTeam(teamNum);
		return list;
	}
	/*@Override
	public List<HashMap<String, String>> getAllMember() {
		// 쪽지를 쓸 모든 멤버이름을 가져온다.
		List<HashMap<String, String>> list = dao.getAllMember();
		return list;
	}*/
	/*@Override
	public String getCheckNum(HashMap<String, String> map) {
		// 몇명이 읽었는지 반환
		String list = dao.getCheckNum(map);
		return list;
	}*/
	@Override
	public int checkReadCount(String parameter) {
		// readcount가 1인지 0인지 알아오자 몰라서 편법씀
		int readcount = dao.checkReadCount(parameter);
		return readcount;
	}
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertMemo(HashMap<String, Object> map, List<String> list) {
		// 메모입력
		int n = dao.insertsender(map);
		System.out.println("=========여기오니????=========="+n);
		String idx = dao.getSenderLastIdx(map);
		System.out.println("===============idx================"+idx);
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map2.put("idx", idx);
		int z=1;
		int m=0;
		for(int i=0; i<list.size(); i++) {
			System.out.println("===============list=================="+list.get(i));
			map2.put("userid", list.get(i));
			m = dao.insertreceiver(map2);
			System.out.println("================m=================="+m);
			z *= m;
		}
		return (n*z);
	}
	
	
	
//==========================================================================================================================================================//	

	
	
	@Override
	public HashMap<String, String> getUserTeam(HashMap<String, String> team) {
		// 로그인한 유저의 팀정보를 가져오는 메소드
		HashMap<String, String> userTeam = dao.getUserTeam(team);
		return userTeam;
	}
	@Override
	public String getMessage(HashMap<String, String> map) {
		// 알람 ajax버전
		String num = dao.getMessage(map);
		return num;
	}
	
	
	@Override // 공지사항 파일 업로드
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int setNoticeWriteWithFile(HashMap<String, String> team) {
		// TODO Auto-generated method stub
		int n = dao.setNoticeWrite(team);
		int m = dao.setNoticeWriteWithFile(team);
		return (n*m);
	}
	@Override
	public String getfilenamelist(HashMap<String, Object> map) {
		// TODO 공지사항글에 파일이 있는지 없는지
		String file = dao.getfilenamelist(map);
		return file;
	}
	@Override
	public FileVO getViewWithNoAddCount(HashMap<String, String> map) {
		// 파일 다운로드
		
		FileVO vo = dao.getViewWithNoAddCount(map);
		return vo;
	}
	@Override
	public String getmemoReadCount(String string) {
		// 메모 읽었는지 여부 반환
		String memo = dao.getmemoReadCount(string);
		return memo;
	}
	@Override
	public NoticeFileVO getfilename(String nidx) {
		// 뷰에 보여줄 파일 가져오기
		NoticeFileVO file = dao.getfilename(nidx);
		return file;
	}
	@Override
	public int setUpdateWrite(HashMap<String, String> team) {
		// 공지사항 수정하기
		int n = dao.setUpdateWrite(team);
		return n;
	}
	@Override
	public int setMindWrite(HashMap<String, String> team) {
		// 마음의 소리 글쓰기
		int n= dao.setMindWrite(team);
		return n;
	}
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int setMindWriteWithFile(HashMap<String, String> team) {
		// 마음의 소리 글쓰기 파일첨부
		int m=dao.setMindWrite(team);
		String a = dao.getMindWrite(team);
		team.put("idx", a);
		int n=dao.setMindWriteWithFile(team);
		return (m*n);
	}
	@Override
	public int getReplyCount(HashMap<String, Object> map) {
		// 리플 글 총 수
		int n = dao.getReplyCount(map);
		return n;
	}
	@Override
	public int setMindViewEdit(HashMap<String, String> team) {
		// 글 수정
		int n = dao.setMindViewEdit(team);
		return n;
	}
	@Override
	public String getMindfilenamelist(HashMap<String, String> map) {
		// 마음의 소리에 파일이 있는지 없는지 반환
		String n = dao.getMindfilenamelist(map);
		return n;
	}
	@Override
	public MindFileVO getMindfilename(String idx) {
		// 마음의 소리에 파일vo를 반환
		MindFileVO vo = dao.getMindfilename(idx);
		return vo;
	}
	@Override
	public FileVO getmindViewWithNoAddCount(HashMap<String, String> map) {
		// 마음의 소리 파일 가져오기
		FileVO vo = dao.getmindViewWithNoAddCount(map);
		return vo;
	}
	@Override
	public HashMap<String, String> getNoticeInfo(HashMap<String, String> view) {
		// 공지사항 정보
		HashMap<String, String> map = dao.getNoticeInfo(view);
		return map;
	}
	
	
	

	
}	
