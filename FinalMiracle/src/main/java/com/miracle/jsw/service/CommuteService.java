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
	public List<HashMap<String, String>> commuteList() {
		List<HashMap<String, String>> map = dao.commuteList();
		return map;
	}

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

}
