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
	public int startWork() {
		int n = sqlsession.update("commute.startWork");
		return n;
	}

	@Override
	public int endWork() {
		int n = sqlsession.update("commute.endWork");
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
	public int getTotalCount() {
		int n = sqlsession.selectOne("commute.getTotalCount");
		return n;
	}

}
