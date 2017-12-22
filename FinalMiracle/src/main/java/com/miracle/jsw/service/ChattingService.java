package com.miracle.jsw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int newRoom(HashMap<String, Object> map) throws Throwable{
		int n = dao.newRoom(map);
		int m = dao.newRoomMember(map);
		int z = dao.addMemberCount(map);
		return (n+m+z);
	}

	@Override
	public String getCRidxNewRoom() {
		String n = dao.getCRidxNewRoom();
		return n;
	}

	@Override
	public void newRoomNewMember(HashMap<String, Object> map) {
		dao.newRoomNewMember(map);
	}

	@Override
	public void addMemberCnt(String cridx) {
		dao.addMemberCnt(cridx);
		
	}

	@Override
	public void outRoom(HashMap<String, Object> map) {
		dao.outRoom(map);
		
	}

	@Override
	public void outRoomCnt(String cridx) {
		dao.outRoomCnt(cridx);
		
	}

	@Override
	public String[] getChattingRoomMember(String cridx) {
		String[] Arr = dao.getChattingRoomMember(cridx);
		return Arr;
	}

	@Override
	public List<HashMap<String, Object>> getTeamwonNotChatMember(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = dao.getTeamwonNotChatMember(map);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getAllNotChatMember(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = dao.getAllNotChatMember(map);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getFindNotChatMember(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = dao.getFindNotChatMember(map);
		return list;
	}

	@Override
	public HashMap<String, Object> getRoomInfo(HashMap<String, Object> map) {
		HashMap<String, Object> getRoomInfo = dao.getRoomInfo(map);
		return getRoomInfo;
	}

	
	
	
}
