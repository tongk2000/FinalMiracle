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

	// ===================================== *** 검색 유무에 따른 자유게시판 목록 보여주기 *** =========================================
	@Override
	public List<FreeBoardVO> freeListWithNoSearch(HashMap<String, String> map) {
		List<FreeBoardVO> vo = sqlsession.selectList("board_psw.freeListWithNoSearch", map);
		return vo;
	}
	@Override
	public List<FreeBoardVO> freeListWithSearch(HashMap<String, String> map) {
		List<FreeBoardVO> vo = sqlsession.selectList("board_psw.freeListWithSearch", map);
		return vo;
	}

	// ===================================== *** 자유게시판 검색 유/무에 따른 총 페이지 값 알아오기 *** ====================================
	@Override
	public int getFreeTotalCountWithSearch(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("board_psw.getFreeTotalCountWithSearch", map);
		return cnt;
	}
	@Override
	public int getFreeTotalCountWithNoSearch(HashMap<String, String> map) {
		int cnt = sqlsession.selectOne("board_psw.getFreeTotalCountWithNoSearch", map);
		return cnt;
	}

	// ========================================= *** 자유게시판 해당 게시글 수정하기(본인만 가능) *** ====================================
	@Override
	public int freeEdit(HashMap<String, Object> map) {
		int n = sqlsession.update("board_psw.freeEdit", map);
		return n;
	}

	// ========================================= *** 자유게시판 댓글 쓰기 (Transaction) *** ========================================
	@Override
	public int addComment(FreeCommentVO commentvo) {  // tbl_freeComment에 1개 행 삽입 (insert)
		int n = sqlsession.insert("board_psw.addComment", commentvo);
		return n;
	}
	@Override
	public int updateCommentCnt(int parentIdx) {  // tbl_free 테이블의 commentCnt 컬럼의 값을 1 증가(update)
		int n = sqlsession.update("board_psw.updateCommentCnt", parentIdx);
		return n;
	}

	@Override
	public List<FreeCommentVO> freeListComment(String idx) {  // 댓글 목록 보여주기
		List<FreeCommentVO> list = sqlsession.selectList("board_psw.freeListComment", idx);
		return list;
	}
	// ====================== *** 자유게시판 목록에서 선택한 유저정보 보여주기 *** ============================
	@Override
	public MemberVO showUserInfo(HashMap<String, Object> map) {
		MemberVO vo = sqlsession.selectOne("board_psw.showUserInfo", map);
		return vo;
	}
	@Override
	public MemberDetailVO showUserDetailInfo(HashMap<String, Object> map) {
		MemberDetailVO vo = sqlsession.selectOne("board_psw.showUserDetailInfo", map);
		return vo;
	}
	
	

	
	
	
	
	
}









