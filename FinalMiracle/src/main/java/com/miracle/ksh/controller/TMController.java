package com.miracle.ksh.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.service.ProjectManagerService;
import com.miracle.ksh.model.TeamVO;
import com.miracle.ksh.model.TeamwonVO;
import com.miracle.ksh.service.InterTMService;
import com.miracle.ksh.util.MyUtil;
import com.miracle.psw.model.MemberVO;
import com.miracle.psw.service.MemberService;

@Controller
public class TMController {
	
	@Autowired
	private InterTMService service;
	
	@Autowired
	ProjectManagerService svc;
	
	@Autowired
	MemberService msvc;
	
	@RequestMapping(value="/tmList.mr", method={RequestMethod.GET})
	public String tmList(HttpServletRequest req, HttpSession session){
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		List<HashMap<String, String>> tmList = null;
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		String gobackURL = MyUtil.getCurrentURL(req);
		
		String fk_team_idx = teamInfo.get("team_idx");
		String teamwon_status = teamInfo.get("teamwon_status");
		
		HashMap<String, String> tmMap = new HashMap<String, String>();
		tmMap.put("colname", colname);
		tmMap.put("search", search);
		tmMap.put("fk_team_idx", fk_team_idx);
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		String str_sizePerPage = req.getParameter("sizePerPage");
		
		int totalCount = 0; //총 게시물 건수	
		int sizePerPage = 0; //한 페이지 당 보여줄 게시물 수
		int currentShowPageNo = 0; //현재 보여주는 페이지 번호, 초기치는 1
		int totalPage = 0;//총 페이지 수 (웹브라우저에 보여주는 총 페이지 수)
		
		int startRno = 0; //시작 행 번호
		int endRno = 0; //끝 행 번호
		int blockSize = 10; //"페이지바"에 보여줄 페이지의 갯수
		
		if(str_currentShowPageNo == null){
			//게시판의 초기화면
			currentShowPageNo = 1;
		} else {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		}
		
		if(str_sizePerPage == null){
			//게시판의 초기화면
			sizePerPage = 5;
		} else {
			sizePerPage = Integer.parseInt(str_sizePerPage);
		}
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno =  startRno + sizePerPage - 1;
				
		tmMap.put("startRno", String.valueOf(startRno));
		tmMap.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			tmList = service.tmList2(tmMap);
		} else{
			//검색어가 없는 경우
			tmList = service.tmList1(tmMap);
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.TMTotalCount2(tmMap);
		} else{
			//검색어가 없는 경우
			totalCount = service.TMTotalCount1(tmMap);
		}
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "tmList.mr");	
		
		pagebar += "</ul>";
		
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalCount", totalCount);
		
		req.setAttribute("tmList", tmList);
		req.setAttribute("teamwon_status", teamwon_status);
		req.setAttribute("gobackURL", gobackURL);
		
		
		return "ksh/tm/tmlist.all";
	}
	
	@RequestMapping(value="/tmForm.mr", method={RequestMethod.GET})
	public String tmForm(HttpServletRequest req){
		
		HttpSession ses = req.getSession();
		
		MemberVO loginUser = (MemberVO) ses.getAttribute("loginUser");
		
		//System.out.println("확인용 : " + loginUser.getIdx());
		
		String fk_member_idx = String.valueOf(loginUser.getIdx());
		
		List<HashMap<String, String>> teamlist1 = service.getTeamList1(fk_member_idx);
		List<HashMap<String, String>> teamlist2 = service.getTeamList2(fk_member_idx);
		
		req.setAttribute("teamlist1", teamlist1);
		req.setAttribute("teamlist2", teamlist2);
		
		return "ksh/tm/tmForm.not";
	}
	
	@RequestMapping(value="/tmCreate.mr", method={RequestMethod.GET})
	public String tmCreate(HttpServletRequest req){
		
		
		return "ksh/tm/tmCreate.not";
	}
	
	
	@RequestMapping(value="/tmCreateEnd.mr", method={RequestMethod.POST})
	public String tmCreateEnd(HttpServletRequest req){
		
		HttpSession ses = req.getSession();
		
		MemberVO loginUser = (MemberVO) ses.getAttribute("loginUser");
		
		String fk_member_idx = String.valueOf(loginUser.getIdx());
		String name = req.getParameter("String");
		String hp1 = req.getParameter("hp1");
		String hp2 = req.getParameter("hp2");
		String hp3 = req.getParameter("hp3");
		String post1 = req.getParameter("post1");
		String post2 = req.getParameter("post2");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		
		HashMap<String, String> tmMap = new HashMap<String, String>();
		tmMap.put("fk_member_idx", fk_member_idx);
		tmMap.put("name", name);
		tmMap.put("hp1", hp1);
		tmMap.put("hp2", hp2);
		tmMap.put("hp3", hp3);
		tmMap.put("post1", post1);
		tmMap.put("post2", post2);
		tmMap.put("addr1", addr1);
		tmMap.put("addr2", addr2);
		
		
		int n = service.TeamCreate(tmMap);
		
		req.setAttribute("n", n);
		
		return "ksh/msg.not";
	}
	
	@RequestMapping(value="/tmSession.mr", method={RequestMethod.GET})
	public String tmSession(HttpServletRequest req, HttpSession session){
		
		session = req.getSession();
		
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		String fk_member_idx = String.valueOf(loginUser.getIdx());
		String fk_team_idx1 = req.getParameter("team_idx1");
		String fk_team_idx2 = req.getParameter("team_idx2");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fk_member_idx", fk_member_idx);
		if(fk_team_idx1 == null || fk_team_idx1.trim().isEmpty()){
			map.put("fk_team_idx", fk_team_idx2);
		} else if(fk_team_idx2 == null || fk_team_idx2.trim().isEmpty()){
			map.put("fk_team_idx", fk_team_idx1);
		}

		String teamwon_idx = service.getTeamwonIDX(map);
		String teamwon_status = service.getTeamwonStatus(map);
		
		HashMap<String, String> sessionMap = new HashMap<String, String>();
		if(fk_team_idx1 == null || fk_team_idx1.trim().isEmpty()){
			sessionMap.put("team_idx", fk_team_idx2);
		} else if(fk_team_idx2 == null || fk_team_idx2.trim().isEmpty()){
			sessionMap.put("team_idx", fk_team_idx1);
		}
		sessionMap.put("teamwon_idx", teamwon_idx);
		sessionMap.put("teamwon_status", teamwon_status);
		
		//System.out.println("확인용 : " + fk_member_idx + " / " + fk_team_idx1 + " / " + fk_team_idx2 + " / " + teamwon_idx + " / " + teamwon_status);
		
		session.setAttribute("teamInfo", sessionMap);
		
		List<FolderVO> doList = null;
		
		if(fk_team_idx1 == null || fk_team_idx1.trim().isEmpty()){
			doList = svc.getAllDoList(fk_team_idx2);
		} else if(fk_team_idx2 == null || fk_team_idx2.trim().isEmpty()){
			doList = svc.getAllDoList(fk_team_idx1);
		}
		
		req.setAttribute("doList", doList);
		
		return "kdh/doList.all";
	}
	
	
	@RequestMapping(value="/tmAddress.mr", method={RequestMethod.GET})
	public String tmAddress(HttpServletRequest req, HttpSession session){
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		List<HashMap<String, String>> tmAddrList = null;
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		String gobackURL = MyUtil.getCurrentURL(req);
		
		String fk_team_idx = teamInfo.get("team_idx");
		String teamwon_status = teamInfo.get("teamwon_status");
		
		HashMap<String, String> tmMap = new HashMap<String, String>();
		tmMap.put("colname", colname);
		tmMap.put("search", search);
		tmMap.put("fk_team_idx", fk_team_idx);
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		String str_sizePerPage = req.getParameter("sizePerPage");
		
		int totalCount = 0; //총 게시물 건수	
		int sizePerPage = 0; //한 페이지 당 보여줄 게시물 수
		int currentShowPageNo = 0; //현재 보여주는 페이지 번호, 초기치는 1
		int totalPage = 0;//총 페이지 수 (웹브라우저에 보여주는 총 페이지 수)
		
		int startRno = 0; //시작 행 번호
		int endRno = 0; //끝 행 번호
		int blockSize = 10; //"페이지바"에 보여줄 페이지의 갯수
		
		if(str_currentShowPageNo == null){
			//게시판의 초기화면
			currentShowPageNo = 1;
		} else {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		}
		
		if(str_sizePerPage == null){
			//게시판의 초기화면
			sizePerPage = 5;
		} else {
			sizePerPage = Integer.parseInt(str_sizePerPage);
		}
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno =  startRno + sizePerPage - 1;
				
		tmMap.put("startRno", String.valueOf(startRno));
		tmMap.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			tmAddrList = service.tmAddrList2(tmMap);
		} else{
			//검색어가 없는 경우
			tmAddrList = service.tmAddrList1(tmMap);
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.TMTotalCount2(tmMap);
		} else{
			//검색어가 없는 경우
			totalCount = service.TMTotalCount1(tmMap);
		}
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "tmAddress.mr");	
		
		pagebar += "</ul>";
		
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalCount", totalCount);
		
		req.setAttribute("tmAddrList", tmAddrList);
		req.setAttribute("teamwon_status", teamwon_status);
		req.setAttribute("gobackURL", gobackURL);
		
		return "ksh/tm/tmaddress.all";
	}
	
	
	@RequestMapping(value="/tmWithdraw.mr", method={RequestMethod.GET})
	public String tmWithdraw(HttpServletRequest req, HttpSession session){
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		String fk_member_idx = String.valueOf(loginUser.getIdx());
		String fk_team_idx = teamInfo.get("team_idx");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fk_member_idx", fk_member_idx);
		map.put("fk_team_idx", fk_team_idx);
		
		int n = service.tmWithDraw(map);
		
		if(n>0){
			String msg = "팀장이 최종적으로 승인해야 탈퇴 처리 됩니다.";
			String loc = "tmList.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "탈퇴 요청에 실패하였습니다.";
			String loc = "tmList.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}
				
	}
	
	@RequestMapping(value="/tmWithdrawList.mr", method={RequestMethod.GET})
	public String tmWithdrawList(HttpServletRequest req, HttpSession session){
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		String fk_member_idx = String.valueOf(loginUser.getIdx());
		String fk_team_idx = teamInfo.get("team_idx");
		String teamwon_status = teamInfo.get("teamwon_status");
		
		//System.out.println("확인용 : " + fk_team_idx);
		
		List<HashMap<String, String>> reqwdList = null;
		
		String colname1 = req.getParameter("colname1");
		String search1 = req.getParameter("search1");
		String gobackURL1 = MyUtil.getCurrentURL(req);
		
		HashMap<String, String> map1 = new HashMap<String, String>();
		map1.put("fk_member_idx", fk_member_idx);
		map1.put("fk_team_idx", fk_team_idx);
		map1.put("colname1", colname1);
		map1.put("search1", search1);
		
		String str_currentShowPageNo1 = req.getParameter("currentShowPageNo1");
		String str_sizePerPage1 = req.getParameter("sizePerPage1");
		
		int totalCount1 = 0; //총 게시물 건수	
		int sizePerPage1 = 0; //한 페이지 당 보여줄 게시물 수
		int currentShowPageNo1 = 0; //현재 보여주는 페이지 번호, 초기치는 1
		int totalPage1 = 0;//총 페이지 수 (웹브라우저에 보여주는 총 페이지 수)
		
		int startRno1 = 0; //시작 행 번호
		int endRno1 = 0; //끝 행 번호
		int blockSize1 = 10; //"페이지바"에 보여줄 페이지의 갯수
		
		if(str_currentShowPageNo1 == null){
			//게시판의 초기화면
			currentShowPageNo1 = 1;
		} else {
			currentShowPageNo1 = Integer.parseInt(str_currentShowPageNo1);
		}
		
		if(str_sizePerPage1 == null){
			//게시판의 초기화면
			sizePerPage1 = 5;
		} else {
			sizePerPage1 = Integer.parseInt(str_sizePerPage1);
		}
		
		startRno1 = ((currentShowPageNo1 - 1) * sizePerPage1) + 1;
		endRno1 =  startRno1 + sizePerPage1 - 1;
				
		map1.put("startRno1", String.valueOf(startRno1));
		map1.put("endRno1", String.valueOf(endRno1));
		
		if( (colname1 != null && search1 != null) && (!colname1.trim().isEmpty() && !search1.trim().isEmpty()) && (!colname1.equals("null") && !search1.equals("null"))){
			//검색어가 있	는 경우
			reqwdList = service.tmReqWithDrawList2(map1);
		} else{
			//검색어가 없는 경우
			reqwdList = service.tmReqWithDrawList1(map1);
		}
		
		if( (colname1 != null && search1 != null) && (!colname1.trim().isEmpty() && !search1.trim().isEmpty()) && (!colname1.equals("null") && !search1.equals("null"))){
			//검색어가 있는 경우
			totalCount1 = service.TMReqWDTotalCount2(map1);
		} else{
			//검색어가 없는 경우
			totalCount1 = service.TMReqWDTotalCount1(map1);
		}
		
		totalPage1 = (int)Math.ceil((double)totalCount1/sizePerPage1);
		
		String pagebar1 = "<ul>";
		
		pagebar1 += MyUtil.getPageBarWithSearch(sizePerPage1, blockSize1, totalPage1, currentShowPageNo1, colname1, search1, null, "tmWithdrawList.mr");	
		
		pagebar1 += "</ul>";
		
		
		req.setAttribute("pagebar1", pagebar1);
		req.setAttribute("colname1", colname1);
		req.setAttribute("search1", search1);
		req.setAttribute("sizePerPage1", sizePerPage1);
		req.setAttribute("totalCount1", totalCount1);
		req.setAttribute("gobakcURL1", gobackURL1);
		
		
		
		// ==========================================================================================================

		List<TeamwonVO> wdList = null;
				
		String colname2 = req.getParameter("colname2");
		String search2 = req.getParameter("search2");
		String gobackURL2 = MyUtil.getCurrentURL(req);
		
		HashMap<String, String> map2 = new HashMap<String, String>();
		map2.put("fk_member_idx", fk_member_idx);
		map2.put("fk_team_idx", fk_team_idx);
		map2.put("colname1", colname2);
		map2.put("search1", search2);
		
		String str_currentShowPageNo2 = req.getParameter("currentShowPageNo2");
		String str_sizePerPage2 = req.getParameter("sizePerPage2");
		
		int totalCount2 = 0; //총 게시물 건수	
		int sizePerPage2 = 0; //한 페이지 당 보여줄 게시물 수
		int currentShowPageNo2 = 0; //현재 보여주는 페이지 번호, 초기치는 1
		int totalPage2 = 0;//총 페이지 수 (웹브라우저에 보여주는 총 페이지 수)
		
		int startRno2 = 0; //시작 행 번호
		int endRno2 = 0; //끝 행 번호
		int blockSize2 = 10; //"페이지바"에 보여줄 페이지의 갯수
		
		if(str_currentShowPageNo2 == null){
			//게시판의 초기화면
			currentShowPageNo2 = 1;
		} else {
			currentShowPageNo2 = Integer.parseInt(str_currentShowPageNo2);
		}
		
		if(str_sizePerPage2 == null){
			//게시판의 초기화면
			sizePerPage2 = 5;
		} else {
			sizePerPage2 = Integer.parseInt(str_sizePerPage2);
		}
		
		startRno2 = ((currentShowPageNo2 - 1) * sizePerPage2) + 1;
		endRno2 =  startRno2 + sizePerPage2 - 1;
				
		map2.put("startRno2", String.valueOf(startRno2));
		map2.put("endRno2", String.valueOf(endRno2));
		
		if( (colname2 != null && search2 != null) && (!colname2.trim().isEmpty() && !search2.trim().isEmpty()) && (!colname2.equals("null") && !search2.equals("null"))){
			//검색어가 있	는 경우
			wdList = service.tmWithDrawList2(map2);
		} else{
			//검색어가 없는 경우
			wdList = service.tmWithDrawList1(map2);
		}
		
		if( (colname2 != null && search2 != null) && (!colname2.trim().isEmpty() && !search2.trim().isEmpty()) && (!colname2.equals("null") && !search2.equals("null"))){
			//검색어가 있는 경우
			totalCount2 = service.TMWDTotalCount2(map2);
		} else{
			//검색어가 없는 경우
			totalCount2 = service.TMWDTotalCount1(map2);
		}
		
		totalPage2 = (int)Math.ceil((double)totalCount2/sizePerPage2);
		
		String pagebar2 = "<ul>";
		
		pagebar2 += MyUtil.getPageBarWithSearch(sizePerPage2, blockSize2, totalPage2, currentShowPageNo2, colname2, search2, null, "tmWithdrawList.mr");	
		
		pagebar2 += "</ul>";
		
		
		
		
		req.setAttribute("pagebar2", pagebar2);
		req.setAttribute("colname2", colname2);
		req.setAttribute("search2", search2);
		req.setAttribute("sizePerPage2", sizePerPage2);
		req.setAttribute("totalCount2", totalCount2);
		req.setAttribute("gobakcURL2", gobackURL2);
				
		// ==========================================================================================================
		
		req.setAttribute("reqwdList", reqwdList);
		req.setAttribute("wdList", wdList);
		req.setAttribute("teamwon_status", teamwon_status);	
		
		return "ksh/tm/tmwithdraw.all";
	}
	
	
	@RequestMapping(value="/tmWithdrawEnd.mr", method={RequestMethod.GET})
	public String tmWithdrawEnd(HttpServletRequest req, HttpSession session){
		
		String idx = req.getParameter("idx");
		String gobackURL = req.getParameter("gobackURL");
		
		/*
		int n = service.tmWithDrawEnd(idx);
		
		if(n>0){
			String msg = "탈퇴 처리가 완료되었습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "탈퇴 처리에 실패하였습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}
		*/
		
		return "ksh/msg.not";
	}
	
	
	@RequestMapping(value="/tmRestore.mr", method={RequestMethod.GET})
	public String tmRestore(HttpServletRequest req, HttpSession session){
		
		String idx = req.getParameter("idx");
		String gobackURL = req.getParameter("gobackURL");
		
		/*
		int n = service.tmRestore(idx);
		
		if(n>0){
			String msg = "복구 처리가 완료되었습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "복구 처리에 실패하였습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}
		*/
		
		return "ksh/msg.not";
	}
	
}
