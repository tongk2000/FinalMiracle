package com.miracle.ksh.model;

import java.util.HashMap;
import java.util.List;

public interface InterTMDAO {

	List<HashMap<String, String>> tmList1(HashMap<String, String> tmMap); //팀원 리스트를 받아오자 (노 검색)

	List<HashMap<String, String>> tmList2(HashMap<String, String> tmMap); //팀원 리스트를 받아오자 (예스 검색)

	int TMTotalCount1(HashMap<String, String> tmMap); //팀원 리스트의 총 인원을 알아오자 (노 검색)

	int TMTotalCount2(HashMap<String, String> tmMap); //팀원 리스트의 총 인원을 알아오자 (예스 검색)

	List<HashMap<String, String>> getTeamList1(String fk_member_idx); //자기가 팀장인 팀 리스트를 뽑아오자

	List<HashMap<String, String>> getTeamList2(String fk_member_idx); //자기가 팀원인 팀 리스트를 뽑아오자

	int TeamCreate(HashMap<String, String> tmMap); //팀을 생성해보자

	String getTeamwonIDX(HashMap<String, String> map); //세션에 넣을 팀원번호를 받아오자

	String getTeamwonStatus(HashMap<String, String> map); //세션에 넣을 팀원의 status 값을 받아오자

	List<HashMap<String, String>> tmAddrList1(HashMap<String, String> tmMap);  //팀원들의 주소록을 뽑아보자

	List<HashMap<String, String>> tmAddrList2(HashMap<String, String> tmMap); //팀원들의 주소록을 뽑아보자 (예스 검색)

}
