package com.miracle.ksh.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.ksh.model.TeamVO;
import com.miracle.ksh.service.InterTMService;
import com.miracle.ksh.util.MyUtil;
import com.miracle.psw.model.MemberVO;

@Controller
public class TMController {
	
	HashMap<String, String> map = new HashMap<String, String>();
	
	@Autowired
	private InterTMService service;
	
	@RequestMapping(value="/tmList.mr", method={RequestMethod.GET})
	public String tmList(HttpServletRequest req){
		
		List<HashMap<String, String>> tmList = null;
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		String gobackURL = MyUtil.getCurrentURL(req);
		
		HashMap<String, String> tmMap = new HashMap<String, String>();
		tmMap.put("colname", colname);
		tmMap.put("search", search);
		
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
}
