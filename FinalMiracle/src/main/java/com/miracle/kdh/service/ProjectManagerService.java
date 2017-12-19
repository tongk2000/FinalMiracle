package com.miracle.kdh.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.model.Folder_CommentVO;
import com.miracle.kdh.model.Folder_FileVO;
import com.miracle.kdh.model.Folder_TeamwonVO;
import com.miracle.kdh.model.PageVO;
import com.miracle.kdh.model.ProjectManagerDAO;
import com.miracle.kdh.util.FileManagerKDH;

@Service
public class ProjectManagerService {
	@Autowired
	ProjectManagerDAO dao;
	@Autowired
	FileManagerKDH fileManager;
	
	// 페이징처리된 모든 폴더, 할일 리스트를 가져오는 메소드
	public HashMap<String, Object> getAllDoList(String team_idx, String page, String term) {
		List<FolderVO> doList = dao.getAllDoList(team_idx); // 모든 폴더, 할일 리스트를 가져오기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("doList", doList);
		
		HashMap<String, String> periodCntMap = dao.getPeriodCnt();
		map.put("periodCntMap", periodCntMap);
		
		if(term.equals("7")) {
			int result = dao.updatePageDateWeek(page); // 페이징 처리를 위해 1주간의 날짜를 동적으로 수정하기
			if(result > 0) {
				List<HashMap<String, String>> pageDateList = dao.getPageDateWeek(); // 수정된 1주간의 날짜를 받아오기
				map.put("pageDateList", pageDateList);
			}
		} else if(term.equals("30")) {
			int result = dao.updatePageDateMonth(page); // 페이징 처리를 위해 한달간의 날짜를 동적으로 수정하기
			if(result > 0) {
				List<HashMap<String, String>> pageDateList = dao.getPageDateMonth(); // 수정된 한달간의 날짜를 받아오기
				map.put("pageDateList", pageDateList);
			}
		}
		
		return map;
	} // end of List<FolderVO> getAllDoList() ------------------------------------------
	
	// 선택한 폴더의 모든 정보를 가져오기
	public HashMap<String, Object> do_getSelectFolderInfo(PageVO pvo) {
		// 선택한 폴더의 정보를 가져옴
		FolderVO fvo = dao.getFolderInfo(pvo.getShowIdx());
		
		// 선택한 폴더에 소속된 팀원 리스트를 가져옴
		List<Folder_TeamwonVO> folder_teamwonList = dao.getFolder_teamwonInfo(pvo.getShowIdx());
		
		// 선택한 요소에 포함된 파일 리스트를 가져옴
		List<Folder_FileVO> folder_fileList = dao.getFolder_fileInfo(pvo.getShowIdx());
		
		// 선택한 폴더에 작성된 댓글 리스트를 가져옴
		List<Folder_CommentVO> folder_commentList = dao.getFolder_commentInfo(pvo);
		
		// 페이지바 가져오기
		pvo = getCommentPagingBar(pvo);
		
		HashMap<String, Object> map = new HashMap<String, Object>();  
		map.put("fvo", fvo);
		map.put("folder_teamwonList", folder_teamwonList);
		map.put("folder_fileList", folder_fileList);
		map.put("folder_commentList", folder_commentList);
		map.put("pvo", pvo);
		
		return map;
	} // end of HashMap<String, Object> getSelectFolderInfo(String idx) ------------------------------------------ 

	// 선택한 요소의 정보를 수정하기
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int do_goModalEdit(HttpSession ses, FolderVO fvo, List<Folder_TeamwonVO> ftList, List<Folder_FileVO> ffList, String[] delFileArr) {
		dao.do_goModalEdit(fvo); // 요소 정보 수정하기
		int result = 0;
		
		// 첨부파일 삭제
		String root = ses.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator+"files";
		for(int i=0; delFileArr != null && i<delFileArr.length; i++) {
			dao.deleteFolderFile(delFileArr[i]); // DB에서 목록 지우고
			try {
				fileManager.doFileDelete(delFileArr[i], path); // 서버에서는 파일 지운다.
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 새로 첨부한 파일 관리하기 시작
		if(ffList != null && ffList.size() != 0) { // 첨부된 파일이 있다면
			for(Folder_FileVO ffvo : ffList) {
				dao.insertFolderFile(ffvo); // DB에 파일 정보를 넣어줌
			}
		} // 새로 첨부한 파일 관리하기 끝
		
		// 요소의 수정된 팀원 정보를 tbl_folder_teamwon 에 업데이트 혹은 인서트 하기 시작 
		dao.updateAllFolderTeamwon(fvo.getIdx()); // 먼저 해당 요소의 팀원을 전부 탈퇴상태로 업데이트 후
		for(Folder_TeamwonVO ftvo : ftList) {
			result = dao.updateFolderTeamwon(ftvo); // 만약 해당 요소에 이미 등록돼있던 팀원이라면 일반상태로 업데이트 후에 1을 받아올테고
			if(result == 0) { // 없다면 0 을 받아오므로
				result = dao.insertFolderTeamwon(ftvo); // 없던 팀원이라면 새로 insert 해준다. 
			}
		} 
		// 요소의 수정된 팀원 정보를 tbl_folder_teamwon 에 업데이트 혹은 인서트 하기 끝
		
		return result;
	} // end of int do_goModalEdit(FolderVO fvo) --------------------------------------------------------------------

	// 할일 완료, 미완료 처리하기
	public void setTaskComplete(FolderVO fvo) {
		dao.setTaskComplete(fvo);
	} // end of void setTaskComplete(FolderVO fvo) ---------------------------------------------------------------------

	// 요소 추가시 참조값 가져오기
	public HashMap<String, String> getUpFolder(String upIdx) {
		HashMap<String, String> map = null;
		if(upIdx.equals("0")) { // 만약 최상위 요소 추가 라면 
			map = dao.getMaxGroupNo(upIdx); // 마지막 groupNo 을 받아오고
		} else { // 하위 요소 추가 라면
			map = dao.getUpFolder(upIdx); // 상위 요소의 groupNo 을 받아온다.
		}
		return map;
	} // end of HashMap<String, String> getUpFolder(int upIdx) --------------------------------------------------------

	// 현재 팀의 소속된 팀원 목록을 가져오기
	public List<HashMap<String, String>> getTeamwonList(String team_idx) {
		List<HashMap<String, String>> teamwonList = dao.getTeamwonList(team_idx);
		return teamwonList;
	} // end of List<HashMap<String, String>> getTeamwonList(String team_idx) --------------------------------------------------

	// 요소 추가하기(+추가된 요소에 소속된 담당들도 folder_teamwon 테이블에 추가)
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public HashMap<String, Object> addDownElementEnd(FolderVO fvo, HashMap<String, Object> map, String term, String page, List<Folder_FileVO> ffList) {
		int result1 = dao.addDownElement(fvo); // 하위요소 추가하기
		int result2 = dao.addDoTeamwon(map); // 하위요소 추가할때 담당 팀원 추가하기(가장 최근에 올라온 folderIdx를 구해서 입력주는 방식임)
		List<FolderVO> doList = dao.getAddedElement(); // 방금 추가한 요소를 가져오기
		
		// 새로 첨부한 파일 관리하기 시작
		if(ffList != null && ffList.size() != 0) { // 첨부된 파일이 있다면
			for(Folder_FileVO ffvo : ffList) {
				ffvo.setFk_folder_idx(doList.get(0).getIdx()); // 새로 추가되는걸 받아와야 하는거라 수정과는 다르게 이렇게 처리함
				dao.insertFolderFile(ffvo); // DB에 파일 정보를 넣어줌
			}
		} // 새로 첨부한 파일 관리하기 끝
		
		doList = dao.getAddedElement(); // TODO 파일 목록까지 최신화 하려고 한번 더 가져옴 ㅠㅠ 뭔가 더 효율적인 방법은..?
		fvo = doList.get(0); // 동적으로 페이지를 재구성하기 위해 vo도 하나 넘겨줌	
		
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
		
		map = new HashMap<String, Object>();
		map.put("result", result1*result2);
		map.put("doList", doList);
		map.put("fvo", fvo);
		map.put("pageDateList", pageDateList);
		
		return map;
	} // end of int addDownElementEnd(FolderVO fvo, HashMap<String, Object> map) -----------------------------------------------------

	// 선택한 요소와 그 하위요소들 삭제하기
	public HashMap<String, Integer> delElement(String idx, String fk_folder_idx) {
		int result = dao.delElement(idx);
		int downCnt = dao.getDownCnt(fk_folder_idx);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		map.put("downCnt", downCnt);
		return map;
	} // end of int delElement(String idx) ----------------------------------------------------------------------------------------

	// 요소에 댓글 추가하고 새로운 댓글 리스트 받아오기
	public HashMap<String, Object> addComment(Folder_CommentVO fcvo, PageVO pvo) {
		int result = dao.addComment(fcvo);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			List<Folder_CommentVO> folder_commentList = dao.getFolder_commentInfo(pvo);
			map.put("folder_commentList", folder_commentList);
			pvo = getCommentPagingBar(pvo);
			map.put("pvo", pvo);
		}
		return map;
	} // end of List<Folder_CommentVO> addComment(Folder_CommentVO fcvo, String teamwon_idx) --------------------------------------------------------
	
	// 특정 페이지의 댓글 리스트 가져오기
	public HashMap<String, Object> getFolder_commentInfo(PageVO pvo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Folder_CommentVO> folder_commentList = dao.getFolder_commentInfo(pvo);
		pvo = getCommentPagingBar(pvo);
		
		map.put("folder_commentList", folder_commentList);
		map.put("pvo", pvo);
		return map;
	} // end of List<Folder_CommentVO> getFolder_commentInfo(PageVO pvo) -----------------------------------------------------------------------------------
	
	// 내가 속한 요소의 idx 받아오기
	public HashMap<String, Object> getMyElement(HashMap<String, String> map) {
		List<String> idxListByElement = dao.getMyElement(map);
		HashMap<String, String> periodCntMap = dao.getPeriodCntByTeamwon(map);
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("idxListByElement", idxListByElement);
		returnMap.put("periodCntMap", periodCntMap);
		return returnMap;
	} // end of public List<String> getMyElement(HashMap<String, String> map) ---------------------------------------------------------------
	
	// 검색한 요소의 idx 받아오기
	public HashMap<String, Object> getSearchElement(HashMap<String, String> map) {
		List<String> idxListByElement = dao.getSearchElement(map);
		HashMap<String, String> periodCntMap = dao.getPeriodCntBySearch(map);
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("idxListByElement", idxListByElement);
		returnMap.put("periodCntMap", periodCntMap);
		return returnMap;
	} // end of public List<String> getMyElement(HashMap<String, String> map) ---------------------------------------------------------------
	
	// 특정 요소와 그 하위요소들을 다른 상위요소로 이동하기
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int elementMove(FolderVO fvo) {
		dao.elementMoveByFkIdx(fvo); // 1. 이동하는 첫번째 요소의 fk_folder_idx 변경해주기
		int result = dao.elementMoveByGroup(fvo); // 2. 이동하는 모든 요소의 groupNo, depth 변경해주기
		return result;
	} // end of int elementMove(FolderVO fvo) ----------------------------------------------------------------------------------------------------
	
	
	// 페이징 처리하기(PageVO 를 받아서 setPageBar 후에 해당 PagaVO 를 반환하는 방식)
	public PageVO getCommentPagingBar(PageVO pvo) {
		int idx = pvo.getShowIdx();
		int selectPage = pvo.getSelectPage();
		int sizePerPage = pvo.getSizePerPage();
		int blockSize = pvo.getBlockSize();
		String function = pvo.getFunction();
		
		int totalCommentCnt = dao.getTotalCommentCnt(idx);
		int totalPageCnt = (int)Math.ceil((double)totalCommentCnt/sizePerPage);
		
		int pageNo = ( ((selectPage-1)/blockSize)*blockSize )+1;
		
		String pageBar = "";
		if(pageNo != 1) {
			pageBar += "<span style='color:blue; font-size:10pt; cursor:pointer;' onclick='"+function+"(\""+(pageNo-10)+"\")'>[이전10페이지]&#160;</span>";
		} else {
			pageBar += "<span>[...]&#160;</span>";
		}
		for(int i = 0; i < blockSize && pageNo <= totalPageCnt; i++) {
			if(pageNo == selectPage) {
				pageBar += "<span style='color:red; font-size:10pt; cursor:pointer;'>"+pageNo+"&#160;</span>";
			} else {
				pageBar += "<span style='color:blue; font-size:10pt; cursor:pointer;' onclick='"+function+"(\""+pageNo+"\")'>"+pageNo+"&#160;</span>";
			}
			pageNo++;
		}
		if(pageNo <= totalPageCnt) {
			pageBar += "<span style='color:blue; font-size:10pt; cursor:pointer;' onclick='"+function+"(\""+pageNo+"\")'>&#160;[다음10페이지]</span>";
		} else {
			pageBar += "<span>&#160;[...]</span>";
		}
		pvo.setPageBar(pageBar);
		return pvo;
	} // end of String getCommentPagingBar(PageVO pvo) -----------------------------------------------------------------------------------------------------
}





















