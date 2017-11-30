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
	public List<HashMap<String, String>> commuteList() {
		List<HashMap<String, String>> map = sqlsession.selectList("commute.commuteList");
		return map;
	}

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

}
