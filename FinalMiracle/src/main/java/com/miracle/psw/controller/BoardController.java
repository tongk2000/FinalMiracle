package com.miracle.psw.controller;

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

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.model.FreeBoardVO;
import com.miracle.psw.model.MemberVO;
import com.miracle.psw.service.InterBoardService;
import com.miracle.psw.util.MyUtil;

@Controller
@Component
public class BoardController {

	@Autowired
	private InterBoardService service;
	
	
	// =================================================================== *** FAQ 게시판 목록 *** =====================
	@RequestMapping(value="/faqList.mr", method={RequestMethod.GET})
	public String faqList(HttpServletRequest req, HttpSession session) {
		List<FaqBoardVO> faqList = null;  
		
		String gobackURL = MyUtil.getCurrentURL(req);
		req.setAttribute("gobackURL", gobackURL);
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		String category = req.getParameter("category");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		map.put("category", category);
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		
		int totalCount = 0;
		int sizePerPage = 7;
		int	currentShowPageNo = 0;
		int totalPage = 0;
		
		int startRno = 0;
		int endRno = 0;
		
		int blockSize = 10;
		
		if (str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		} else {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		}
		startRno = ((currentShowPageNo - 1)*sizePerPage)+1;
		endRno = startRno + sizePerPage - 1;
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null && category != null) &&
			(!colname.trim().isEmpty() && !search.trim().isEmpty()) &&
			(!colname.equals("null") && !search.equals("null")) &&
			(!category.equals("null") && !category.trim().isEmpty())) {  // 검색어가 있는 경우
			faqList = service.faqListWithSearch(map);
		} else {  // 검색어가 없는경우
			faqList = service.faqListWithNoSearch(map);
		}
		// ================================================ *** 페이지바 만들기 *** ====================
		if( (colname != null && search != null && category != null) &&
			(!colname.trim().isEmpty() && !search.trim().isEmpty()) &&
			(!colname.equals("null") && !search.equals("null")) &&
			(!category.equals("null") && !category.trim().isEmpty())) {  // 검색어가 있는 경우
			totalCount = service.getTotalCountWithSearch(map);
		} else {  // 검색어가 없는경우
			totalCount = service.getTotalCountWithNoSearch(map);
		}
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "";
		
		if( (colname != null && search != null && category != null) &&
			(!colname.trim().isEmpty() && !search.trim().isEmpty()) &&
			(!colname.equals("null") && !search.equals("null")) &&
			(!category.equals("null") && !category.trim().isEmpty())) {
			// ================================================ *** 검색이 있을 경우 *** ====================================
			pagebar = "<ul>";
			pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, category, "faqList.mr");
			pagebar += "</ul>";
		} else {
			// ================================================= *** 검색이 없을 경우 *** =================================
			pagebar = "<ul>";
			pagebar += MyUtil.getPageBar(sizePerPage, blockSize, totalPage, currentShowPageNo, "faqList.mr");
			pagebar += "</ul>";
		}
		req.setAttribute("pagebar", pagebar);
		
		req.setAttribute("faqList", faqList);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		
		return "psw/board/faqList.all";
	}  // end of public String faqList(HttpServletRequest req, HttpSession session) --------------------------------
	
	// =================================================== *** FAQ 게시판 글쓰기 *** =========================================
	@RequestMapping(value="/faqAdd.mr", method={RequestMethod.GET})
	public String faqAdd(HttpServletRequest req, HttpServletResponse response) {
		
		return "psw/board/faqAdd.all";
	}
	@RequestMapping(value="/faqAddEnd.mr", method={RequestMethod.POST})
	public String faqAddEnd(FaqBoardVO faqvo, HttpServletRequest req) {
		int n = service.add(faqvo);
		req.setAttribute("n", n);
		
		return "psw/board/faqAddEnd.not";
	}
	
	
	/////////////////////////////////////////////////////////// 자유게시판  /////////////////////////////////////////////////////
	// ==================================================== *** 자유게시판 목록 보여주기 *** ========================================
	@RequestMapping(value="/freeList.mr", method={RequestMethod.GET})
	public String freeList(HttpServletRequest req, HttpSession session) {
		List<FreeBoardVO> freeList = service.freeList();
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo =  (HashMap<String, String>)session.getAttribute("teamInfo");
		
		String gobackURL = MyUtil.getCurrentURL(req);
		req.setAttribute("gobackURL", gobackURL);
		
		String fk_team_idx = teamInfo.get("team_idx");
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");
		
		System.out.println(fk_teamwon_idx);

		String colname = req.getParameter("colname");
		String search = req.getParameter("search");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		
		map.put("fk_team_idx", fk_team_idx);
		map.put("fk_teamwon_idx", fk_teamwon_idx);
		
		System.out.println(fk_teamwon_idx);
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		
		int totalCount = 0;
		int sizePerPage = 10;
		int	currentShowPageNo = 0;
		int totalPage = 0;
		
		int startRno = 0;
		int endRno = 0;
		
		int blockSize = 10;
		
		if (str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		} else {
			currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
		}
		startRno = ((currentShowPageNo - 1)*sizePerPage)+1;
		endRno = startRno + sizePerPage - 1;
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) &&
			(!colname.trim().isEmpty() && !search.trim().isEmpty()) &&
			(!colname.equals("null") && !search.equals("null")) ) {  // 검색어가 있는 경우
			freeList = service.freeListWithSearch(map);
		} else {  // 검색어가 없는경우
			freeList = service.freeListWithNoSearch(map);
		}
		// ================================================ *** 페이지바 만들기 *** ====================
		if( (colname != null && search != null) &&
			(!colname.trim().isEmpty() && !search.trim().isEmpty()) &&
			(!colname.equals("null") && !search.equals("null")) ) {  // 검색어가 있는 경우
			totalCount = service.getFreeTotalCountWithSearch(map);
		} else {  // 검색어가 없는경우
			totalCount = service.getFreeTotalCountWithNoSearch(map);
		}
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "freeList.mr");
		pagebar += "</ul>";
		
		session.setAttribute("readCntPermission", "yes");  // f5 눌러도 조회수 안올리기 하기 위한 것.(session 에 키값 지정)
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("freeList", freeList);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		
		return "psw/board/freeList.all";
	}

	
	
	// ===================================================== *** 자유게시판 글 1개 보여주기 *** =====================================
	@RequestMapping(value="/freeView.mr", method={RequestMethod.GET})
	public String freeView(HttpServletRequest req, HttpSession session, FreeBoardVO freevo){
		String idx = req.getParameter("idx");
		String gobackURL = req.getParameter("gobackURL");
		
		freevo = null;
		
		// ================================== *** F5 클릭시 글 조회수 증가 안하게 하기 위해 조건문 걸기 *** ==========================================
		if(session.getAttribute("readCntPermission") != null && "yes".equals(session.getAttribute("readCntPermission")) ) {
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
			String userid = null;
			
			if(loginUser != null) {
				userid = loginUser.getUserid();
			}
			freevo = service.getView(idx, userid);
			session.removeAttribute("readCntPermission"); // 글목록 본 후에 세션값 삭제.
		} else {
			freevo = service.getViewWithNoReadCnt(idx);
		}	
		req.setAttribute("freevo", freevo);
		req.setAttribute("gobackURL", gobackURL);
		
		return "psw/board/freeView.all";
	}
	
	// ===================================================== *** 자유게시판 글 쓰기 *** ============================================
	@RequestMapping(value="/freeAdd.mr", method={RequestMethod.GET})
	public String freeAdd() {  // 글쓰기 폼페이지 띄우기
		
		return "psw/board/freeAdd.all";
	}
	@RequestMapping(value="/freeAddEnd.mr", method={RequestMethod.POST})
	public String freeAddEnd(FreeBoardVO freevo, HttpServletRequest req) {
		int n = service.freeAdd(freevo);
		req.setAttribute("n", n);
		
		return "psw/board/freeAddEnd.not";
	}
	
	
	
	
}








