package com.miracle.jsw.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChattingDAO implements InterChattingDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<HashMap<String, Object>> getChatRoom(int idx) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getChatRoom",idx);
		return list;
	}

	

}
