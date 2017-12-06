package com.miracle.psw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.model.InterBoardDAO;

@Service
public class BoardService implements InterBoardService {

	@Autowired
	private InterBoardDAO dao;

	@Override
	public List<FaqBoardVO> faqList() {
		List<FaqBoardVO> list = dao.faqList();
		return list;
	}

	@Override
	public List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map) {
		List<FaqBoardVO> vo = dao.faqListWithSearch(map);
		return vo;
	}

	@Override
	public List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map) {
		List<FaqBoardVO> vo = dao.faqListWithNoSearch(map);
		return vo;
	}

	@Override
	public int getTotalCountWithSearch(HashMap<String, String> map) {
		int cnt = dao.getTotalCountWithSearch(map);
		return cnt;
	}

	@Override
	public int getTotalCountWithNoSearch() {
		int cnt = dao.getTotalCountWithNoSearch();
		return cnt;
	}

	
	
}
