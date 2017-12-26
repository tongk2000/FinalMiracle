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

	@Override
	public void read(HashMap<String, Object> map) {
		sqlsession.update("chatting.read", map);
		
	}

	@Override
	public List<HashMap<String, Object>> getChattingMember(String cridx) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getChattingMember",cridx);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getAllTeam() {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getAllTeam");
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getTeamwonNotMe(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getTeamwonNotMe", map);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getAllNotMe(int idx) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getAllNotMe", idx);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getFindNotMe(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getFindNotMe", map);
		return list;
	}

	@Override
	public int newRoom(HashMap<String, Object> map) {
		int n = sqlsession.insert("chatting.newRoom", map);
		return n;
	}

	@Override
	public int newRoomMember(HashMap<String, Object> map) {
		int n = sqlsession.insert("chatting.newRoomMember", map);
		return n;
	}

	@Override
	public String getCRidxNewRoom() {
		String n = sqlsession.selectOne("chatting.getCRidxNewRoom");
		return n;
	}

	@Override
	public void newRoomNewMember(HashMap<String, Object> map) {
		sqlsession.insert("chatting.newRoomNewMember", map);
	}
	@Override
	public void newRoomNewMember2(HashMap<String, String> map) {
		sqlsession.insert("chatting.newRoomNewMember", map);
	}

	@Override
	public int addMemberCount(HashMap<String, Object> map) {
		int n = sqlsession.update("chatting.addMemberCount", map);
		return n;
	}

	@Override
	public void addMemberCnt(String cridx) {
		sqlsession.update("chatting.addMemberCnt", cridx);
		
	}

	@Override
	public void outRoom(HashMap<String, Object> map) {
		sqlsession.update("chatting.outRoom", map);
		
	}

	@Override
	public void outRoomCnt(String cridx) {
		sqlsession.update("chatting.outRoomCnt", cridx);
		
	}

	@Override
	public String[] getChattingRoomMember(String cridx) {
		List<String> list = sqlsession.selectList("chatting.getChattingRoomMember", cridx);
		
		String[] strArr = null;
		
		if (list != null && list.size() > 0) {
		    strArr = new String[list.size()];
	
			for(int i=0; i<list.size(); i++) {
				strArr[i] = list.get(i);
			}	
		}
		
		return strArr;
	}

	@Override
	public List<HashMap<String, Object>> getTeamwonNotChatMember(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getTeamwonNotChatMember", map);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getAllNotChatMember(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getAllNotChatMember", map);
		return list;
	}

	@Override
	public List<HashMap<String, Object>> getFindNotChatMember(HashMap<String, Object> map) {
		List<HashMap<String, Object>> list = sqlsession.selectList("chatting.getFindNotChatMember", map);
		return list;
	}

	@Override
	public HashMap<String, Object> getRoomInfo(HashMap<String, Object> map) {
		HashMap<String, Object> RoomInfo = sqlsession.selectOne("chatting.getRoomInfo", map);
		return RoomInfo;
	}


	

}
