package com.miracle.kdh.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.model.Folder_CommentVO;
import com.miracle.kdh.model.Folder_FileVO;
import com.miracle.kdh.model.Folder_TeamwonVO;
import com.miracle.kdh.model.PageVO;
import com.miracle.kdh.service.ProjectManagerService;
import com.miracle.kdh.util.FileManagerKDH;
import com.miracle.psw.model.MemberVO;
import com.miracle.psw.service.MemberService;

@Controller
public class ProjectMangerController {
	@Autowired
	ProjectManagerService svc;
	@Autowired
	FileManagerKDH fileManager;
	
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
	
	// 선택한 요소의 정보를 수정하기
	@RequestMapping(value="do_goModalEdit.mr", method={RequestMethod.POST})
	public String do_goModalEdit(HttpServletRequest req, HttpSession ses, MultipartHttpServletRequest freq, FolderVO fvo) {
		// 파일 정보 저장을 위해 세션에 있는 팀원번호 받아오기 시작
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)ses.getAttribute("teamInfo");
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");
		// 파일 정보 저장을 위해 세션에 있는 팀원번호 받아오기 끝 
		
		// ***** 파일 업로드하고 ffvo 에 파일 정보 저장하기 시작 *****
		List<MultipartFile> attachList = freq.getFiles("attach");
		List<Folder_FileVO> ffList = new ArrayList<Folder_FileVO>();  
		if(attachList != null && attachList.size() != 0) { // attach 가 비어있지 않다면(즉, 첨부된 파일이 있다면)
			for(MultipartFile attach : attachList) {
				System.out.println(attach);
				
				String root = ses.getServletContext().getRealPath("/"); // WAS 의 metadata 경로를 알아온다.
				// C:\FinalMiracle\.metadata\.plugins\org.eclipse.wst.server.core\tmp3\wtpwebapps\FinalMiracle\
				
				String path = root+"resources"+File.separator+"files";
				// C:\FinalMiracle\.metadata\.plugins\org.eclipse.wst.server.core\tmp3\wtpwebapps\FinalMiracle\resources\files
				
				String orgFilename = attach.getOriginalFilename(); // 사용자가 올린 원본 파일명
				// 입퇴실체크.jpg
				
				long filesize = attach.getSize(); // 파일크기를 읽어옴
				// 126922
				
				byte[] bytes = null; // 첨부파일을 WAS 디스크에 저장할때 사용되는 용도
				String serFilename = "";
				try {
					bytes = attach.getBytes();
					serFilename = fileManager.doFileUpload(bytes, orgFilename, path);
				} catch (Exception e) {
					e.printStackTrace();
				}
				Folder_FileVO ffvo = new Folder_FileVO();
				ffvo.setFk_folder_idx(fvo.getIdx());
				ffvo.setFk_teamwon_idx(Integer.parseInt(fk_teamwon_idx));
				ffvo.setSerFilename(serFilename);
				ffvo.setOrgFilename(orgFilename);
				ffvo.setFilesize(filesize);
				ffList.add(ffvo);
			}
		}
		// ***** 파일 업로드하고 ffvo 에 파일 정보 저장하기 끝 *****
		
		// ***** 수정되는 요소의 팀원 리스트를 ftvo 에 넣기 시작 *****
		List<Folder_TeamwonVO> ftList = new ArrayList<Folder_TeamwonVO>();
		String[] folder_teamwonIdxArr = req.getParameterValues("folder_teamwonIdxArr");
		for(int i=0; i<folder_teamwonIdxArr.length; i++) {
			Folder_TeamwonVO ftvo = new Folder_TeamwonVO();
			ftvo.setFk_teamwon_idx(Integer.parseInt(folder_teamwonIdxArr[i]));
			ftvo.setFk_folder_idx(fvo.getIdx());
			ftList.add(ftvo);
		} 
		// ***** 수정되는 요소의 팀원 리스트를 ftvo 에 넣기 끝 *****
		
		int result = svc.do_goModalEdit(fvo, ftList, ffList);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		json.put("idx", fvo.getIdx());
		json.put("subject", fvo.getSubject()); // 변경된 제목 적용하기 위해 넘김
		String str_json = json.toString();
		req.setAttribute("str_json", str_json);
		
		return "kdh/json.not";
	} // end of String do_goModalEdit(HttpServletRequest req, FolderVO fvo) ----------------------------------------------
	
	// 첨부파일 다운로드 받기
	@RequestMapping(value="do_fileDownload.mr", method={RequestMethod.GET})
	public void fileDownload(HttpServletRequest req, HttpServletResponse res, HttpSession ses, Folder_FileVO ffvo) {
		String orgFilename = ffvo.getOrgFilename();
		String serFilename = ffvo.getSerFilename();
		
		String root = ses.getServletContext().getRealPath("/");
		// C:\FinalMiracle\.metadata\.plugins\org.eclipse.wst.server.core\tmp3\wtpwebapps\FinalMiracle\
		
		String path = root+"resources"+File.separator+"files";
		// C:\FinalMiracle\.metadata\.plugins\org.eclipse.wst.server.core\tmp3\wtpwebapps\FinalMiracle\resources\files

		boolean flag = false;
		flag = fileManager.doFileDownload(serFilename, orgFilename, path, res);
		if(!flag) { // 다운로드가 실패했다면
			res.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = null;
            
            try {
                  writer = res.getWriter();
                  // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
            } catch (IOException e) {
                  
            }
            
            writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.!!')</script>");      
		}
	}
	
	
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
		
		map = svc.addDownElementEnd(fvo, map, term, page); // 트랜잭션 결과와 새로 추가된 요소의 정보를 가져옴 
		
		req.setAttribute("map", map);
		
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
	@RequestMapping(value="do_goCommentPage.mr", method={RequestMethod.GET})
	public String goCommentPage(HttpServletRequest req, PageVO pvo) {
		HashMap<String, Object> map = svc.getFolder_commentInfo(pvo);
		req.setAttribute("map", map);
		return "kdh/doList/modal/modalCommentPage.not";
	} // end of String goCommentPage(HttpServletRequest req, PageVO pvo) ----------------------------------------------------------------------------------
	
	// 내가 속한 요소의 idx 받아오기
	@RequestMapping(value="do_getMyElement.mr", method={RequestMethod.GET})
	public String getMyElement(HttpServletRequest req, HttpSession ses) {
		@SuppressWarnings("unchecked")
		HashMap<String, String> map = (HashMap<String, String>)ses.getAttribute("teamInfo");		
		HashMap<String, Object> returnMap = svc.getMyElement(map);
		req.setAttribute("map", returnMap);
		return "kdh/doList/getMyElement.xml";
	} // end of public List<String> getMyElement(HashMap<String, String> map) ---------------------------------------------------------------
	
}
	 

























