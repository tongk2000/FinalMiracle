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

}
