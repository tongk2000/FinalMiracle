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
	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> map) {
		// 공지사항 게시판 페이징리스트를 가져오는 메소드
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getNoticeList", map);
		return list;
	}/* ================================================================================================================================================== */
	@Override
	public int getNoticeCount(HashMap<String, String> map) {
		// 공지사항 게시판의 전체 행 수를 반환
		int cnt = sqlsession.selectOne("pjsfinal.getCount", map);
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
	public HashMap<String, String> getIdxTeam(String idx) {
		// 공지사항 게시판의 해당 행의 내용을 보여주는 메소드
		HashMap<String, String> map = sqlsession.selectOne("pjsfinal.getIdxTeam", idx);
		return map;
	}/* ================================================================================================================================================== */
	@Override
	public int delNoticeIdx(String idx) {
		// 공지사항 게시물을 지우는 메소드
		int n = sqlsession.delete("pjsfinal.delNoticeIdx", idx);
		System.out.println("======================n======================="+n);
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
		System.out.println("searchType : "+map.get("searchType"));
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
		System.out.println("===================map.get================="+map.get("choice"));
		System.out.println("===================map.get================="+map.get("searchString"));
		List<String> list = sqlsession.selectList("pjsfinal.getSearchJSON", map);
		for(int i=0; i<list.size(); i++) {
			System.out.println("===================list.get================="+list.get(i));
		}
		return list;
	}
	
//==========================================================================================================================================================//	

	
	@Override
	public HashMap<String, String> getUserTeam(String userid) {
		// 로그인한 유저의 팀정보를 가져오는 메소드
		HashMap<String, String> userTeam = sqlsession.selectOne("pjsfinal.getUserTeam", userid); 
		return userTeam;
	}
	

}
