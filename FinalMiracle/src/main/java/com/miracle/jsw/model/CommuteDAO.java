package com.miracle.jsw.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommuteDAO implements InterCommuteDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public int startWork(int idx) {
		int n = sqlsession.update("commute.startWork", idx);
		return n;
	}

	@Override
	public int endWork(int idx) {
		int n = sqlsession.update("commute.endWork", idx);
		return n;
	}

	@Override
	public List<HashMap<String, String>> commuteList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("commute.commuteList", map);
		return list;
	}

	@Override
	public List<HashMap<String, String>> commuteListMonth(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("commute.commuteListMonth", map);
		return list;
	}

	@Override
	public int getTotalCountMonth(HashMap<String, String> map) {
		int n = sqlsession.selectOne("commute.getTotalCountMonth", map);
		return n;
	}

	@Override
	public int getTotalCount(HashMap<String, String> map) {
		int n = sqlsession.selectOne("commute.getTotalCount", map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> getTeamWonList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("commute.getTeamWonList", map);
		return list;
	}

	@Override
	public List<HashMap<String, String>> twcommuteListMonth(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("commute.twcommuteListMonth", map);
		return list;
	}

	@Override
	public int getTWTotalCountMonth(HashMap<String, String> map) {
		int n = sqlsession.selectOne("commute.getTWTotalCountMonth", map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> twcommuteList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlsession.selectList("commute.twcommuteList", map);
		return list;
	}

	@Override
	public int getTWTotalCount(HashMap<String, String> map) {
		int n = sqlsession.selectOne("commute.getTWTotalCount", map);
		return n;
	}

	@Override
	public int startWorkLate(int idx) {
		int n = sqlsession.update("commute.startWorkLate", idx);
		return n;
	}

	@Override
	public int endWorkEarly(int idx) {
		int n = sqlsession.update("commute.endWorkEarly", idx);
		return n;
	}

	@Override
	public int workLateAndEarlyGo(int idx) {
		int n = sqlsession.update("commute.workLateAndEarlyGo", idx);
		return n;
	}

	@Override
	public List<HashMap<String, String>> getUserTeamDetail(HashMap<String, String> map) {
		List<HashMap<String, String>> userTeamDetail = sqlsession.selectList("commute.getUserTeamDetail", map);
		return userTeamDetail;
	}

}
