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

	
	
	
	
	
}
