package com.miracle.kdh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.model.Folder_CommentVO;
import com.miracle.kdh.model.Folder_TeamwonVO;
import com.miracle.kdh.model.ProjectManagerDAO;

@Service
public class ProjectManagerService {
	@Autowired
	ProjectManagerDAO dao;
	
	// 페이징처리된 모든 폴더, 할일 리스트를 가져오는 메소드
	public HashMap<String, Object> getAllDoList(String team_idx, String page, String term) {
		List<FolderVO> doList = dao.getAllDoList(team_idx); // 모든 폴더, 할일 리스트를 가져오기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("doList", doList);
		
		if(term.equals("7")) {
			int result = dao.updatePageDateWeek(page); // 페이징 처리를 위해 1주간의 날짜를 동적으로 수정하기
			if(result > 0) {
				List<HashMap<String, String>> pageDateList = dao.getPageDateWeek(); // 페이징 처리를 위해 수정된 1주간의 날짜를 받아오기
				map.put("pageDateList", pageDateList);
			}
		} else if(term.equals("30")) {
			int result = dao.updatePageDateMonth(page); // 페이징 처리를 위해 1주간의 날짜를 동적으로 수정하기
			if(result > 0) {
				List<HashMap<String, String>> pageDateList = dao.getPageDateMonth(); // 페이징 처리를 위해 수정된 1주간의 날짜를 받아오기
				map.put("pageDateList", pageDateList);
			}
		}
		return map;
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
	} // end of int do_goModalEdit(FolderVO fvo) --------------------------------------------------------------------

	// 할일 완료, 미완료 처리하기
	public void setTaskComplete(FolderVO fvo) {
		dao.setTaskComplete(fvo);
	} // end of void setTaskComplete(FolderVO fvo) ---------------------------------------------------------------------

	// 하위폴더 추가시 상위 폴더의 정보를 가져오기
	public HashMap<String, String> getUpFolder(String upIdx) {
		HashMap<String, String> map = dao.getUpFolder(upIdx);
		return map;
	} // end of HashMap<String, String> getUpFolder(int upIdx) --------------------------------------------------------

	// 현재 팀의 소속된 팀원 목록을 가져오기
	public List<HashMap<String, String>> getTeamwonList(String team_idx) {
		List<HashMap<String, String>> teamwonList = dao.getTeamwonList(team_idx);
		return teamwonList;
	} // end of List<HashMap<String, String>> getTeamwonList(String team_idx) --------------------------------------------------

	// 하위요소 추가하기(+추가된 요소에 소속된 담당들도 folder_teamwon 테이블에 추가)
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public HashMap<String, Object> addDownElementEnd(FolderVO fvo, HashMap<String, Object> map, String term, String page) {
		int result1 = dao.addDownElement(fvo); // 하위 폴더 추가하기
		int result2 = dao.addDoTeamwon(map); // 폴더나 할일 추가할때 담당 팀원 추가하기(가장 최근에 올라온 folderIdx를 구해서 입력주는 방식임)
		fvo = dao.getAddedElement(); // 방금 추가한 요소를 가져오기
		
		List<HashMap<String, String>> pageDateList = null;
		if(term.equals("7")) {
			int result = dao.updatePageDateWeek(page); // 페이징 처리를 위해 1주간의 날짜를 동적으로 수정하기
			if(result > 0) {
				pageDateList = dao.getPageDateWeek(); // 페이징 처리를 위해 수정된 1주간의 날짜를 받아오기
			}
		} else if(term.equals("30")) {
			int result = dao.updatePageDateMonth(page); // 페이징 처리를 위해 1주간의 날짜를 동적으로 수정하기
			if(result > 0) {
				pageDateList = dao.getPageDateMonth(); // 페이징 처리를 위해 수정된 1주간의 날짜를 받아오기
			}
		}
		HashMap<String, Object> endMap = new HashMap<String, Object>();
		endMap.put("result", result1*result2);
		endMap.put("fvo", fvo);
		endMap.put("pageDateList", pageDateList);
		System.out.println("result1*result2 : "+result1*result2);
		return endMap;
	} // end of int addDownElementEnd(FolderVO fvo, HashMap<String, Object> map) -----------------------------------------------------

	// 선택한 요소와 그 하위요소들 삭제하기
	public int delElement(String idx) {
		int result = dao.delElement(idx);
		return result;
	} // end of int delElement(String idx) ----------------------------------------------------------------------------------------
}























