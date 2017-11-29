package com.miracle.pjs.controller;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.miracle.pjs.service.PjsinterService;
import com.miracle.pjs.util.MyUtil;

@Controller
public class GeniousPjs {
	@Autowired
	private PjsinterService service;
	
	@RequestMapping(value="noticeList.mr", method={RequestMethod.GET})
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
		
		int totalCount = service.getTotalCount(map);
		int totalPage=(int)Math.ceil((double)totalCount/sizePerPage);
		String pagebar = MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentPage, searchType, searchString, null, "noticeList.mr");
		List<HashMap<String, String>> list = service.getNoticeList(map);
		req.setAttribute("list", list);
		req.setAttribute("searchType", searchType);
		req.setAttribute("searchString", searchString);
		req.setAttribute("pagebar", pagebar);
		return "pjs/notice/noticeList.all";
	}/*=======================================================================================================================================================*/

}		
