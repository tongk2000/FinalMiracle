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

	List<HashMap<String, String>> tmAddrList1(HashMap<String, String> tmMap);  //팀원들의 주소록을 뽑아보자 (노 검색)

	List<HashMap<String, String>> tmAddrList2(HashMap<String, String> tmMap); //팀원들의 주소록을 뽑아보자 (예스 검색)

	int tmWithDraw(HashMap<String, String> map);  //팀 탈퇴 요청을 해보자

	List<HashMap<String, String>> tmReqWithDrawList1(HashMap<String, String> map1); //탈퇴 요청한 리스트를 뽑아보자 (노 검색)
	
	List<HashMap<String, String>> tmReqWithDrawList2(HashMap<String, String> map1); //탈퇴 요청한 리스트를 뽑아보자 (예스 검색)
	
	int TMReqWDTotalCount1(HashMap<String, String> map1); //탈퇴 요청한 총 개수를 구해보자 (노 검색)
	
	int TMReqWDTotalCount2(HashMap<String, String> map1); //탈퇴 요청한 총 개수를 구해보자 (예스 검색)

	List<TeamwonVO> tmWithDrawList1(HashMap<String, String> map2); //현재 탈퇴 상태인 리스트를 뽑아보자 (노 검색)

	List<TeamwonVO> tmWithDrawList2(HashMap<String, String> map2); //현재 탈퇴 상태인 리스트를 뽑아보자 (예스 검색)

	int TMWDTotalCount1(HashMap<String, String> map2); //현재 탈퇴 상태인 총 명수를 구해보자 (노 검색)

	int TMWDTotalCount2(HashMap<String, String> map2); //현재 탈퇴 상태인 총 명수를 구해보자 (예스 검색)

	int tmWithDrawEnd(String idx); //탈퇴 요청한 회원을 최종적으로 탈퇴 처리를 해보자

	int tmRestore(String idx); //탈퇴된 회원을 복구하는 처리를 해보자

	List<TeamVO> getTeamVO(String team_idx); //초대 메일을 보낼 때 필요한 팀의 정보들을 가져오자

	int insertTeamwon(HashMap<String, String> insertMap); //초대 메일을 통하여 로그인 했을 경우 팀원으로 추가해주자

	int getinsertTeamwonIdx(); //초대 메일을 통하여 로그인하고 추가된 팀원번호를 구해보자

	int insertDuplicationChk(HashMap<String, String> insertMap);  //초대 메일로 팀원에 들어갔을 때 중복이 있는지 체크하자

	int tmTeamwonListCount(String fk_team_idx); //팀에서 팀장을 제외한 팀원들이 남아있는지 알아보자

	int tmDel(String fk_team_idx); //팀을 삭제해보자

	List<TeamVO> getTeamInfo(String fk_team_idx); //footer에 들어갈 팀 정보를 가져오자

	String getTeamLeaderName(String fk_team_idx); //footer에 들어갈 팀 정보의 설립자 이름을 가져오자

}
