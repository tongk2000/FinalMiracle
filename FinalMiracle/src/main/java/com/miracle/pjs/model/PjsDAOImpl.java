package com.miracle.pjs.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PjsDAOImpl implements PjsinterDAO {
	
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
	@Override
	public int delNoticeIdx(String idx) {
		// 공지사항 게시물을 지우는 메소드
		int n = sqlsession.update("pjsfinal.delNoticeIdx", idx);
		return n;
	}/* ================================================================================================================================================== */
	@Override
	public List<ReplyVO> getComment(String idx) {
		// 공지사항 게시물의 리플을 얻어오는 메소드
		List<ReplyVO> list = sqlsession.selectList("pjsfinal.getComment", idx);
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
		System.out.println("==============조회수 늘어났나오?=============="+n);
		return n;
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
	

//==========================================================================================================================================================//	
	
	
	// === *** 구글맵 *** === //
	@Override
	public List<MapVO> getMap() {
		// 구글맵 테이블의 전체 내용을 가져온다.
		List<MapVO> list = sqlsession.selectList("pjsfinal.getMap");
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

	
	@Override
	public HashMap<String, String> getUserTeam(HashMap<String, String> map) {
		// 로그인한 유저의 팀정보를 가져오는 메소드
		HashMap<String, String> userTeam = sqlsession.selectOne("pjsfinal.getUserTeam", map);
		return userTeam;
	}
	
	

}
