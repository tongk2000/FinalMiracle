package com.miracle.jsw.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.jsw.service.InterChattingService;
import com.miracle.psw.model.MemberVO;

@Controller
@Component
public class ChattingController {

	@Autowired
	private InterChattingService service;
	
	@RequestMapping(value="/chatting.mr", method={RequestMethod.GET})
	public String chatting(HttpServletRequest req, HttpServletResponse res){
		
		// 채팅방 정보 얻어오기
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		
		// 맴버번호로 자신이 포함된 채팅방리스트 얻어오기
		List<HashMap<String, Object>> roomList = service.getChatRoom(idx);
		
		req.setAttribute("roomList", roomList);
		
		
		
		
		
		
		
		
		
		return "jsw/chatting.all";
	//	return "jsw/chattingAjax.all";
	}
	
	
	
}
