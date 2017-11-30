package com.miracle.jsw.model;

import java.util.HashMap;
import java.util.List;

public interface InterCommuteDAO {

	int startWork(); // 파워출근

	int endWork(); // 파워퇴근

	List<HashMap<String, String>> commuteList(HashMap<String, String> map); // 출퇴근 리스트를 불러옴
	
	List<HashMap<String, String>> commuteListMonth(HashMap<String, String> map); // 출퇴근 리스트를 불러옴(월별 검색)

	int getTotalCountMonth(HashMap<String, String> map); // 총 페이지수

	int getTotalCount(); // 총 페이지수

}
