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

	@Override
	public List<HashMap<String, Object>> getChattingContent(String cridx) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getChattingContent",cridx);
		return list;
	}

	@Override
	public void insertMessage(HashMap<String, Object> map) {
		sqlsession.insert("chatting.insertMessage",map);
		
	}

	@Override
	public void notreadmessage(HashMap<String, Object> map) {
		sqlsession.update("chatting.notreadmessage",map);
		
	}


	

}
