package com.miracle.ksh.model;

import java.util.HashMap;
import java.util.List;

public interface InterTMDAO {

	List<HashMap<String, String>> tmList1(HashMap<String, String> tmMap); //팀원 리스트를 받아오자 (노 검색)

	List<HashMap<String, String>> tmList2(HashMap<String, String> tmMap); //팀원 리스트를 받아오자 (예스 검색)

	int TMTotalCount1(HashMap<String, String> tmMap); //팀원 리스트의 총 인원을 알아오자 (노 검색)

	int TMTotalCount2(HashMap<String, String> tmMap); //팀원 리스트의 총 인원을 알아오자 (예스 검색)

}
