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
	
	// 모든 폴더, 할일 리스트를 가져오기
	public List<FolderVO> getAllDoList(String team_idx) {
		List<FolderVO> doList = sql.selectList("do.getAllDoList", team_idx);
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
	} // end of int do_goModalEdit(FolderVO fvo) ---------------------------------------------------------------------

	// 할일 완료, 미완료 처리하기
	public void setTaskComplete(FolderVO fvo) { 
		sql.update("do.setTaskComplete", fvo);
	} // end of void setTaskComplete(FolderVO fvo) -----------------------------------------------------------------------
	
	// 하위 폴더 추가할때 상위 폴더의 정보 받아오기
	public HashMap<String, String> getUpFolder(String upIdx) {
		HashMap<String, String> map = sql.selectOne("do.getUpFolder",upIdx);
		return map;
	} // end of HashMap<String, String> getUpFolder(String upIdx) -----------------------------------------------------------------

	// 현재 팀의 소속된 팀원 목록을 가져오기
	public List<HashMap<String, String>> getTeamwonList(String team_idx) {
		List<HashMap<String, String>> teamwonList = sql.selectList("do.getTeamwonList",team_idx);
		return teamwonList;
	} // end of List<HashMap<String, String>> getTeamwonList(String team_idx) -----------------------------------------------------------
	
	// 하위 폴더 추가하기
	public int addDownElement(FolderVO fvo) {
		int result = sql.insert("do.addDownElement",fvo);
		return result;
	} // end of int addDownElement(FolderVO fvo) -------------------------------------------------------------------------------------------

	// 폴더나 할일 추가할때 담당 팀원 추가하기(가장 최근에 올라온 folderIdx를 구해서 입력주는 방식임)
	public int addDoTeamwon(HashMap<String, Object> map) {
		int result = sql.insert("do.addDoTeamwon",map);
		return result;
	} // end of int addDoTeamwon(HashMap<String, Object> map) ------------------------------------------------------------------------

	// 방금 추가한 요소를 가져오기
	public FolderVO getAddedElement() {
		FolderVO fvo = sql.selectOne("do.getAddedElement");
		return fvo;
	} // end of FolderVO getAddedElement() -----------------------------------------------------------------------------------------------

	// 선택한 요소와 그 하위요소들 삭제하기
	public int delElement(String idx) {
		int result = sql.update("do.delElement",idx);
		return result;
	} // end of int delElement(String idx) ------------------------------------------------------------------------------------------
	
	// 페이징 처리를 위해 1주간의 날짜를 동적으로 수정하기
	public int updatePageDateWeek(String page) {
		System.out.println("page:"+page);
		int result = sql.update("do.updatePageDateWeek",page);
		System.out.println("result:"+result);
		return result;
	} // end of public int updatePageDate(String page) ------------------------------------------------------------------------------------
	
	// 페이징 처리를 위해 수정된 1주간의 날짜를 받아오기
	public List<HashMap<String, String>> getPageDateWeek() {
		List<HashMap<String, String>> pageDateList = sql.selectList("do.getPageDateWeek");
		return pageDateList;
	} // end of HashMap<String, String> getPageDate(String page) --------------------------------------------------------------------
	
	// 페이징 처리를 위해 한달간의 날짜를 동적으로 수정하기
	public int updatePageDateMonth(String page) {
		System.out.println("page:"+page);
		int result = sql.update("do.updatePageDateMonth",page);
		System.out.println("result:"+result);
		return result;
	} // end of public int updatePageDate(String page) ------------------------------------------------------------------------------------
	
	// 페이징 처리를 위해 수정된 한달간의 날짜를 받아오기
	public List<HashMap<String, String>> getPageDateMonth() {
		List<HashMap<String, String>> pageDateList = sql.selectList("do.getPageDateMonth");
		return pageDateList;
	} // end of HashMap<String, String> getPageDate(String page) --------------------------------------------------------------------
}

















