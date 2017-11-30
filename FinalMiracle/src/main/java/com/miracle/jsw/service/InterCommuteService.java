package com.miracle.jsw.service;

import java.util.HashMap;
import java.util.List;

public interface InterCommuteService {

	List<HashMap<String, String>> commuteList(); // 출퇴근 리스트를 불러옴

	int startWork(); // 파워출근

	int endWork(); // 파워퇴근

}
