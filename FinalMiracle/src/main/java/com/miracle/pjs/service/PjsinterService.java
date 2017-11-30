package com.miracle.pjs.service;

import java.util.HashMap;
import java.util.List;

public interface PjsinterService {

	List<HashMap<String, String>> getNoticeList(HashMap<String, String> map);  // 공지사항 게시판 페이징리스트를 가져오는 메소드

	int getTotalCount(HashMap<String, String> map); // 공지사항 테이블의 전체 행 수를 반환하는 메소드

}
