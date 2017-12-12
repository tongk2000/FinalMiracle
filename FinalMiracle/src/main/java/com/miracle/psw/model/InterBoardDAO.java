package com.miracle.psw.model;

import java.util.HashMap;
import java.util.List;

public interface InterBoardDAO {

	List<FaqBoardVO> faqList();

	List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map);
	List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map);

	int getTotalCountWithSearch(HashMap<String, String> map);
	int getTotalCountWithNoSearch(HashMap<String, String> map);

	int add(FaqBoardVO faqvo);  // FAQ 게시판 글쓰기

	// ======================================================= *** 자유게시판 *** =======================
	List<FreeBoardVO> freeList();

	int freeAdd(FreeBoardVO freevo);  // 자유게시판 글쓰기

	FreeBoardVO getView(String idx);  // 자유게시판 선택한 게시글 1개 보여주기

	void setAddReadCnt(String idx);  // 다른 사용자가 글 조회시 readCnt 1 증가 시키기
	
	List<FreeBoardVO> freeListWithNoSearch(HashMap<String, String> map);
	List<FreeBoardVO> freeListWithSearch(HashMap<String, String> map);

	int getFreeTotalCountWithSearch(HashMap<String, String> map);
	int getFreeTotalCountWithNoSearch(HashMap<String, String> map);

	int freeEdit(HashMap<String, Object> map);  // 1개 글 수정하기.

	// ===================== *** 자유게시판 댓글 쓰기 Transaction *** ========================================
	int addComment(FreeCommentVO commentvo);  // tbl_freeComment 테이블에 1개 행 insert
	int updateCommentCnt(int parentIdx);  // tbl_free 테이블의 commentCnt 컬럼의 값을 1 증가

	List<FreeCommentVO> freeListComment(String idx);  // 댓글 목록 보여주기

	MemberVO showUserInfo(HashMap<String, Object> map);
	MemberDetailVO showUserDetailInfo(HashMap<String, Object> map);

	
	

}
