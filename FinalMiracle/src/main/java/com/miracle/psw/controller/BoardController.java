package com.miracle.psw.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.service.InterBoardService;
import com.miracle.psw.util.FileManager;
import com.miracle.psw.util.MyUtil;

@Controller
public class BoardController {

	@Autowired
	private InterBoardService service;
	
	
	@RequestMapping(value="/faqList.mr", method={RequestMethod.GET})
	public String faqList(HttpServletRequest req, HttpSession session) {
		//List<FaqBoardVO> faqList = null;  
		List<FaqBoardVO> faqList = service.faqList();
		
		
		req.setAttribute("faqList", faqList);
		
		return "psw/board/faqlist.all";
	}
	
	
}








