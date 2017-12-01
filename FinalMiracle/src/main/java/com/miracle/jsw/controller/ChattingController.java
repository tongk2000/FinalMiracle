package com.miracle.jsw.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChattingController {

	
	@RequestMapping(value="/chatting.mr", method={RequestMethod.GET})
	public String chatting(HttpServletRequest req, HttpServletResponse res){
		
		return "jsw/chatting.all";
		
	}
	
	
}
