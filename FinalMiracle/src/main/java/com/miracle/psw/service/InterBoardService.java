package com.miracle.psw.service;

import java.util.HashMap;
import java.util.List;

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.model.FreeBoardVO;

public interface InterBoardService {

	List<FaqBoardVO> faqList();

	List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map); 
	List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map);

	int getTotalCountWithSearch(HashMap<String, String> map); 
	int getTotalCountWithNoSearch(HashMap<String, String> map);

	int add(FaqBoardVO faqvo); // FAQ 게시판 글쓰기

	List<FreeBoardVO> freeList();

	int freeAdd(FreeBoardVO freevo);  // 자유게시판 글쓰기

	FreeBoardVO getView(String idx, String userid);  // 자유게시판 클릭한 게시글 1개 보여주기
	FreeBoardVO getViewWithNoReadCnt(String idx);  // F5 눌렀을때 조회수 증가시키지 않기

	List<FreeBoardVO> freeListWithNoSearch(HashMap<String, String> map);  
	List<FreeBoardVO> freeListWithSearch(HashMap<String, String> map);

	int getFreeTotalCountWithSearch(HashMap<String, String> map);
	int getFreeTotalCountWithNoSearch(HashMap<String, String> map);

 

	

}







