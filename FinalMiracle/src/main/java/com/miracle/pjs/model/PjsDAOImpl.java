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
	
	// === *** 공지사항 게시판 *** //
	/*=======================================================================================================================================================*/
	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> map) {
		// 공지사항 게시판 페이징리스트를 가져오는 메소드
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getNoticeList", map);
		return list;
	}/*=======================================================================================================================================================*/

	@Override
	public int getNoticeCount(HashMap<String, String> map) {
		// 공지사항 게시판의 전체 행 수를 반환
		int cnt = sqlsession.selectOne("pjsfinal.getCount", map);
		return cnt;
	}/*=======================================================================================================================================================*/

	@Override
	public List<String> getNoticeJSONList(HashMap<String, String> map) {
		// 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
		List<String> list = sqlsession.selectList("pjsfinal.getNoticeJSONList",map);
		return list;
	}/*=======================================================================================================================================================*/

	
	
	// === *** 마음의 소리 게시판 *** //
	/*=======================================================================================================================================================*/
	@Override
	public List<HashMap<String, String>> getMindList(HashMap<String, String> map) {
		// 마음의 소리 게시판 전체리스트 반환
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getMindList", map);
		System.out.println("list는 "+list.size());
		return list;
	}/*=======================================================================================================================================================*/
	@Override
	public int getMindCount(HashMap<String, String> map) {
		// 마음의 소리 게시판에 검색된 행의 수를 반환한다.
		int cnt = sqlsession.selectOne("pjsfinal.getMindCount",map); 
		return cnt;
	}/*=======================================================================================================================================================*/


}
