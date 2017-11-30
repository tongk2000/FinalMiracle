package com.miracle.kdh.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ScheduleManagerDAO {
	@Autowired
	SqlSessionTemplate sql;  
	
	// 모든 폴더, 할일 리스트를 가져오는 메소드
	public List<FolderVO> getAllDoList() {
		List<FolderVO> doList = sql.selectList("do.getAllDoList");
		return doList;
	} // end of List<FolderVO> getAllDoList() ------------------------------------------ 
}
