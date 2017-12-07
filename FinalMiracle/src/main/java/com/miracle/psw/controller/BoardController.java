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
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		
		System.out.println(search);
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		
		int totalCount = 0;
		int sizePerPage = 5;
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
		
		System.out.println(startRno+ "  dddd " + endRno);
		
		if( (colname != null && search != null) &&
			(!colname.trim().isEmpty() && !search.trim().isEmpty()) &&
			(!colname.equals("null") && !search.equals("null")) ) {  // 검색어가 있는 경우
			faqList = service.faqListWithSearch(map);
		} else {  // 검색어가 없는경우
			faqList = service.faqListWithNoSearch(map);
		}
		// ================================================ *** 페이지바 만들기 *** ====================
		if( (colname != null && search != null) &&
			(!colname.trim().isEmpty() && !search.trim().isEmpty()) &&
			(!colname.equals("null") && !search.equals("null")) ) {  // 검색어가 있는 경우
			totalCount = service.getTotalCountWithSearch(map);
		} else {  // 검색어가 없는경우
			totalCount = service.getTotalCountWithNoSearch();
		}
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "faqList.mr");
		pagebar += "</ul>";
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("faqList", faqList);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		
		return "psw/board/faqlist.all";
	}  // end of public String faqList(HttpServletRequest req, HttpSession session) --------------------------------
	
	
	
	
	
}








