package com.miracle.pjs.model;

import java.util.HashMap;
import java.util.List;

public interface PjsinterDAO {

	List<HashMap<String, String>> getNoticeList(HashMap<String, String> map);  // 공지사항 게시판의 검색 리스트를 가져오는 메소드

	int getCount(HashMap<String, String> map); // 공지사항 게시판 페이징리스트를 가져오는 메소드
}
