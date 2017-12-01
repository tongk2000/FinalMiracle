package com.miracle.pjs.controller;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.miracle.pjs.model.MapVO;
import com.miracle.pjs.service.PjsinterService;
import com.miracle.pjs.util.MyUtil;


@Controller
public class GeniousPjs {
	
	@Autowired
	private PjsinterService service;

/*=======================================================================================================================================================*/	
	
	// ==== *** 공지사항 게시판 *** ==== //
	@RequestMapping(value="noticeList.mr", method={RequestMethod.GET}) // 공지사항 게시판 리스트
	public String notice(HttpServletRequest req) {	
		/* ============================== 페이징 처리 시 필요한 변수들! ============================== */
		int sizePerPage = 0;
		int currentPage = 0;
		String str_sizePerPage = req.getParameter("sizePerPage");
		if(str_sizePerPage==null || "".equals(str_sizePerPage)) {
			sizePerPage = 5;
		}
		else {
			if(!"10".equals(sizePerPage) && !"5".equals(sizePerPage) && !"3".equals(sizePerPage)){
				sizePerPage = 5;
			}
			else {
				try{
					sizePerPage = Integer.parseInt(str_sizePerPage);
				} catch (NumberFormatException e) {
					String msg="숫자값만 입력하세요!";
					req.setAttribute("msg",msg);
					sizePerPage = 5;
				}
			}
		}
		String str_currentPage = req.getParameter("currentShowPageNo");
		if(str_currentPage==null || "".equals(str_currentPage)) {
			currentPage = 1;
		}
		else {
			currentPage = Integer.parseInt(str_currentPage);	
		}
		int blockSize=3;
		String sNum = String.valueOf( ((currentPage - 1)*sizePerPage)+1 );
		String eNum = String.valueOf( Integer.parseInt(sNum) + sizePerPage - 1 );
		/* =================================== 페이징 처리 끝! =================================== */
		String searchType = req.getParameter("searchType");
		String searchString = req.getParameter("searchString");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchType", searchType);
		map.put("searchString", searchString);
		map.put("sNum", sNum);
		map.put("eNum", eNum);
		
		int totalCount = service.getNoticeCount(map);
		System.out.println("=================================totalCount는 ======================"+totalCount);
		int totalPage=(int)Math.ceil((double)totalCount / sizePerPage);
		System.out.println("===========================총 페이지 =================:"+totalPage);
		String pagebar = MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentPage, searchType, searchString, null, "noticeList.mr");
		List<HashMap<String, String>> list = service.getNoticeList(map);
		req.setAttribute("list", list);
		req.setAttribute("searchType", searchType);
		req.setAttribute("searchString", searchString);
		req.setAttribute("pagebar", pagebar);
		return "pjs/notice/noticeList.all";
	}
	@RequestMapping(value="noticeListJSON.mr", method={RequestMethod.GET})	// 공지사항 게시판 리스트의 검색작업
	public String noticeJSON(HttpServletRequest req) {	
		String searchString = req.getParameter("searchString");
		String searchType = req.getParameter("searchType");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchString", searchString);
		map.put("searchType", searchType);
		String list = service.getNoticeJSONList(map);
		req.setAttribute("list", list);
		return "pjs/notice/noticeListJSON.not";
	}
	@RequestMapping(value="noticeUserInfo.mr", method={RequestMethod.GET})	// 공지사항 게시판글의 유저정보보기
	public String noticeUserInfo(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String id = req.getParameter("userid"); // 해당 번호의 글내용을 가져온다.
		System.out.println("================================id========================"+id);
		HashMap<String, String> map = service.getViewContent(id);
		String userid = map.get("userid"); String name = map.get("name"); String img = map.get("img"); 
		String age = map.get("age"); String hp = map.get("hp"); String addr = map.get("addr"); 
		req.setAttribute("userid", userid); req.setAttribute("name", name); req.setAttribute("img", img); 
		req.setAttribute("age", age); req.setAttribute("hp", hp); req.setAttribute("addr", addr); 
		return "pjs/notice/noticeView.not";
	}
	@RequestMapping(value="noticeWrite.mr", method={RequestMethod.GET})	// 공지사항 게시판글 쓰기 
	public String noticeWrite(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return ".all";
	}
	@RequestMapping(value="noticeDel.mr", method={RequestMethod.GET})	// 공지사항 게시판글 삭제
	public String noticeDel(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return ".all";
	}
	@RequestMapping(value="noticeEdit.mr", method={RequestMethod.GET})	// 공지사항 게시판글 수정
	public String noticeEdit(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return ".all";
	}
	@RequestMapping(value="noticeView.mr", method={RequestMethod.POST})	// 공지사항 게시판글 보기 
	public String noticeView(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		return ".all";
	}
	
/*=======================================================================================================================================================*/	
	
	// ==== *** 마음의 소리 게시판 *** ==== //
	@RequestMapping(value="mindList.mr", method={RequestMethod.GET})
	public String mindList(HttpServletRequest req) {
		String searchType = req.getParameter("searchType");
		String searchString = req.getParameter("searchString");
		String str_sizePerPage = req.getParameter("sizePerPage");
		String str_currentPage = req.getParameter("currentShowPageNo");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchType", searchType);
		map.put("searchString", searchString);
		List<HashMap<String, String>> list = service.getMindList(map, str_sizePerPage, str_currentPage); // 게시판을 가져오는 서비스단
		String pagebar = list.get(list.size()-1).get("pagebar");
		list.remove(list.size()-1);
		req.setAttribute("sizePerPage", str_sizePerPage);
		req.setAttribute("searchType", searchType);
		req.setAttribute("searchString", searchString);
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("list", list);
		return "pjs/mind/mindList.all";
	}
	@RequestMapping(value="mindListJSON.mr", method={RequestMethod.GET})
	public String mindJSON(HttpServletRequest req) {	
		String searchString = req.getParameter("searchString");
		String searchType = req.getParameter("searchType");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchString", searchString);
		map.put("searchType", searchType);
		String list = service.getMindJSONList(map);
		req.setAttribute("list", list);
		return "pjs/mind/mindListJSON.not";
	}
	@RequestMapping(value="mindView.mr", method={RequestMethod.GET})
	public String mindView(HttpServletRequest req) {
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return "noticeView.all";
	}
	@RequestMapping(value="mindWrite.mr", method={RequestMethod.GET})	// 공지사항 게시판글 쓰기 
	public String mindWrite(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return "noticeView.all";
	}
	@RequestMapping(value="mindDel.mr", method={RequestMethod.GET})	// 공지사항 게시판글 삭제
	public String mindDel(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return "noticeView.all";
	}
	@RequestMapping(value="mindEdit.mr", method={RequestMethod.GET})	// 공지사항 게시판글 수정
	public String mindEdit(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return "noticeView.all";
	}
	@RequestMapping(value="mindUserInfo.mr", method={RequestMethod.GET})	// 공지사항 게시판글의 유저정보보기
	public String mindUserInfo(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return "noticeView.all";
	}
	
/*=======================================================================================================================================================*/	

	// ==== *** 구글맵 *** ==== //
	@RequestMapping(value="googleMap.mr", method={RequestMethod.GET})
	public String googleMap(HttpServletRequest req) {
		List<MapVO> list = service.getMap(); // 전체 리스트를 반환한다.
		req.setAttribute("list", list);
		return "pjs/map/googleMap.all";
	}
	
/*=======================================================================================================================================================*/	
	
	// ==== *** 쪽지 *** ==== //
	@RequestMapping(value="memo.mr", method={RequestMethod.GET})
	public String memo(HttpServletRequest req) {
		return "pjs/memo/?.all";
	}

/*=======================================================================================================================================================*/	

}		
