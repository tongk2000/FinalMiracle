package com.miracle.psw.controller;

import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.psw.model.MemberDetailVO;
import com.miracle.psw.model.MemberVO;
import com.miracle.psw.service.InterMemberService;
import com.miracle.psw.util.GoogleMail;

@Controller
@Component
public class MemberController {
	
	@Autowired  // DI
	private InterMemberService service;	
	
	@RequestMapping(value="/member_login.mr" , method={RequestMethod.GET})
	public String login() {  // 로그인 폼페이지 띄우기(첫화면)
		
		return "psw/login/loginForm.not";
	}
	@RequestMapping(value="/member_loginEnd.mr", method={RequestMethod.POST})
	public String loginEnd(HttpServletRequest req, HttpSession session, MemberVO loginUser) {  // 로그인 완료
		String userid = req.getParameter("userid");
		String pwd = req.getParameter("pwd");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", pwd);
		
		int n = service.loginEnd(map);  // 1로그인 성공, 0 암호불일치, -1아이디없음
		req.setAttribute("n", n);
		
		if (n == 1) {
			loginUser = service.getLoginMember(userid);  // 로그인 정보 받아오기
			session.setAttribute("loginUser", loginUser);
			String gobackURL = (String)session.getAttribute("gobackURL");
			
			req.setAttribute("gobackURL", gobackURL);
			
			session.removeAttribute("gobackURL");
		}
		return "psw/login/loginEndForm.all";
	}  // end of public String loginEnd(HttpServletRequest req, HttpSession session, MemberVO loginUser) ----------------
	
	
	
	@RequestMapping(value="/member_logout.mr", method={RequestMethod.GET})
	public String logout(HttpSession session) {  // 로그아웃시 세션값 삭제
		session.invalidate();
		
		return "psw/login/logout.all";
	}
	
	// === 아이디 찾기 ===
	@RequestMapping(value="/member_idFind.mr")  // 첫 모달창 GET방식, 사용자정보입력시 POST방식
	public String idFind(HttpServletRequest req) {  // 아이디 찾기
		String name = req.getParameter("name");
		String mobile = req.getParameter("mobile");
		String method = req.getMethod();
		
		if(name != null && mobile != null && !name.equals("") && !mobile.equals("") && method.equals("POST")) {
			req.setAttribute("name", name);    
			req.setAttribute("mobile", mobile);
			req.setAttribute("method", method);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("name", name);
			map.put("mobile", mobile);
			
			String userid = service.getUserid(map);
			
			req.setAttribute("userid", userid);
		}
		return "psw/login/idFind.not";
	}
	
	/* 
		=== 비밀번호 찾기 ===
		1.폼에서 userid 와 email 을 입력받아옴(controll)
		2-1.해당 정보와 매칭되는 유저 정보 가져오기(service)
			2.2.매칭되는 정보가 있는지 없는지 controll 단으로 전송
		3-1.정보가 맞을시 인증코드 발송(controll)
			3-2.정보가 틀릴시 메시지 발송(controll)
	*/
	@RequestMapping(value="/member_pwdFind.mr")  // 첫 모달창 GET방식, 사용자정보입력시 POST방식
	public String pwdFind(HttpServletRequest req) {  // 비밀번호 찾기
		String userid = req.getParameter("userid");
		String email = req.getParameter("email");
		String method = req.getMethod();
		
		int n = 0;
		// 비밀번호 찾기 modal창에서 "찾기"버튼 클릭시
		if(userid != null && email != null && !userid.equals("") && !email.equals("") && method.equalsIgnoreCase("post")) { 
			req.setAttribute("userid", userid);
			req.setAttribute("email", email);
			req.setAttribute("method", method);
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userid", userid);
			map.put("email", email);
			
			n = service.getUserExists(map);
			
			if (n == 1) {  // 비밀번호 찾기를 위해 입력한 사용자아이디와 이메일이 DB에 등록된 경우...  인증키 메일 발송
				GoogleMail mail = new GoogleMail();
				
				Random rnd = new Random();  // 인증키를 생성한다.

				try {
					char randchar = ' ';
					int randnum = 0;
					String certificationCode = "";

					// 랜덤한 영문소문자를 5개를 생성
					for (int i = 0; i < 5; i++) {  // min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면...
						// int rndnum = rnd.nextInt(max - min + 1) + min;

						randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
						certificationCode += randchar;
					} // end of for-----------------

					// 랜덤한 숫자(0-9)를 7개를 생성
					for (int i = 0; i < 7; i++) {
						randnum = rnd.nextInt(9 - 0 + 1) + 0;
						certificationCode += randnum;
					} // end of for-----------------

					mail.sendmail(email, certificationCode);
					req.setAttribute("certificationCode", certificationCode);
					
				} catch (Exception e) {  // 비밀번호 찾기를 위해 입력한 사용자아이디와 이메일은 존재하지만 메일발송이 실패한 경우
					e.printStackTrace();
					n = -1;
					req.setAttribute("sendFailmsg", "메일발송이 실패했습니다.");
				} // end of try~catch-------------------------

			} else {  // 비밀번호 찾기를 위해 입력한 사용자아이디와 이메일이 DB에 없는 경우
				n = 0;
			}
			req.setAttribute("n", n);
			req.setAttribute("userid", userid);
			req.setAttribute("email", email);
		}
		return "psw/login/pwdFind.not";
	}  // end of public String pwdFind(HttpServletRequest req) -----------------------------------
	
	
	@RequestMapping(value="/member_pwdConfirm.mr")
	public String pwdConfirm(HttpServletRequest req) {  // 비밀번호 변경
		String method = req.getMethod();
		String userid = req.getParameter("userid");
		
		req.setAttribute("method", method);
		req.setAttribute("userid", userid);
		
		if(method.equalsIgnoreCase("post")) {
			String pwd = req.getParameter("pwd");
			String pwd2 = req.getParameter("pwd2");
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userid", userid);
			map.put("pwd", pwd);
			map.put("pwd2", pwd2);
			
			int n = service.updatePwd(map);
			
			req.setAttribute("n", n);
			req.setAttribute("pwd", pwd);
			req.setAttribute("pwd2", pwd2);
		}
		return "psw/login/pwdConfirm.not";
	}
	
	
	@RequestMapping(value="/member_register.mr", method={RequestMethod.GET})
	public String register() {  // 회원등록 폼 페이지 띄우기.
		
		return "psw/login/register.not";
	}
	
	@RequestMapping(value="/member_idDuplicateCheck.mr")
	public String idDuplicateCheck(HttpServletRequest req) {
		String method = req.getMethod();
		String userid = req.getParameter("userid");
		
		req.setAttribute("method", method);
		
		if(userid != null) {
			req.setAttribute("userid", userid);
			
			boolean isUseuserid = service.idDuplicateCheck(userid);
			
			req.setAttribute("isUseuserid", isUseuserid);
		}
		return "psw/login/idDuplicateCheck.not";
	}
	
	
	
	@RequestMapping(value="/member_registerEnd.mr")
	public String registerEnd(HttpServletRequest req, MemberVO mvo, MemberDetailVO mdvo) throws Throwable {
		String name = req.getParameter("name");
		String userid = req.getParameter("userid");
		String pwd = req.getParameter("pwd");
		
		String birth1 = req.getParameter("birth1");
		String birth2 = req.getParameter("birth2");
		String birth3 = req.getParameter("birth3");
		String email = req.getParameter("email");
		String hp1 = req.getParameter("hp1");
		String hp2 = req.getParameter("hp2");
		String hp3 = req.getParameter("hp3");
		String post1 = req.getParameter("post1");
		String post2 = req.getParameter("post2");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2"); 
		
		mvo.setName(name);
		mvo.setUserid(userid);
		mvo.setPwd(pwd);
		
		mdvo.setBirth1(birth1);
		mdvo.setBirth2(birth2);
		mdvo.setBirth3(birth3);
		mdvo.setEmail(email);
		mdvo.setHp1(hp1);
		mdvo.setHp2(hp2);
		mdvo.setHp3(hp3);
		mdvo.setPost1(post1);
		mdvo.setPost2(post2);
		mdvo.setAddr1(addr1);
		mdvo.setAddr2(addr2);
				
		int n = service.registerMember(mvo, mdvo); 

		if(n == 2) {
			String msg = "Miracle World 의 가족이 되신걸 환영합니다.";
			String loc = "member_login.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
		}

		return "psw/msg.not";
	}  // end of public String registerEnd(HttpServletRequest req, MemberVO mvo, MemberDetailVO mdvo) --------------
	
	
	@ExceptionHandler(java.sql.SQLIntegrityConstraintViolationException.class)
	public String SQLIntegrityConstraintViolationException(HttpServletRequest req) {
		String msg = "아이디 제약조건 위반입니다.";
		
		String ctxpath = req.getContextPath();
		String loc = ctxpath + "/member_registerEnd.mr";
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		return "psw/msg.not";
	}
	
	/*
	@RequestMapping(value="/member_edit.mr")
	public String editMyInfo(HttpServletRequest req, HttpSession session, MemberVO mvo, MemberDetailVO mdvo) {
		session = req.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if(loginUser.getUserid() != null) {
			String str_idx = req.getParameter("idx");
			
			mvo = null;
			mdvo = null;
			
			int idx = 0;
			
			try{
			    idx = Integer.parseInt(str_idx);
			    	
			   	if(idx < 1) {    	
			   		String msg = "비정상적인 경로로 들어왔습니다.";
				    String loc = "javascript:history.back()";
				    
				    req.setAttribute("msg", msg);
				    req.setAttribute("loc", loc);
				    
		    	} else {
			    	    mvo = service.findMemberByIdx(idx); 
			    	    mdvo = service.findMemberByIdx2(idx); 
			            
						req.setAttribute("mvo", mvo);
						}
			   	
			    } catch(NumberFormatException e) {
			   	
			    	String msg = "비정상적인 경로로 들어왔습니다.";
				    String loc = "javascript:history.back()";
				    
				    req.setAttribute("msg", msg);
				    req.setAttribute("loc", loc);
			    }
		}
		
		return "psw/login/editMyInfo.all";
	}
	*/
	
	
	
	
	
}







