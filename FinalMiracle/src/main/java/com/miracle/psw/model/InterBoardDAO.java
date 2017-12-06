package com.miracle.psw.model;

import java.util.HashMap;
import java.util.List;

public interface InterBoardDAO {

	List<FaqBoardVO> faqList();

	List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map);

	List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map);

	int getTotalCountWithSearch(HashMap<String, String> map);

	int getTotalCountWithNoSearch();

	
	

}
