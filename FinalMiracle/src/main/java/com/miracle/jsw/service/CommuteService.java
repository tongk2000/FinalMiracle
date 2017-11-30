package com.miracle.jsw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.jsw.model.InterCommuteDAO;

@Service
public class CommuteService implements InterCommuteService {

	@Autowired
	private InterCommuteDAO dao;

	@Override
	public int startWork() {
		int n = dao.startWork();
		return n;
	}

	@Override
	public int endWork() {
		int n = dao.endWork();
		return n;
	}

	@Override
	public List<HashMap<String, String>> commuteList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = dao.commuteList(map);
		return list;
	}

	@Override
	public List<HashMap<String, String>> commuteListMonth(HashMap<String, String> map) {
		List<HashMap<String, String>> list = dao.commuteListMonth(map);
		return list;
	}

	@Override
	public int getTotalCountMonth(HashMap<String, String> map) {
		int n = dao.getTotalCountMonth(map);
		return n;
	}

	@Override
	public int getTotalCount() {
		int n = dao.getTotalCount();
		return n;
	}

}
