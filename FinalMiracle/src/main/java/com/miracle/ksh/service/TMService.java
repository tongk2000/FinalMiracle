package com.miracle.ksh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.ksh.model.InterMemoDAO;
import com.miracle.ksh.model.InterTMDAO;
import com.miracle.ksh.model.TeamVO;

@Service
public class TMService implements InterTMService {
	
	@Autowired
	private InterTMDAO dao;

	@Override
	public List<HashMap<String, String>> tmList1(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> tmList = dao.tmList1(tmMap);
		return tmList;
	}

	@Override
	public List<HashMap<String, String>> tmList2(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> tmList = dao.tmList2(tmMap);
		return tmList;
	}

	@Override
	public int TMTotalCount1(HashMap<String, String> tmMap) {
		int n = dao.TMTotalCount1(tmMap);
		return n;
	}

	@Override
	public int TMTotalCount2(HashMap<String, String> tmMap) {
		int n = dao.TMTotalCount2(tmMap);
		return n;
	}

	@Override
	public List<HashMap<String, String>> getTeamList1(String fk_member_idx) {
		List<HashMap<String, String>> teamlist = dao.getTeamList1(fk_member_idx);
		return teamlist;
	}

	@Override
	public List<HashMap<String, String>> getTeamList2(String fk_member_idx) {
		List<HashMap<String, String>> teamlist = dao.getTeamList2(fk_member_idx);
		return teamlist;
	}

	@Override
	public int TeamCreate(HashMap<String, String> tmMap) {
		int n = dao.TeamCreate(tmMap);
		return n;
	}

}
