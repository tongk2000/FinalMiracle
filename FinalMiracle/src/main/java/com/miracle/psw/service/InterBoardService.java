package com.miracle.psw.service;

import java.util.HashMap;
import java.util.List;

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.model.FreeBoardVO;
import com.miracle.psw.model.FreeCommentVO;
import com.miracle.psw.model.MemberDetailVO;
import com.miracle.psw.model.MemberVO;

public interface InterBoardService {

	List<FaqBoardVO> faqList();

	List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map); 
	List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map);

	int getTotalCountWithSearch(HashMap<String, String> map); 
	int getTotalCountWithNoSearch(HashMap<String, String> map);

	int add(FaqBoardVO faqvo); // FAQ 게시판 글쓰기

	
	// =================================================== *** 자유게시판 *** ========================================
	List<FreeBoardVO> freeList();

	int freeAdd(FreeBoardVO freevo);  // 자유게시판 글쓰기

	FreeBoardVO getView(String idx, String userid);  // 자유게시판 클릭한 게시글 1개 보여주기	
	
	FreeBoardVO getViewWithNoReadCnt(String idx);  // 조회수 증가 없이 1개 글 보여주기


	List<FreeBoardVO> freeListWithNoSearch(HashMap<String, String> map);  
	List<FreeBoardVO> freeListWithSearch(HashMap<String, String> map);

	int getFreeTotalCountWithSearch(HashMap<String, String> map);
	int getFreeTotalCountWithNoSearch(HashMap<String, String> map);

	int freeEdit(HashMap<String, Object> map);

	int addComment(FreeCommentVO commentvo) throws Throwable;  // 자유게시판 글 1개 보기 밑에 댓글 작성하기 기능 추가

	List<FreeCommentVO> freeListComment(String idx);  // 자유게시판 작성된 댓글 목록 보여주기

	MemberVO showUserInfo(HashMap<String, Object> map);
	MemberDetailVO showUserDetailInfo(HashMap<String, Object> map);

	int delFree(String idx) throws Throwable;  // 자유게시판 글 삭제 하기(update방식)







	



 

	

}







