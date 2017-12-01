package com.miracle.kdh.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.service.ProjectManagerService;

@Controller
public class ProjectMangerController {
	@Autowired
	ProjectManagerService svc;
	
	// 모든 폴더, 할일 리스트를 가져오는 메소드
	@RequestMapping(value="doList.mr", method={RequestMethod.GET})
	public String doList (HttpServletRequest req) {
		List<FolderVO> doList = svc.getAllDoList();
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
		System.out.println("idx"+fvo.getIdx());
		System.out.println("status"+fvo.getStatus());
		svc.setTaskComplete(fvo);
		return "kdh/json.not";
	} // end of String do_taskComplete(HttpServletRequest req, FolderVO fvo) ----------------------------------------------
}


























