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

	List<FreeBoardVO> freeList();

	int freeAdd(FreeBoardVO freevo);  // 자유게시판 글쓰기

	FreeBoardVO getView(String idx);  // 자유게시판 선택한 게시글 1개 보여주기

	void setAddReadCnt(String idx);  // 다른 사용자가 글 조회시 readCnt 1 증가 시키기

	
	

}
