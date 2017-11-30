package com.miracle.kdh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.model.ScheduleManagerDAO;

@Service
public class ScheduleManagerService {
	@Autowired
	ScheduleManagerDAO dao;
	
	// 모든 폴더, 할일 리스트를 가져오는 메소드
	public List<FolderVO> getAllDoList() {
		List<FolderVO> doList = dao.getAllDoList();
		return doList;
	} // end of List<FolderVO> getAllDoList() ------------------------------------------
}
