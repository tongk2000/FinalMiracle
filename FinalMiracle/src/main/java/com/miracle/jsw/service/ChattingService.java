package com.miracle.jsw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.jsw.model.InterChattingDAO;

@Service
public class ChattingService implements InterChattingService {

	
	@Autowired
	private InterChattingDAO dao;

	@Override
	public List<HashMap<String, Object>> getChatRoom(int idx) {
		List<HashMap<String, Object>> list = dao.getChatRoom(idx);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getChattingContent(String cridx) {
		List<HashMap<String, Object>> list = dao.getChattingContent(cridx);
		return list;
	}

	@Override
	public void chatting(HashMap<String, Object> map) {
		dao.insertMessage(map);
		dao.notreadmessage(map);
	}

	@Override
	public void read(HashMap<String, Object> map) {
		dao.read(map);
		
	}

	@Override
	public List<HashMap<String, Object>> getChattingMember(String cridx) {
		List<HashMap<String, Object>> list = dao.getChattingMember(cridx);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getAllTeam() {
		List<HashMap<String, Object>> list = dao.getAllTeam();
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getTeamwonNotMe(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = dao.getTeamwonNotMe(map);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getAllNotMe(int idx) {
		List<HashMap<String, Object>> list = dao.getAllNotMe(idx);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getFindNotMe(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = dao.getFindNotMe(map);
		return list;
	}

	
	
	
}
