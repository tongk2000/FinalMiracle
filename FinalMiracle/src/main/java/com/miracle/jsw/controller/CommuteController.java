package com.miracle.jsw.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.jsw.service.InterCommuteService;
import com.miracle.jsw.util.JswUtil;
import com.miracle.psw.model.MemberVO;

@Controller
@Component

public class CommuteController {
	
	@Autowired
	private InterCommuteService service;
	
	@RequestMapping(value="/commute.mr", method={RequestMethod.GET})
	public String commute(HttpServletRequest req, HttpSession ses){
		
		MemberVO loginUser = (MemberVO)ses.getAttribute("loginUser");
		
		List<HashMap<String, String>> commuteList = null;
		List<HashMap<String, String>> userTeamDetail = null;
		
		String month = req.getParameter("month");
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		
		int totalCount = 0; 		// 총 게시물 건수
		int sizePerPage = 10; 		// 한페이지당 보여줄 게시물수
		int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서 초기치는 1페이지로 한다
		int totalPage = 0;			// 총 페이지수(웹브라우저에서 보여줄 총 페이지수)
		
		int startRno = 0;			// 시작행번호
		int endRno = 0;				// 끝 행번호
		
		int blockSize = 10;			// 페이지바에 보여줄 페이지의 갯수
		
		if(str_currentShowPageNo == null){
			currentShowPageNo = 1;
		}
		else{
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		}
		
		startRno = ((currentShowPageNo -1)*sizePerPage)+1;
		endRno = startRno + sizePerPage -1;
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("month", month);
		map.put("idx", String.valueOf(loginUser.getIdx()));
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if(month != null && !month.trim().isEmpty() && !month.equals("null")){
			// 검색어가 있는경우
			commuteList = service.commuteListMonth(map); 
			totalCount = service.getTotalCountMonth(map); 
			userTeamDetail = service.getUserTeamDetail(map);
		}
		else{
			// 검색어가 없는경우
			commuteList = service.commuteList(map); 
			totalCount = service.getTotalCount(map);
			userTeamDetail = service.getUserTeamDetail(map);
		}

		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pageBar = "<ul>";
		pageBar += JswUtil.getPageBarWithMonth(sizePerPage, blockSize, totalPage, currentShowPageNo, month, "commute.mr");
		pageBar += "<ul>";
		
		req.setAttribute("pageBar", pageBar);
		req.setAttribute("month", month);
		req.setAttribute("commuteList", commuteList);
		req.setAttribute("userTeamDetail", userTeamDetail);
		
		return "jsw/commute.all";
	}
	
	@RequestMapping(value="/commutestart.mr", method={RequestMethod.GET})
	public String commuteStart(HttpServletRequest req, HttpSession ses){
		
		int idx = ((MemberVO)ses.getAttribute("loginUser")).getIdx();
		
		
		int a = service.startWork(idx);
		int b = service.startWorkLate(idx);
		int n = a+b;
		
		if (n>0) {
			String msg = "출근체크 하였습니다";
			String loc = "commute.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
		}
		else{
			String msg = "출근체크 실패하였습니다";
			String loc = "commute.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
		}
		
		return "jsw/msg.not";
	}
	
	@RequestMapping(value="/commuteend.mr", method={RequestMethod.GET})
	public String commuteEnd(HttpServletRequest req, HttpSession ses){
		
		int idx = ((MemberVO)ses.getAttribute("loginUser")).getIdx();
		
		
		int a = service.endWork(idx);
		int b = service.endWorkEarly(idx);
		int c = service.workLateAndEarlyGo(idx);
		int n = a+b+c;
		
		if (n>0) {
			String msg = "퇴근체크 하였습니다";
			String loc = "commute.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
		}
		else{
			String msg = "퇴근체크 실패하였습니다";
			String loc = "commute.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
		}
		
		return "jsw/msg.not";
	}
	
	@RequestMapping(value="/commuteteam.mr", method={RequestMethod.GET})
	public String commuteteam(HttpServletRequest req){
		
		HashMap<String, String> map = new HashMap<String, String>();

		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		session.getAttribute("teamInfo");
		int idx = loginUser.getIdx();
		map.put("idx", String.valueOf(idx));
		
		List<HashMap<String, String>> userTeamDetail = service.getUserTeamDetail(map);
		
		int twstatus = 1;
		for(int i = 0; i<userTeamDetail.size(); i++){
			twstatus *= Integer.parseInt(String.valueOf(userTeamDetail.get(i).get("twstatus")));
		}

		
		if(twstatus < 2) {
			session.invalidate();
			
			String msg = "접근이 불가합니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "jsw/msg.not";
		}
		else {
			
			List<HashMap<String, String>> teamWonList = null;
			
			String tidx = req.getParameter("tidx");
			map.put("tidx", tidx);
			
			
			teamWonList = service.getTeamWonList(map);
			String teamname = req.getParameter("teamname");
			
			req.setAttribute("teamname", teamname);
			req.setAttribute("teamWonList", teamWonList);
			req.setAttribute("tidx", tidx);
			
			return "jsw/commuteTL.all";
			  
		}
	}
		
		

	
	@RequestMapping(value="/commutetw.mr", method={RequestMethod.GET})
	public String commutetw(HttpServletRequest req){
		
		HashMap<String, String> map = new HashMap<String, String>();

		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		int idx = loginUser.getIdx();
		map.put("idx", String.valueOf(idx));
		
		List<HashMap<String, String>> userTeamDetail = service.getUserTeamDetail(map);
		
		int twstatus = 1;
		for(int i = 0; i<userTeamDetail.size(); i++){
			twstatus *= Integer.parseInt(String.valueOf(userTeamDetail.get(i).get("twstatus")));
		}
		
		String twidx = req.getParameter("idx");
		String username = req.getParameter("username");
		
		
		if(twstatus < 2 || twidx == null || username == null) {
			session.invalidate();
			
			String msg = "접근이 불가합니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "jsw/msg.not";
		}
		else {
			

			List<HashMap<String, String>> commuteList = null;
			
			
			//System.out.println(userid+"!!!!!!!!!!!!!!!!!!!!!");
			
			String month = req.getParameter("month");
			
			String str_currentShowPageNo = req.getParameter("currentShowPageNo");
			
			int totalCount = 0; 		// 총 게시물 건수
			int sizePerPage = 10; 		// 한페이지당 보여줄 게시물수
			int currentShowPageNo = 0;	// 현재 보여주는 페이지번호로서 초기치는 1페이지로 한다
			int totalPage = 0;			// 총 페이지수(웹브라우저에서 보여줄 총 페이지수)
			
			int startRno = 0;			// 시작행번호
			int endRno = 0;				// 끝 행번호
			
			int blockSize = 10;			// 페이지바에 보여줄 페이지의 갯수
			
			if(str_currentShowPageNo == null){
				currentShowPageNo = 1;
			}
			else{
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
			}
			
			startRno = ((currentShowPageNo -1)*sizePerPage)+1;
			endRno = startRno + sizePerPage -1;
			
			map.put("month", month);
			map.put("startRno", String.valueOf(startRno));
			map.put("endRno", String.valueOf(endRno));
			map.put("twidx", twidx);
			
			if(month != null && !month.trim().isEmpty() && !month.equals("null")){
				// 검색어가 있는경우
				commuteList = service.twcommuteListMonth(map); 
				totalCount = service.getTWTotalCountMonth(map); 
			}
			else{
				// 검색어가 없는경우
				commuteList = service.twcommuteList(map); 
				totalCount = service.getTWTotalCount(map);
			}
	
			totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
			
			String pageBar = "<ul>";
			pageBar += JswUtil.getPageBarWithMonth(sizePerPage, blockSize, totalPage, currentShowPageNo, month, "commutetw.mr");
			pageBar += "<ul>";
			
			
			req.setAttribute("idx", twidx);
			req.setAttribute("username", username);
			req.setAttribute("pageBar", pageBar);
			req.setAttribute("month", month);
			req.setAttribute("commuteList", commuteList);
			
			return "jsw/commuteTW.all";
		}
	
	}

	
}
