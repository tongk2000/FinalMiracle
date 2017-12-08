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
	public int getTotalCountWithNoSearch(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("board_psw.getTotalCountWithNoSearch", map);
		return cnt;
	}

	@Override
	public int add(FaqBoardVO faqvo) {  // FAQ 게시판 글쓰기
		int n = sqlsession.insert("board_psw.add", faqvo);
		
		return n;
	}

	// ================================================================== *** 자유게시판 *** ==============================
	@Override
	public List<FreeBoardVO> freeList() {
		List<FreeBoardVO> vo = sqlsession.selectList("board_psw.freeList");
		return vo;
	}

	@Override
	public int freeAdd(FreeBoardVO freevo) {
		int n = sqlsession.insert("board_psw.freeAdd", freevo);
		return n;
	}

	@Override
	public FreeBoardVO getView(String idx) {  // 선택한 1개 글 보여주기
		FreeBoardVO vo = sqlsession.selectOne("board_psw.getView", idx);
		return vo;
	}

	@Override
	public void setAddReadCnt(String idx) {  // 선택한 1개 글이 다른 사용자의 글일 경우 readCnt 1 증가시키기
		sqlsession.update("board_psw.setAddReadCnt", idx);	
	}

	
	
	
	
	
}









