package com.miracle.jsw.service;

import java.util.HashMap;
import java.util.List;

public interface InterChattingService {

	List<HashMap<String, Object>> getChatRoom(int idx);

	List<HashMap<String, Object>> getChattingContent(String cridx);

	void chatting(HashMap<String, Object> map);

	void read(HashMap<String, Object> map);

	List<HashMap<String, Object>> getChattingMember(String cridx);

	List<HashMap<String, Object>> getAllTeam();

	List<HashMap<String, Object>> getTeamwonNotMe(HashMap<String, Object> map);

	List<HashMap<String, Object>> getAllNotMe(int idx);

	List<HashMap<String, Object>> getFindNotMe(HashMap<String, Object> map);

	


}
