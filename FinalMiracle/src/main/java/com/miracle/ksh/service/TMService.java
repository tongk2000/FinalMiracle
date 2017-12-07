package com.miracle.ksh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.ksh.model.InterMemoDAO;
import com.miracle.ksh.model.InterTMDAO;
import com.miracle.ksh.model.TeamVO;
import com.miracle.ksh.model.TeamwonVO;

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

	@Override
	public String getTeamwonIDX(HashMap<String, String> map) {
		String teamwon_idx = dao.getTeamwonIDX(map);
		return teamwon_idx;
	}

	@Override
	public String getTeamwonStatus(HashMap<String, String> map) {
		String teamwon_status = dao.getTeamwonStatus(map);
		return teamwon_status;
	}

	@Override
	public List<HashMap<String, String>> tmAddrList1(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> Addrlist = dao.tmAddrList1(tmMap);
		return Addrlist;
	}

	@Override
	public List<HashMap<String, String>> tmAddrList2(HashMap<String, String> tmMap) {
		List<HashMap<String, String>> Addrlist = dao.tmAddrList2(tmMap);
		return Addrlist;
	}

	@Override
	public int tmWithDraw(HashMap<String, String> map) {
		int n = dao.tmWithDraw(map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> tmReqWithDrawList1(HashMap<String, String> map1) {
		List<HashMap<String, String>> wdlist = dao.tmReqWithDrawList1(map1);
		return wdlist;
	}
	
	@Override
	public List<HashMap<String, String>> tmReqWithDrawList2(HashMap<String, String> map1) {
		List<HashMap<String, String>> wdlist = dao.tmReqWithDrawList2(map1);
		return wdlist;
	}
	
	@Override
	public int TMReqWDTotalCount1(HashMap<String, String> map1) {
		int n = dao.TMReqWDTotalCount1(map1);
		return n;
	}
	
	@Override
	public int TMReqWDTotalCount2(HashMap<String, String> map1) {
		int n = dao.TMReqWDTotalCount2(map1);
		return n;
	}

	@Override
	public List<TeamwonVO> tmWithDrawList1(HashMap<String, String> map2) {
		List<TeamwonVO> wdlist = dao.tmWithDrawList1(map2);
		return wdlist;
	}

	@Override
	public List<TeamwonVO> tmWithDrawList2(HashMap<String, String> map2) {
		List<TeamwonVO> wdlist = dao.tmWithDrawList2(map2);
		return wdlist;
	}

	@Override
	public int TMWDTotalCount1(HashMap<String, String> map2) {
		int n = dao.TMWDTotalCount1(map2);
		return n;
	}

	@Override
	public int TMWDTotalCount2(HashMap<String, String> map2) {
		int n = dao.TMWDTotalCount2(map2);
		return n;
	}

}
