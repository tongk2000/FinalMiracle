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
import com.miracle.kdh.service.ProjectManagerService;
import com.miracle.psw.model.MemberVO;
import com.miracle.psw.service.MemberService;

@Controller
public class ProjectMangerController {
	@Autowired
	ProjectManagerService svc;
	
	@Autowired
	MemberService msvc; // 추후. 팀 세션 정보 추가되면 삭제해야함
	
	// 모든 폴더, 할일 리스트를 가져오는 메소드
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
		List<FolderVO> doList = svc.getAllDoList(teamInfo.get("team_idx"));
		req.setAttribute("doList", doList);
		
		return "kdh/doList.all";
	} // end of String doList (HttpServletRequest req) ----------------------------------------------------------------
	
	// 선택한 폴더의 모든 정보를 가져오기
	@RequestMapping(value="do_getSelectFolderInfo.mr", method={RequestMethod.GET})
	public String do_getSelectFolderInfo(HttpServletRequest req) {
		String idx = req.getParameter("idx");
		HashMap<String, Object> map = svc.do_getSelectFolderInfo(idx);
		req.setAttribute("fvo", map.get("fvo"));
		req.setAttribute("folder_teamwonList", map.get("folder_teamwonList"));
		req.setAttribute("folder_commentList", map.get("folder_commentList"));
		return "kdh/modal/modalFolder.not";
	} // end of String do_getSelectFolderInfo(HttpServletRequest req) -----------------------------------------------
	
	// 선택한 할일의 모든 정보를 가져오기
	@RequestMapping(value="do_getSelectTaskInfo.mr", method={RequestMethod.GET})
	public String do_getSelectTaskInfo(HttpServletRequest req) {
		String idx = req.getParameter("idx");
		HashMap<String, Object> map = svc.do_getSelectFolderInfo(idx);
		req.setAttribute("fvo", map.get("fvo"));
		req.setAttribute("folder_teamwonList", map.get("folder_teamwonList"));
		req.setAttribute("folder_commentList", map.get("folder_commentList"));
		return "kdh/modal/modalTask.not";
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
		
		HashMap<String, String> map = svc.getUpFolder(upIdx);
		map.put("upIdx",upIdx);
		
		req.setAttribute("map", map);
		
		return "kdh/popup/addDownElement.not";
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
		
		HashMap<String, Object> returnMap = svc.addDownElementEnd(fvo, map); // 트랜잭션 결과와 새로 추가된 요소의 정보를 가져옴 
		
		req.setAttribute("returnMap", returnMap);
		
		return "kdh/popup/addDownElementEnd.not";
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
		System.out.println(str_json);
		return "kdh/json.not";
	} // end of public String getTeamwonList(HttpServletRequest req) --------------------------------------------------------------
	
	// 선택한 요소와 그 하위요소들 삭제하기
	@RequestMapping(value="do_delElement.mr", method={RequestMethod.POST})
	public String delElement(HttpServletRequest req) {
		String idx = req.getParameter("idx");
		int result = svc.delElement(idx);
		String str_json = "{result:"+result+"}";
		req.setAttribute("str_json", str_json);
		return "kdh/json.not";
	} // end of public String delElement(HttpServletRequest req) --------------------------------------------------------------
}


























