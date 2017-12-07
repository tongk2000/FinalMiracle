package com.miracle.psw.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements InterBoardDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<FaqBoardVO> faqList() {
		List<FaqBoardVO> list = sqlsession.selectList("board_psw.faqList");
		return list;
	}

	@Override
	public List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map) {
		List<FaqBoardVO> vo = sqlsession.selectList("board_psw.faqListWithSearch", map);
		return vo;
	}

	@Override
	public List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map) {
		List<FaqBoardVO> vo = sqlsession.selectList("board_psw.faqListWithNoSearch", map);
		return vo;
	}

	@Override
	public int getTotalCountWithSearch(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("board_psw.getTotalCountWithSearch", map);
		return cnt;
	}

	@Override
	public int getTotalCountWithNoSearch() {
		int cnt = sqlsession.selectOne("board_psw.getTotalCountWithNoSearch");
		return cnt;
	}

	@Override
	public int add(FaqBoardVO faqvo) {  // FAQ 게시판 글쓰기
		int n = sqlsession.insert("board_psw.add", faqvo);
		
		return n;
	}

	
	
	
	
	
}
