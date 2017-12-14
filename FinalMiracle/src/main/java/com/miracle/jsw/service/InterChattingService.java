package com.miracle.jsw.service;

import java.util.HashMap;
import java.util.List;

public interface InterChattingService {

	List<HashMap<String, Object>> getChatRoom(int idx);

	List<HashMap<String, Object>> getChattingContent(String cridx);

	void chatting(HashMap<String, Object> map);

	


}
