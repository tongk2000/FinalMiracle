package com.miracle.psw.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.model.FreeBoardVO;
import com.miracle.psw.model.FreeCommentVO;
import com.miracle.psw.model.MemberDetailVO;
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
		
		String gobackURL = req.getParameter("gobackURL");
		req.setAttribute("gobackURL", gobackURL);
		
		String fk_team_idx = teamInfo.get("team_idx");
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");

		String colname = req.getParameter("colname");
		String search = req.getParameter("search");

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		
		map.put("fk_team_idx", fk_team_idx);
		map.put("fk_teamwon_idx", fk_teamwon_idx);
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		
		int totalCount = 0;
		int sizePerPage = 15;
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
	
	// ================================================== *** 자유게시판 목록에서 userid또는 성명 클릭시 유저정보 보여주기 *** ===============
	@RequestMapping(value="/freeUserInfo.mr", method={RequestMethod.GET})
	@ResponseBody
	public HashMap<String, Object> freeUserInfo(HttpServletRequest req, MemberVO mvo, MemberDetailVO mdvo){
		String userInfo = req.getParameter("userInfo");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userInfo", userInfo);
		
		mvo = service.showUserInfo(map);
		mdvo = service.showUserDetailInfo(map);
		
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map2.put("infoUserid", mvo.getUserid());
		map2.put("infoName", mvo.getName());
		map2.put("infoImg", mvo.getImg());
		
		map2.put("infoBirth1", mdvo.getBirth1());
		map2.put("infoBirth2", mdvo.getBirth2());
		map2.put("infoBirth3", mdvo.getBirth3());
		map2.put("infoAddr1", mdvo.getAddr1());
		map2.put("infoAddr2", mdvo.getAddr2());
		map2.put("infoEmail", mdvo.getEmail());
		map2.put("infoHp1", mdvo.getHp1());
		map2.put("infoHp2", mdvo.getHp2());
		map2.put("infoHp3", mdvo.getHp3());
		map2.put("infoProfile", mdvo.getProfile());
		
		return map2;
	}
	
	
	// ===================================================== *** 자유게시판 글 1개 보여주기 *** =====================================
	@RequestMapping(value="/freeView.mr", method={RequestMethod.GET})
	public String freeView(HttpServletRequest req, HttpSession session, FreeBoardVO freevo){
		String idx = req.getParameter("idx");
		String gobackURL = MyUtil.getCurrentURL(req);
		freevo = null;
		
		// ==================================== *** F5 클릭시 글 조회수 증가 안하게 하기 위해 조건문 걸기 *** ===========================
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
		
		// ==================================== *** 댓글 목록 보여주기 *** ======================
		List<FreeCommentVO> freeCommentList = service.freeListComment(idx);
		req.setAttribute("freeCommentList", freeCommentList);
		
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
	
	// ======================================================== *** 자유게시판 글 수정하기 *** ========================================
	@RequestMapping(value="/freeEdit.mr", method={RequestMethod.GET})
	public String freeEdit(HttpServletRequest req, HttpServletResponse response, HttpSession session) {
		String idx = req.getParameter("idx"); // 수정할 게시글 글번호 받아오기
		
		// 수정해야 할 글 전체내용 가져오기
		FreeBoardVO freevo = service.getViewWithNoReadCnt(idx);  // 글 조회수(readCnt) 증가없이 글 불러오기
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if(!loginUser.getUserid().equals(freevo.getUserid())) {
			String msg = "다른 회원님의 글은 수정이 불가능합니다.";
			String loc = "javascript:history.back();";
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			return "psw/msg.not";
		} else {
			req.setAttribute("freevo", freevo);
			return "psw/board/freeEdit.all";
		}
	}
	
	@RequestMapping(value="/freeEditEnd.mr", method={RequestMethod.POST})
	public String freeEditEnd(FreeBoardVO freevo, HttpServletRequest req) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", String.valueOf(freevo.getIdx()));
		map.put("subject", freevo.getSubject());
		map.put("content", freevo.getContent());
		
		int result = service.freeEdit(map);
		
		req.setAttribute("result", result);
		req.setAttribute("idx", freevo.getIdx());
		
		return "psw/board/freeEditEnd.not";
	}
	
	// ======================================================================= *** 자유게시판 댓글 쓰기 *** ==============================
	@RequestMapping(value="/freeComment.mr", method={RequestMethod.GET})
	public String freeComment(HttpServletRequest req, HttpServletResponse response, FreeCommentVO commentvo) throws Throwable {
		String gobackURL = MyUtil.getCurrentURL(req);
		
		int result = service.addComment(commentvo);
		
		if(result > 0) {
			req.setAttribute("msg", "댓글 쓰기 성공");
		} else {
			req.setAttribute("msg", "댓글 쓰기가 실패");
		}
		String idx = String.valueOf(commentvo.getParentIdx());
		req.setAttribute("idx", idx);
		req.setAttribute("gobackURL", gobackURL);
		
		return "psw/board/freeComment.not";
	}
	
	
	
	
}








