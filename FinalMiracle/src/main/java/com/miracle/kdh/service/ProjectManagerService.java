package com.miracle.kdh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.model.Folder_CommentVO;
import com.miracle.kdh.model.Folder_TeamwonVO;
import com.miracle.kdh.model.ProjectManagerDAO;

@Service
public class ProjectManagerService {
	@Autowired
	ProjectManagerDAO dao;
	
	// 모든 폴더, 할일 리스트를 가져오는 메소드
	public List<FolderVO> getAllDoList() {
		List<FolderVO> doList = dao.getAllDoList();
		return doList;
	} // end of List<FolderVO> getAllDoList() ------------------------------------------
	
	// 선택한 폴더의 모든 정보를 가져오기
	public HashMap<String, Object> do_getSelectFolderInfo(String idx) {
		// 선택한 폴더의 정보를 가져옴
		FolderVO fvo = dao.getFolderInfo(idx);
		
		// 선택한 폴더에 소속된 팀원 리스트를 가져옴
		List<Folder_TeamwonVO> folder_teamwonList = dao.getFolder_teamwonInfo(idx);
		
		// 선택한 폴더에 작성된 댓글 리스트를 가져옴
		List<Folder_CommentVO> folder_commentList = dao.getFolder_commentInfo(idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();  
		map.put("fvo", fvo);
		map.put("folder_teamwonList", folder_teamwonList);
		map.put("folder_commentList", folder_commentList);
		
		return map;
	} // end of HashMap<String, Object> getSelectFolderInfo(String idx) ------------------------------------------ 

	// 선택한 폴더의 정보를 수정하기
	public int do_goModalEdit(FolderVO fvo) {
		int result = dao.do_goModalEdit(fvo);
		return result;
	}

	// 할일 완료, 미완료 처리하기
	public void setTaskComplete(FolderVO fvo) {
		dao.setTaskComplete(fvo);
	}
}
