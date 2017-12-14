package com.miracle.ksh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TMDAO implements InterTMDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<HashMap<String, String>> tmList1(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> tmList = sqlsession.selectList("kshTM.tmList1", tmMap);
		return tmList;
	}

	@Override
	public List<HashMap<String, String>> tmList2(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> tmList = sqlsession.selectList("kshTM.tmList2", tmMap);
		return tmList;
	}

	@Override
	public int TMTotalCount1(HashMap<String, String> tmMap) {
		int n = sqlsession.selectOne("kshTM.TMTotalCount1", tmMap);
		return n;
	}

	@Override
	public int TMTotalCount2(HashMap<String, String> tmMap) {
		int n = sqlsession.selectOne("kshTM.TMTotalCount2", tmMap);
		return n;
	}

	@Override
	public List<HashMap<String, String>> getTeamList1(String fk_member_idx) {
		List<HashMap<String, String>> teamlist = sqlsession.selectList("kshTM.getTeamList1", fk_member_idx);
		return teamlist;
	}

	@Override
	public List<HashMap<String, String>> getTeamList2(String fk_member_idx) {
		List<HashMap<String, String>> teamlist = sqlsession.selectList("kshTM.getTeamList2", fk_member_idx);
		return teamlist;
	}

	@Override
	public int TeamCreate(HashMap<String, String> tmMap) {
		int n = sqlsession.insert("kshTM.TeamCreate", tmMap);
		return n;
	}

	@Override
	public String getTeamwonIDX(HashMap<String, String> map) {
		String teamwon_idx = sqlsession.selectOne("kshTM.getTeamwonIDX", map);
		return teamwon_idx;
	}

	@Override
	public String getTeamwonStatus(HashMap<String, String> map) {
		String teamwon_status = sqlsession.selectOne("kshTM.getTeamwonStatus", map);
		return teamwon_status;
	}

	@Override
	public List<HashMap<String, String>> tmAddrList1(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> Addrlist = sqlsession.selectList("kshTM.tmAddrList1", tmMap);
		return Addrlist;
	}

	@Override
	public List<HashMap<String, String>> tmAddrList2(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> Addrlist = sqlsession.selectList("kshTM.tmAddrList2", tmMap);
		return Addrlist;
	}

	@Override
	public int tmWithDraw(HashMap<String, String> map) {
		int n = sqlsession.update("kshTM.tmWithDraw", map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> tmReqWithDrawList1(HashMap<String, String> map1) {
		List<HashMap<String, String>> wdlist = sqlsession.selectList("kshTM.tmReqWithDrawList1", map1);
		return wdlist;
	}
	
	@Override
	public List<HashMap<String, String>> tmReqWithDrawList2(HashMap<String, String> map1) {
		List<HashMap<String, String>> wdlist = sqlsession.selectList("kshTM.tmReqWithDrawList2", map1);
		return wdlist;
	}
	
	@Override
	public int TMReqWDTotalCount1(HashMap<String, String> map1) {
		int n = sqlsession.selectOne("kshTM.TMReqWDTotalCount1", map1);
		return n;
	}
	
	@Override
	public int TMReqWDTotalCount2(HashMap<String, String> map1) {
		int n = sqlsession.selectOne("kshTM.TMReqWDTotalCount2", map1);
		return n;
	}

	@Override
	public List<TeamwonVO> tmWithDrawList1(HashMap<String, String> map2) {
		List<TeamwonVO> wdlist = sqlsession.selectList("kshTM.tmWithDrawList1", map2);
		return wdlist;
	}

	@Override
	public List<TeamwonVO> tmWithDrawList2(HashMap<String, String> map2) {
		List<TeamwonVO> wdlist = sqlsession.selectList("kshTM.tmWithDrawList2", map2);
		return wdlist;
	}

	@Override
	public int TMWDTotalCount1(HashMap<String, String> map2) {
		int n = sqlsession.selectOne("kshTM.TMWDTotalCount1", map2);
		return n;
	}

	@Override
	public int TMWDTotalCount2(HashMap<String, String> map2) {
		int n = sqlsession.selectOne("kshTM.TMWDTotalCount2", map2);
		return n;
	}

	@Override
	public int tmWithDrawEnd(String idx) {
		int n = sqlsession.update("kshTM.tmWithDrawEnd", idx);
		return n;
	}

	@Override
	public int tmRestore(String idx) {
		int n = sqlsession.update("kshTM.tmRestore", idx);
		return n;
	}

	@Override
	public List<TeamVO> getTeamVO(String team_idx) {
		List<TeamVO> teamvo = sqlsession.selectList("kshTM.getTeamVO", team_idx);
		return teamvo;
	}

	@Override
	public int insertTeamwon(HashMap<String, String> insertMap) {
		int m = sqlsession.insert("kshTM.insertTeamwon", insertMap);
		return m;
	}

	@Override
	public int getinsertTeamwonIdx() {
		int i = sqlsession.selectOne("kshTM.getinsertTeamwonIdx");
		return i;
	}

	@Override
	public int insertDuplicationChk(HashMap<String, String> insertMap) {
		int x = sqlsession.selectOne("kshTM.insertDuplicationChk", insertMap);
		return x;
	}

	@Override
	public int tmTeamwonListCount(String fk_team_idx) {
		int n = sqlsession.selectOne("kshTM.tmTeamwonListCount", fk_team_idx);
		return n;
	}

	@Override
	public int tmDel(String fk_team_idx) {
		int n = sqlsession.update("kshTM.tmDel", fk_team_idx);
		return n;
	}

	@Override
	public List<TeamVO> getTeamInfo(String fk_team_idx) {
		List<TeamVO> tvo = sqlsession.selectList("kshTM.getTeamInfo", fk_team_idx);
		return tvo;
	}

	@Override
	public String getTeamLeaderName(String fk_team_idx) {
		String name = sqlsession.selectOne("kshTM.getTeamLeaderName", fk_team_idx);
		return name;
	}

	@Override
	public String getMyEmail(int login_idx) {
		String email = sqlsession.selectOne("kshTM.getMyEmail", login_idx);
		return email;
	}

}
