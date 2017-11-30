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

	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> map) {
		// 공지사항 게시판 페이징리스트를 가져오는 메소드
		List<HashMap<String, String>> list = sqlsession.selectList("pjsfinal.getNoticeList", map);
		return list;
	}/*=======================================================================================================================================================*/

	@Override
	public int getCount(HashMap<String, String> map) {
		// 공지사항 게시판의 전체 행 수를 반환
		int cnt = sqlsession.selectOne("pjsfinal.getCount", map);
		return cnt;
	}/*=======================================================================================================================================================*/

}
