package com.miracle.jsw.model;

import java.util.HashMap;
import java.util.List;

public interface InterChattingDAO {

	List<HashMap<String, Object>> getChatRoom(int idx);

	List<HashMap<String, Object>> getChattingContent(String cridx);

	void insertMessage(HashMap<String, Object> map);

	void notreadmessage(HashMap<String, Object> map);


}
