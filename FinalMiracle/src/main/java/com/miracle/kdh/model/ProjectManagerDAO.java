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
	
	// 모든 요소를 가져오기
	public List<FolderVO> getAllDoList(String team_idx) {
		List<FolderVO> doList = sql.selectList("do.getAllDoList", team_idx);
		return doList;
	} // end of List<FolderVO> getAllDoList() ------------------------------------------ 
	
	// 선택한 요소의 정보를 가져오기
	public FolderVO getFolderInfo(int idx) {
		FolderVO fvo = sql.selectOne("do.getFolderInfo",idx);
		return fvo;
	} // end of FolderVO getFolderInfo(String idx) ------------------------------------------ 
	
	// 선택한 요소에 소속된 팀원 리스트를 가져오기
	public List<Folder_TeamwonVO> getFolder_teamwonInfo(int idx) {
		List<Folder_TeamwonVO> folder_teamwonList  = sql.selectList("do.getFolder_teamwonInfo",idx);
		return folder_teamwonList;
	} // end of List<Folder_TeamwonVO> getFolder_teamwonInfo(String idx) ------------------------------------------ 
	
	// 선택한 요소에 포함된 파일 리스트를 가져오기
	public List<Folder_FileVO> getFolder_fileInfo(int idx) {
		List<Folder_FileVO> folder_fileList = sql.selectList("do.getFolder_fileInfo", idx);
		return folder_fileList;
	} // end of List<Folder_CommentVO> getFolder_fileInfo(int idx) ------------------------------------------
	
	// 선택한 요소에 작성된 댓글 리스트를 가져오기
	public List<Folder_CommentVO> getFolder_commentInfo(PageVO pvo) {
		List<Folder_CommentVO> folder_commentList = sql.selectList("do.getFolder_commentInfo", pvo);
		return folder_commentList;
	} // end of List<Folder_CommentVO> getFolder_commentInfo(PageVO pvo) ------------------------------------------

	// 선택한 요소의 정보를 수정하기
	public int do_goModalEdit(FolderVO fvo) {
		int result = sql.update("do.goModalEdit", fvo);
		return result;
	} // end of int do_goModalEdit(FolderVO fvo) ---------------------------------------------------------------------

	// 할일 완료, 미완료 처리하기
	public void setTaskComplete(FolderVO fvo) { 
		sql.update("do.setTaskComplete", fvo);
	} // end of void setTaskComplete(FolderVO fvo) -----------------------------------------------------------------------
	
	// 하위 요소 추가할때 상위 폴더의 정보 받아오기
	public HashMap<String, String> getUpFolder(String upIdx) {
		HashMap<String, String> map = sql.selectOne("do.getUpFolder",upIdx);
		return map;
	} // end of HashMap<String, String> getUpFolder(String upIdx) -----------------------------------------------------------------

	// 최상위 요소 추가라면 마지막 groupNo 에 1 더해서 반환해주기
	public HashMap<String, String> getMaxGroupNo(String upIdx) {
		HashMap<String, String> map = sql.selectOne("do.getMaxGroupNo",upIdx);
		return map;
	} // end of HashMap<String, String> getMaxGroupNo(String upIdx) -----------------------------------------------------------------
	
	// 현재 팀의 소속된 팀원 목록을 가져오기
	public List<HashMap<String, String>> getTeamwonList(String team_idx) {
		List<HashMap<String, String>> teamwonList = sql.selectList("do.getTeamwonList",team_idx);
		return teamwonList;
	} // end of List<HashMap<String, String>> getTeamwonList(String team_idx) -----------------------------------------------------------
	
	// 요소 추가하기
	public int addDownElement(FolderVO fvo) {
		int result = sql.insert("do.addDownElement",fvo);
		return result;
	} // end of int addDownElement(FolderVO fvo) -------------------------------------------------------------------------------------------

	// 요소 추가할때 담당 팀원 추가하기(가장 최근에 올라온 folderIdx를 구해서 입력주는 방식임)
	public int addDoTeamwon(HashMap<String, Object> map) {
		int result = sql.insert("do.addDoTeamwon",map);
		return result;
	} // end of int addDoTeamwon(HashMap<String, Object> map) ------------------------------------------------------------------------

	// 방금 추가한 요소를 가져오기(to 프로젝트 리스트)
	public List<FolderVO> getAddedElement() {
		List<FolderVO> doList = sql.selectList("do.getAddedElement");
		return doList;
	} // end of FolderVO getAddedElement() -----------------------------------------------------------------------------------------------
	
	// 특정 한줄만 가져오기(to 프로젝트 리스트)
	public List<FolderVO> getOneElement(String idx) {
		List<FolderVO> doList = sql.selectList("do.getOneElement", idx);
		return doList;
	} // end of FolderVO getOneElement() -----------------------------------------------------------------------------------------------

	// 선택한 요소와 그 하위요소들 삭제하기
	public int delElement(String idx) {
		int result = sql.update("do.delElement",idx);
		return result;
	} // end of int delElement(String idx) ------------------------------------------------------------------------------------------
	
	// 페이징 처리를 위해 1주간의 날짜를 동적으로 수정하기
	public int updatePageDateWeek(String page) {
		int result = sql.update("do.updatePageDateWeek",page);
		return result;
	} // end of public int updatePageDate(String page) ------------------------------------------------------------------------------------
	
	// 페이징 처리를 위해 수정된 1주간의 날짜를 받아오기
	public List<HashMap<String, String>> getPageDateWeek() {
		List<HashMap<String, String>> pageDateList = sql.selectList("do.getPageDateWeek");
		return pageDateList;
	} // end of HashMap<String, String> getPageDate(String page) --------------------------------------------------------------------
	
	// 페이징 처리를 위해 한달간의 날짜를 동적으로 수정하기
	public int updatePageDateMonth(String page) {
		int result = sql.update("do.updatePageDateMonth",page);
		return result;
	} // end of public int updatePageDate(String page) ------------------------------------------------------------------------------------
	
	// 페이징 처리를 위해 수정된 한달간의 날짜를 받아오기
	public List<HashMap<String, String>> getPageDateMonth() {
		List<HashMap<String, String>> pageDateList = sql.selectList("do.getPageDateMonth");
		return pageDateList;
	} // end of HashMap<String, String> getPageDate(String page) --------------------------------------------------------------------
	
	// 삭제 등 하위요소의 값이 변할때 상위요소의 하위요소 갯수를 다시 받아오기
	public int getDownCnt(String fk_folder_idx) {
		int downCnt = sql.selectOne("do.getDownCnt", fk_folder_idx);
		return downCnt;
	} // end of int getDownCnt(String fk_folder_idx) --------------------------------------------------------------------

	// 요소에 댓글 추가하기
	public int addComment(Folder_CommentVO fcvo) {
		int result = sql.insert("do.addComment",fcvo);
		return result;
	} // end of int addComment(Folder_CommentVO fcvo) ------------------------------------------------------------------------
	
	// 요소에 댓글 삭제하기
	public int delComment(String delIdx) {
		int result = sql.update("do.delComment",delIdx);
		return result;
	} // end of int delComment(Folder_CommentVO fcvo) ------------------------------------------------------------------------
	
	// 페이징 처리를 위해 해당 요소의 전체 댓글수를 가져오기
	public int getTotalCommentCnt(int idx) {
		int totalCommentCnt = sql.selectOne("do.getTotalCommentCnt", idx);
		return totalCommentCnt;
	} // end of int getTotalCommentCnt(int idx) -----------------------------------------------------------------------------------------
	
	// 내가 속한 요소의 idx 받아오기
	public List<String> getMyElement(HashMap<String, String> map) {
		List<String> idxListByElement = sql.selectList("do.getMyElement", map);
		return idxListByElement;
	} // end of public List<String> getMyElement(HashMap<String, String> map) ---------------------------------------------------------------
	
	// 검색한 요소의 idx 받아오기
	public List<String> getSearchElement(HashMap<String, String> map) {
		List<String> idxListByElement = sql.selectList("do.getSearchElement", map);
		return idxListByElement;
	} // end of public List<String> getMyElement(HashMap<String, String> map) ---------------------------------------------------------------
	
	// 요소 수정시 팀원 목록 수정하기 시작
	// 1. 먼저 해당 요소의 팀원을 전부 탈퇴상태로 업데이트 후
	public void updateAllFolderTeamwon(int fk_folder_idx) {
		sql.update("do.updateAllFolderTeamwon", fk_folder_idx);
	}
	// 2. 요소 수정시 기존에 insert 했었던 팀원이라면 먼저 update 해주고
	public int updateFolderTeamwon(Folder_TeamwonVO ftvo) {
		int result = sql.update("do.updateFolderTeamwon", ftvo);
		return result;
	} 
	// 3. 없던 팀원이라면 새로 insert 해준다.
	public int insertFolderTeamwon(Folder_TeamwonVO ftvo) {
		int result = sql.update("do.insertFolderTeamwon", ftvo);
		return  result;
	} // 요소 수정시 팀원 목록 수정하기 끝 -------------------------------------------------------------------------------------
	
	// 진행전, 진행중, 기한경과, 완료 건수를 가져오기
	public HashMap<String, String> getPeriodCnt() {
		HashMap<String, String> periodCntMap = sql.selectOne("do.getPeriodCnt");
		return periodCntMap;
	} // end of HashMap<String, String> getPeriodCnt() --------------------------------------------------------------------
	
	// 진행전, 진행중, 기한경과, 완료 건수를 팀원별로 가져오기
	public HashMap<String, String> getPeriodCntByTeamwon(HashMap<String, String> map) {
		HashMap<String, String> periodCntMap = sql.selectOne("do.getPeriodCntByTeamwon", map);
		return periodCntMap;
	} // end of HashMap<String, String> getPeriodCnt() --------------------------------------------------------------------
	
	// 진행전, 진행중, 기한경과, 완료 건수를 검색어별로 가져오기
	public HashMap<String, String> getPeriodCntBySearch(HashMap<String, String> map) {
		HashMap<String, String> periodCntMap = sql.selectOne("do.getPeriodCntBySearch", map);
		return periodCntMap;
	} // end of HashMap<String, String> getPeriodCnt() --------------------------------------------------------------------
	
	// 첨부파일의 정보를 입력해주기
	public int insertFolderFile(Folder_FileVO ffvo) {
		int result = sql.insert("do.insertFolderFile", ffvo);
		return result;
	} // end of int insertFolderFile(Folder_FileVO ffvo) --------------------------------------------------------------------
	
	// 첨부파일 삭제하기
	public void deleteFolderFile(String serFilename) { 
		sql.delete("do.deleteFolderFile", serFilename);
	} // end of void deleteFolderFile(String serFilename) --------------------------------------------------------------------

	// 1.특정 요소와 그 하위요소들을 다른 상위요소로 이동할때 이동하는 첫번째 요소의 fk_folder_idx 변경해주기
	public int elementMoveByFkIdx(FolderVO fvo) {
		int result = sql.update("do.elementMoveByFkIdx", fvo);
		return result;
	} // end of int elementMoveByFkIdx(FolderVO fvo) -----------------------------------------------------------------------
	// 2.특정 요소와 그 하위요소들을 다른 상위요소로 이동할때 이동하는 모든 요소의 groupNo, depth 변경해주기
	public int elementMoveByGroup(FolderVO fvo) {
		int result = sql.update("do.elementMoveByGroup", fvo);
		return result;
	} // end of int elementMoveByFkIdx(FolderVO fvo) -----------------------------------------------------------------------

	// ***** 통합 검색을 위한 각 메뉴별 리스트 받아오기 시작 *****
	// 프로젝트 검색리스트 받아오기
	public List<String> getProjectSearchList(String searchWord) {
		List<String> projectSerchAll = sql.selectList("do.getProjectSearchList", searchWord);
		return projectSerchAll;
	} // end of List<String> getProjectSearchList(String searchWord) ---------------------------------------------------------
	
	// ***** 통합 검색을 위한 각 메뉴별 리스트 받아오기 끝 *****
}

















