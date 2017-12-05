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

	
	
}
