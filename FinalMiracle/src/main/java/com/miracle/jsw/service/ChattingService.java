package com.miracle.jsw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.jsw.model.InterChattingDAO;

@Service
public class ChattingService implements InterChattingService {

	
	@Autowired
	private InterChattingDAO dao;

	@Override
	public List<HashMap<String, Object>> getChatRoom(int idx) {
		List<HashMap<String, Object>> list = dao.getChatRoom(idx);
		return list;
	}

	
}
