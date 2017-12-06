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

}
