package com.miracle.kdh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectManagerDAO {
	@Autowired
	SqlSessionTemplate sql;  
	
	// 모든 폴더, 할일 리스트를 가져오는 메소드
	public List<FolderVO> getAllDoList() {
		List<FolderVO> doList = sql.selectList("do.getAllDoList");
		return doList;
	} // end of List<FolderVO> getAllDoList() ------------------------------------------ 
	
	// 선택한 폴더의 정보를 가져오는 메소드
	public FolderVO getFolderInfo(String idx) {
		FolderVO fvo = sql.selectOne("do.getFolderInfo",idx);
		return fvo;
	} // end of FolderVO getFolderInfo(String idx) ------------------------------------------ 
	
	// 선택한 폴더에 소속된 팀원 리스트를 가져오는 메소드
	public List<Folder_TeamwonVO> getFolder_teamwonInfo(String idx) {
		List<Folder_TeamwonVO> folder_teamwonList  = sql.selectList("do.getFolder_teamwonInfo",idx);
		return folder_teamwonList;
	} // end of List<Folder_TeamwonVO> getFolder_teamwonInfo(String idx) ------------------------------------------ 
	
	// 선택한 폴더에 작성된 댓글 리스트를 가져오는 메소드
	public List<Folder_CommentVO> getFolder_commentInfo(String idx) {
		List<Folder_CommentVO> folder_commentList = sql.selectList("do.getFolder_commentInfo",idx);
		return folder_commentList;
	} // end of List<Folder_CommentVO> getFolder_commentInfo(String idx) ------------------------------------------ 

	// 선택한 폴더의 정보를 수정하기
	public int do_goModalEdit(FolderVO fvo) {
		int result = sql.update("do.goModalEdit", fvo);
		return result;
	} // end of public int do_goModalEdit(FolderVO fvo) ---------------------------------------------------------------------

	// 할일 완료, 미완료 처리하기
	public void setTaskComplete(FolderVO fvo) { 
		sql.update("do.setTaskComplete", fvo);
	} // public void setTaskComplete(FolderVO fvo) -----------------------------------------------------------------------

	public HashMap<String, String> getUpFolder(String upIdx) {
		HashMap<String, String> map = sql.selectOne("do.getUpFolder",upIdx);
		return map;
	}

	public List<HashMap<String, String>> getTeamwonList(String fk_team_idx) {
		List<HashMap<String, String>> teamwonList = sql.selectList("do.getTeamwonList",fk_team_idx);
		return teamwonList;
	}

	public int addDownFolder(FolderVO fvo) {
		int result = sql.insert("do.addDownFolder",fvo);
		return result;
	}

	public int addFolderTeamwon(HashMap<String, String[]> map) {
		int result = sql.insert("do.addFolderTeamwon",map); 
		return result;
	}
}

















