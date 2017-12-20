package com.miracle.jsw.model;

import java.util.HashMap;
import java.util.List;

public interface InterCommuteDAO {

	int startWork(int idx); // 파워출근

	int endWork(int idx); // 파워퇴근

	List<HashMap<String, String>> commuteList(HashMap<String, String> map); // 출퇴근 리스트를 불러옴
	
	List<HashMap<String, String>> commuteListMonth(HashMap<String, String> map); // 출퇴근 리스트를 불러옴(월별 검색)

	int getTotalCountMonth(HashMap<String, String> map); // 총 페이지수

	int getTotalCount(HashMap<String, String> map); // 총 페이지수

	List<HashMap<String, String>> getTeamWonList(HashMap<String, String> map); // 팀장이 팀원들의 정보를 불러오는 메소드

	List<HashMap<String, String>> twcommuteListMonth(HashMap<String, String> map);  // 팀원의 출퇴근 리스트를 불러옴(월별 검색)

	int getTWTotalCountMonth(HashMap<String, String> map); // 총 페이지수

	List<HashMap<String, String>> twcommuteList(HashMap<String, String> map);  // 팀원의 출퇴근 리스트를 불러옴

	int getTWTotalCount(HashMap<String, String> map); // 총 페이지수

	int startWorkLate(int idx);

	int endWorkEarly(int idx);

	int workLateAndEarlyGo(int idx);

	List<HashMap<String, String>> getUserTeamDetail(HashMap<String, String> map);

	List<HashMap<String, String>> getStatistics(HashMap<String, String> map);

}
