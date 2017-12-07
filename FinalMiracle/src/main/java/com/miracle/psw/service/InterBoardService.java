package com.miracle.psw.service;

import java.util.HashMap;
import java.util.List;

import com.miracle.psw.model.FaqBoardVO;

public interface InterBoardService {

	List<FaqBoardVO> faqList();

	List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map); 

	List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map);

	int getTotalCountWithSearch(HashMap<String, String> map); 
	
	int getTotalCountWithNoSearch();

	int add(FaqBoardVO faqvo); // FAQ 게시판 글쓰기

 

	

}
