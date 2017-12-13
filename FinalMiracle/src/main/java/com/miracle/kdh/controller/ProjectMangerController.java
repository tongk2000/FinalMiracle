package com.miracle.kdh.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.model.Folder_CommentVO;
import com.miracle.kdh.model.PageVO;
import com.miracle.kdh.service.ProjectManagerService;
import com.miracle.psw.model.MemberVO;
import com.miracle.psw.service.MemberService;

@Controller
public class ProjectMangerController {
	@Autowired
	ProjectManagerService svc;
	
	@Autowired
	MemberService msvc; // 추후. 팀 세션 정보 추가되면 삭제해야함
	
	// 초기 페이지의 모든 폴더, 할일 리스트를 가져오기
	@RequestMapping(value="doList.mr", method={RequestMethod.GET})
	public String doList (HttpServletRequest req) {
		HttpSession ses = req.getSession();
		
		// 추후. 여기부터 ~~~~~
		// ses.removeAttribute("loginUser");
		// ses.removeAttribute("teamInfo");
		
		
		if(ses.getAttribute("loginUser") == null) {
			MemberVO mvo = new MemberVO();
			mvo = msvc.getLoginMember("kdh");
			ses.setAttribute("loginUser", mvo);
		}
		if(ses.getAttribute("teamInfo") == null) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("team_idx", "2");
			map.put("teamwon_idx", "3");
			map.put("teamwon_status", "2");
			ses.setAttribute("teamInfo", map);
		}		
		// 여기까지는 나중에 팀 세션 정보 추가되면 삭제해야함
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)ses.getAttribute("teamInfo");
		String team_idx = teamInfo.get("team_idx");
		
		String page = "0"; // 첫화면이므로 초기값 0을 줌
		String term = "7"; // 첫화면이므로 초기값 7을 줌
		req.setAttribute("term", term);	// 페이징 값 유지용
		req.setAttribute("page", page);	// 페이징 값 유지용
		
		HashMap<String, Object> map = svc.getAllDoList(team_idx, page, term); // 할일리스트와 페이징처리를 위한 날짜를 받아옴
		req.setAttribute("map", map);
		
		return "kdh/doList/doList.all";
	} // end of String doList (HttpServletRequest req) ----------------------------------------------------------------
	
	// 페이지 이동한 모든 폴더, 할일 리스트를 가져오기
	@RequestMapping(value="do_changePageDate.mr", method={RequestMethod.GET})
	public String changePageDate(HttpServletRequest req) {
		HttpSession ses = req.getSession();
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)ses.getAttribute("teamInfo");
		String team_idx = teamInfo.get("team_idx");
		
		String visible = (String)req.getParameter("visibleArr"); // 접고 편 상태를 받아와서
		String[] visibleArr = visible.split(","); // ,를 기준으로 배열로 만들고
		req.setAttribute("visibleArr", visibleArr); // 값 유지를 위해 넘겨준다.
		
		String term = req.getParameter("term"); // 페이징 기간을 가져옴
		String page = (String)req.getParameter("page"); // 페이징 이동할 페이지를 가져옴
		req.setAttribute("term", term);	// 페이징 값 유지용
		req.setAttribute("page", page);	// 페이징 값 유지용
		
		HashMap<String, Object> map = svc.getAllDoList(team_idx, page, term); // 할일리스트와 페이징처리를 위한 날짜를 받아옴
		
		@SuppressWarnings("unchecked")
		List<FolderVO> doList = (List<FolderVO>)map.get("doList");
		for(int i=0; i < doList.size(); i++) { // show/hide 값 유지를 위해 visibleArr 값을 doList에 합쳐줌
			doList.get(i).setVisible(visibleArr[i]);
		}
		map.remove("doList"); // 기존 doList 를 지우고
		map.put("doList", doList); // visibleArr 과 합쳐진 doList 를 새로 등록함
		req.setAttribute("map", map);
		
		return "kdh/doList/doList.all";
	}
	
	// 선택한 폴더의 모든 정보를 가져오기
	@RequestMapping(value="do_getSelectFolderInfo.mr", method={RequestMethod.GET})
	public String do_getSelectFolderInfo(HttpServletRequest req) {
		int idx = Integer.parseInt(req.getParameter("idx"));
		PageVO pvo = new PageVO(); 
		pvo.setShowIdx(idx);
		pvo.setSelectPage(1);
		pvo.setSizePerPage(5);
		pvo.setBlockSize(10);		
		pvo.setFunction("goCommentPage");
		
		HashMap<String, Object> map = svc.do_getSelectFolderInfo(pvo);
		req.setAttribute("map", map);
		return "kdh/doList/modal/modalFolder.not";
	} // end of String do_getSelectFolderInfo(HttpServletRequest req) -----------------------------------------------
	
	// 선택한 할일의 모든 정보를 가져오기
	@RequestMapping(value="do_getSelectTaskInfo.mr", method={RequestMethod.GET})
	public String do_getSelectTaskInfo(HttpServletRequest req) {
		int idx = Integer.parseInt(req.getParameter("idx"));
		PageVO pvo = new PageVO();
		pvo.setShowIdx(idx);
		pvo.setSelectPage(1);
		pvo.setSizePerPage(5);
		pvo.setBlockSize(10);
		pvo.setFunction("goCommentPage");
		
		HashMap<String, Object> map = svc.do_getSelectFolderInfo(pvo);
		req.setAttribute("map", map);
		return "kdh/doList/modal/modalTask.not";
	} // end of String do_getSelectFolderInfo(HttpServletRequest req) -----------------------------------------------
	
	// 선택한 폴더의 정보를 수정하기
	@RequestMapping(value="do_goModalEdit.mr", method={RequestMethod.POST})
	public String do_goModalEdit(HttpServletRequest req, FolderVO fvo) {		
		int result = svc.do_goModalEdit(fvo);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		json.put("idx", fvo.getIdx());
		json.put("subject", fvo.getSubject()); // 변경된 제목 적용하기 위해 넘김
		String str_json = json.toString();
		req.setAttribute("str_json", str_json);
		
		return "kdh/json.not";
	} // end of String do_goModalEdit(HttpServletRequest req, FolderVO fvo) ----------------------------------------------
	
	// 할일 완료, 미완료 처리하기
	@RequestMapping(value="do_taskComplete.mr", method={RequestMethod.GET})
	public String do_taskComplete(HttpServletRequest req, FolderVO fvo) {
		svc.setTaskComplete(fvo);
		return "kdh/json.not";
	} // end of String do_taskComplete(HttpServletRequest req, FolderVO fvo) ----------------------------------------------
	
	// 하위폴더 추가 팝업창 띄우기
	@RequestMapping(value="do_addDownElement.mr", method={RequestMethod.GET})
	public String addDownElement(HttpServletRequest req) {
		String upIdx = req.getParameter("upIdx");
		req.setAttribute("upIdx",upIdx); // 상위폴더값 유지용
		
		HashMap<String, String> map = svc.getUpFolder(upIdx);
		
		String term = req.getParameter("term"); // 페이징 기간을 가져옴
		String page = (String)req.getParameter("page"); // 페이징 이동할 페이지를 가져옴
		req.setAttribute("term", term);	// 페이징 값 유지용
		req.setAttribute("page", page);	// 페이징 값 유지용
		
		req.setAttribute("map", map);
		
		return "kdh/doList/popup/addDownElement.not";
	} // end of String addDownElement(HttpServletRequest req) ----------------------------------------------
	
	// 하위요소 추가하기
	@RequestMapping(value="do_addDownElementEnd.mr", method={RequestMethod.POST})
	public String addDownElementEnd(HttpServletRequest req, HttpSession ses, FolderVO fvo) {		
		String[] teamwonIdxArr = req.getParameterValues("teamwonIdx"); // 추가되는 요소에 지정된 담당 팀원목록을 받아옴
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("teamwonIdxArr", teamwonIdxArr);
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)ses.getAttribute("teamInfo"); // 추가하는 팀원이 누구인지 세션에서 가져와서
		fvo.setFk_teamwon_idx( Integer.parseInt(teamInfo.get("teamwon_idx")) ); // FolderVO 에 넣어줌
		
		map.put("teamwon_idx", Integer.parseInt(teamInfo.get("teamwon_idx")) ); // 폴더팀원목록에도 넣어줌(status 다르게 해주기 위함)
		
		String term = req.getParameter("term"); // 페이징 기간을 가져옴
		String page = (String)req.getParameter("page"); // 페이징 이동할 페이지를 가져옴
		
		HashMap<String, Object> endMap = svc.addDownElementEnd(fvo, map, term, page); // 트랜잭션 결과와 새로 추가된 요소의 정보를 가져옴 
		
		req.setAttribute("endMap", endMap);
		
		return "kdh/doList/popup/addDownElementEnd.not";
	} // end of String addDownElementEnd(HttpServletRequest req, FolderVO fvo) ----------------------------------------------
	
	// 팀원 아이디/팀원번호 가져오기
	@RequestMapping(value="do_getTeamwonList.mr", method={RequestMethod.POST})
	public String getTeamwonList(HttpServletRequest req, HttpSession ses) {
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)ses.getAttribute("teamInfo"); // 어떤 팀인지를 세션에서 가져와서
		List<HashMap<String, String>> teamwonList = svc.getTeamwonList(teamInfo.get("team_idx")); // 해당하는 팀번호의 팀원을 가져옴
		
		JSONArray jsonList = new JSONArray(); 
		for(HashMap<String, String> tl : teamwonList) {
			JSONObject jobj = new JSONObject();
			jobj.put("userid", tl.get("userid"));	
			jobj.put("idx", tl.get("idx"));
			jsonList.put(jobj);
		}
		String str_json = jsonList.toString();
		req.setAttribute("str_json", str_json);
		return "kdh/json.not";
	} // end of String getTeamwonList(HttpServletRequest req) --------------------------------------------------------------
	
	// 선택한 요소와 그 하위요소들 삭제하기
	@RequestMapping(value="do_delElement.mr", method={RequestMethod.GET})
	public String delElement(HttpServletRequest req) {
		String idx = req.getParameter("idx");
		String fk_folder_idx = req.getParameter("fk_folder_idx");
		
		HashMap<String, Integer> map = svc.delElement(idx, fk_folder_idx);
		String str_json = "{\"result\":\""+map.get("result")+"\", \"downCnt\":\""+map.get("downCnt")+"\"}"; // JSON 형태로 넘길때는 반드시 {"키값":"밸류값"} 이어야함. 따옴표 주의
		req.setAttribute("str_json", str_json);
		
		return "kdh/json.not";
	} // end of String delElement(HttpServletRequest req) --------------------------------------------------------------
	
	// 요소에 댓글 추가하고 새로운 댓글 리스트 받아오기
	@RequestMapping(value="do_addComment.mr", method={RequestMethod.POST})
	public String addComment(HttpServletRequest req, HttpSession ses, Folder_CommentVO fcvo, PageVO pvo) {
		// 세션에 있는 팀원번호 받아오기 시작
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)ses.getAttribute("teamInfo");
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");
		fcvo.setFk_teamwon_idx(Integer.parseInt(fk_teamwon_idx));
		// 세션에 있는 팀원번호 받아오기 끝
				
		HashMap<String, Object> map = svc.addComment(fcvo, pvo);
		
		req.setAttribute("map", map);
		return "kdh/doList/modal/commentListXML.xml";
	} // end of String addComment(HttpServletRequest req, HttpSession ses, Folder_CommentVO fcvo) -----------------------------------------------------
	
	// 특정 페이지의 댓글 리스트 가져오기
	@RequestMapping(value="do_goCommentPage", method={RequestMethod.GET})
	public String goCommentPage(HttpServletRequest req, PageVO pvo) {
		HashMap<String, Object> map = svc.getFolder_commentInfo(pvo);
		req.setAttribute("map", map);
		return "kdh/doList/modal/modalCommentPage.not";
	} // end of String goCommentPage(HttpServletRequest req, PageVO pvo) ----------------------------------------------------------------------------------
	
}
	 

























