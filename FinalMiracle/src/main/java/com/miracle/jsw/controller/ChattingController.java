package com.miracle.jsw.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
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
		
	//	return "jsw/chatting.all";
		return "jsw/chattingAjax.all";
	}
	
	@RequestMapping(value="/chattingRoomAjax.mr", method={RequestMethod.GET})
	public String chattingRoomAjax(HttpServletRequest req, HttpServletResponse res){	
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		
		// 맴버번호로 자신이 포함된 채팅방리스트 얻어오기
		List<HashMap<String, Object>> roomList = service.getChatRoom(idx);
		
		req.setAttribute("roomList", roomList); 
		req.setAttribute("idx", idx);
		
		return "jsw/chattingRoomAjax.not";
	}
	
	@RequestMapping(value="/chattingContentAjax.mr", method={RequestMethod.GET})
	public String chattingContentAjax(HttpServletRequest req, HttpServletResponse res){	
		
		String cridx = "";
		if(req.getParameter("cridx")!=null)
		cridx = req.getParameter("cridx");
		else if(req.getParameter("cridx1")!=null)
		cridx = req.getParameter("cridx1");
		
		String message = req.getParameter("message");
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cridx", cridx);
		map.put("idx", idx);
		
		if(message != null){
			map.put("message", message);		
			service.chatting(map);
		}
		
		List<HashMap<String, Object>> chattingList = service.getChattingContent(cridx);
		
		service.read(map);

		
		req.setAttribute("chattingList", chattingList);
		

		
		
		return "jsw/chattingContentAjax.not";
	}
	
	@RequestMapping(value="/chattingMemberAjax.mr", method={RequestMethod.GET})
	public String chattingMessage(HttpServletRequest req, HttpServletResponse res){
		
		String cridx = "";
		if(req.getParameter("cridx")!=null)
		cridx = req.getParameter("cridx");
		else if(req.getParameter("cridx1")!=null)
		cridx = req.getParameter("cridx1");
		
		List<HashMap<String, Object>> chattingMember = service.getChattingMember(cridx);
		req.setAttribute("chattingMember", chattingMember);
		
		return "jsw/chattingMemberList.not";
	}
	
	@RequestMapping(value="/newChatting.mr", method={RequestMethod.GET})
	public String newChating(HttpServletRequest req, HttpServletResponse res){
		
		/*HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();*/
		
		List<HashMap<String, Object>> teamList = service.getAllTeam();
		
		req.setAttribute("teamList", teamList);
		
		
		
	//	List<HashMap<String, Object>> Member = service.getMember();
		
		
		
		return "jsw/newChattingRoom.not";
	}
	
	
	/*@RequestMapping(value="/chattingMessage.mr", method={RequestMethod.GET})
	public String chattingMessage(HttpServletRequest req, HttpServletResponse res){	
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		
		String cridx = req.getParameter("cridx1");
		String message = req.getParameter("message1");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cridx", cridx);
		map.put("message", message);
		map.put("idx", idx);
		
		service.chatting(map);
		
		
		return "jsw/chattingContentAjax.not";
	}*/
	
	
	@RequestMapping(value="/getTeamwonNotMe.mr", method={RequestMethod.GET})
	public String getTeamwonNotMe(HttpServletRequest req, HttpServletResponse res){
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		String tidx = req.getParameter("tidx");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", tidx);
		map.put("idx", idx);
		
		List<HashMap<String, Object>> teamwonList = service.getTeamwonNotMe(map);
		
		req.setAttribute("teamwonList", teamwonList);
		
		
		return "jsw/memberListNotMe.not";
	}
	
	@RequestMapping(value="/getAllNotMe.mr", method={RequestMethod.GET})
	public String getAllNotMe(HttpServletRequest req, HttpServletResponse res){
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		
		List<HashMap<String, Object>> teamwonList = service.getAllNotMe(idx);
		
		req.setAttribute("teamwonList", teamwonList);
		
		
		return "jsw/memberListNotMe.not";
	}
	@RequestMapping(value="/getFindNotMe.mr", method={RequestMethod.GET})
	public String getFindNotMe(HttpServletRequest req, HttpServletResponse res){
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		
		String subject = req.getParameter("subject");
		String what = req.getParameter("what");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("subject", subject);
		map.put("what", what);
		map.put("idx", idx);
		
		List<HashMap<String, Object>> teamwonList = service.getFindNotMe(map);
		
		req.setAttribute("teamwonList", teamwonList);
		
		
		return "jsw/memberListNotMe.not";
	}
	@RequestMapping(value="/newRoom.mr", method={RequestMethod.GET})
	public String newRoom(HttpServletRequest req, HttpServletResponse res) throws Throwable{
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		
		String roomname = req.getParameter("roomname");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("roomname", roomname);
		map.put("idx", idx);
		
		int n = service.newRoom(map);
		
		if(n==3){
			String cridx = service.getCRidxNewRoom();
			List<HashMap<String, Object>> chattingList = service.getChattingContent(cridx);
			req.setAttribute("chattingList", chattingList);
			
			return "jsw/chattingContentAjax.not"; 
		}
		else{
			String msg = "채팅방 생성에 실패하셨습니다";
			String loc = "chatting.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "jsw/msg.not";
			
		}	

	}
	
	@ExceptionHandler(org.springframework.dao.DataIntegrityViolationException.class)
	public String handleDataIntegrityViolationException(HttpServletRequest req){
		 
		String msg = "채팅방 생성에 실패하셨습니다!";
		String ctxpath = req.getContextPath();
		String loc = ctxpath+"/chatting.mr";
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "jsw/msg.not";
	}
	
	
	@RequestMapping(value="/newRoomNewMember.mr", method={RequestMethod.GET})
	public String newRoomNewMember(HttpServletRequest req, HttpServletResponse res){
		
		String[] midxArr = req.getParameterValues("memberidxArr");	
		int length = midxArr.length;
		String cridx = service.getCRidxNewRoom();
		
		service.newRoomNewMember2(midxArr, cridx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("length", length);
		map.put("cridx", cridx);
		
		service.addMemberCntLength(map);
		
		List<HashMap<String, Object>> chattingMember = service.getChattingMember(cridx);
		
		req.setAttribute("chattingMember", chattingMember);
		
		
		return "jsw/chattingMemberList.not";
	}
	
	
	@RequestMapping(value="/addPersonStart.mr", method={RequestMethod.GET})
	public String addPersonStart(HttpServletRequest req, HttpServletResponse res){
		
		String cridx = req.getParameter("cridx");
		
		List<HashMap<String, Object>> teamList = service.getAllTeam();
		
		req.setAttribute("teamList", teamList);
		req.setAttribute("cridx", cridx);
		
		
		return "jsw/addPersonStart.not";
	}
	
	@RequestMapping(value="/addPersonEndchat.mr", method={RequestMethod.GET})
	public String addPersonEndchat(HttpServletRequest req, HttpServletResponse res){
		
		String cridx = req.getParameter("cridx");
		
		List<HashMap<String, Object>> chattingList = service.getChattingContent(cridx);
		req.setAttribute("chattingList", chattingList);
		
		
		
		
		return "jsw/chattingContentAjax.not";
	}
	
	@RequestMapping(value="/addPersonEndmember.mr", method={RequestMethod.GET})
	public String addPersonEndmember(HttpServletRequest req, HttpServletResponse res){
		
		String cridx = req.getParameter("cridx");
		String midx = req.getParameter("memberidx");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cridx", cridx);
		map.put("midx", midx);
		
		service.newRoomNewMember(map);
		service.addMemberCnt(cridx);
		
		List<HashMap<String, Object>> chattingMember = service.getChattingMember(cridx);
		
		req.setAttribute("chattingMember", chattingMember);
		
		
		return "jsw/chattingMemberList.not";
	}
	
	@RequestMapping(value="/outRoom.mr", method={RequestMethod.GET})
	public String outRoom(HttpServletRequest req, HttpServletResponse res){
		
		HttpSession session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		int idx = loginUser.getIdx();
		String cridx = req.getParameter("cridx");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cridx", cridx);
		map.put("idx", idx);
		
		service.outRoom(map);
		service.outRoomCnt(cridx);
		List<HashMap<String, Object>> roomList = service.getChatRoom(idx);
		
		req.setAttribute("roomList", roomList); 
		
		
		return "jsw/chattingRoomAjax.not";
	}
	
	//----------------------------------------------------------------------------//
	
	@RequestMapping(value="/getTeamwonNotChatMember.mr", method={RequestMethod.GET})
	public String getTeamwonNotChatMember(HttpServletRequest req, HttpServletResponse res){
		
		String tidx = req.getParameter("tidx");
		String cridx = req.getParameter("cridx");
		String[] midxArr = service.getChattingRoomMember(cridx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("tidx", tidx);
		map.put("midxArr", midxArr);
		
		if(midxArr != null){
			List<HashMap<String, Object>> teamwonList = service.getTeamwonNotChatMember(map);
			
			req.setAttribute("teamwonList", teamwonList);
		}
		
		return "jsw/memberListNotMe.not";
	}
	
	@RequestMapping(value="/getAllNotChatMember.mr", method={RequestMethod.GET})
	public String getAllNotChatMember(HttpServletRequest req, HttpServletResponse res){
		
		String cridx = req.getParameter("cridx");
		String[] midxArr = service.getChattingRoomMember(cridx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("midxArr", midxArr);
		
		if(midxArr != null){
			List<HashMap<String, Object>> teamwonList = service.getAllNotChatMember(map);
			
			req.setAttribute("teamwonList", teamwonList);
		}
		
		return "jsw/memberListNotMe.not";
	}
	@RequestMapping(value="/getFindNotChatMember.mr", method={RequestMethod.GET})
	public String getFindNotChatMember(HttpServletRequest req, HttpServletResponse res){
		
		String cridx = req.getParameter("cridx");
		String[] midxArr = service.getChattingRoomMember(cridx);
		
		
		
		String subject = req.getParameter("subject");
		String what = req.getParameter("what");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("subject", subject);
		map.put("what", what);
		map.put("midxArr", midxArr);
		
		if(midxArr != null){
			List<HashMap<String, Object>> teamwonList = service.getFindNotChatMember(map);
			
			req.setAttribute("teamwonList", teamwonList);
		}
		
		return "jsw/memberListNotMe.not";
	}
	
	
	@RequestMapping(value="/chattingRoomTitle.mr", method={RequestMethod.GET})
	public String chattingRoomTitle(HttpServletRequest req, HttpServletResponse res){
		
		String cridx = req.getParameter("cridx");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cridx", cridx);
		
		HashMap<String, Object> roominfo = service.getRoomInfo(map);
		req.setAttribute("roominfo", roominfo);
		
		return "jsw/chattingRoomTitle.not";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
