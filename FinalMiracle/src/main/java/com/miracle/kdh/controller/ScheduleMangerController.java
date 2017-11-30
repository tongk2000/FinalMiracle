package com.miracle.kdh.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.kdh.model.FolderVO;
import com.miracle.kdh.service.ScheduleManagerService;

@Controller
public class ScheduleMangerController {
	@Autowired
	ScheduleManagerService svc;
	
	// 모든 폴더, 할일 리스트를 가져오는 메소드
	@RequestMapping(value="doList.mr", method={RequestMethod.GET})
	public String doList (HttpServletRequest req) {
		List<FolderVO> doList = svc.getAllDoList();
		req.setAttribute("doList", doList);
		return "kdh/doList.all";
	} // end of String doList (HttpServletRequest req) -----------------------------------
}
