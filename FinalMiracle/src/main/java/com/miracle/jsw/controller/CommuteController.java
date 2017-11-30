package com.miracle.jsw.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.jsw.service.InterCommuteService;
import com.miracle.jsw.util.JswUtil;

@Controller
@Component

public class CommuteController {
	
	@Autowired
	private InterCommuteService service;
	
	@RequestMapping(value="/commute.mr", method={RequestMethod.GET})
	public String commute(HttpServletRequest req){
		
		List<HashMap<String, String>> commuteList = null;
		
		
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
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if(month != null && !month.trim().isEmpty() && !month.equals("null")){
			// 검색어가 있는경우
			commuteList = service.commuteListMonth(map); 
			totalCount = service.getTotalCountMonth(map); 
		}
		else{
			// 검색어가 없는경우
			commuteList = service.commuteList(map); 
			totalCount = service.getTotalCount();
		}

		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pageBar = "<ul>";
		pageBar += JswUtil.getPageBarWithMonth(sizePerPage, blockSize, totalPage, currentShowPageNo, month, null, "list.action");
		pageBar += "<ul>";
		
		req.setAttribute("pageBar", pageBar);
		req.setAttribute("month", month);
		req.setAttribute("commuteList", commuteList);
		
		return "jsw/commute.all";
	}
	
	@RequestMapping(value="/commutestart.mr", method={RequestMethod.GET})
	public String commuteStart(HttpServletRequest req){
		
		int n = service.startWork();
		
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
	public String commuteEnd(HttpServletRequest req){
		
		int n = service.endWork();
		
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
	
	
	
}
