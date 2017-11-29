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

@Controller
@Component

public class CommuteController {
	
	@Autowired
	private InterCommuteService service;
	
	@RequestMapping(value="/commute.mr", method={RequestMethod.GET})
	public String commute(HttpServletRequest req){
		
		List<HashMap<String, String>> commuteList = service.commuteList();
		req.setAttribute("commuteList", commuteList);
		
		return "jsw/commute.all";
	}
	
	@RequestMapping(value="/commutestart.mr", method={RequestMethod.GET})
	public String commuteStart(HttpServletRequest req){
		
		int n = service.startWork();
		
		if (n>0) {
			String msg = "출근체크 하였습니다";
			String loc = "jsw/commute.all";
			
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
			String loc = "jsw/commute.all";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
		}
		
		return "jsw/msg.not";
	}
	
	
	
}
