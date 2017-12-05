package com.miracle.ksh.controller;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.miracle.ksh.model.VoteCommVO;
import com.miracle.ksh.model.VoteItemVO;
import com.miracle.ksh.model.VoteVO;
import com.miracle.ksh.service.InterVoteService;
import com.miracle.ksh.util.KshFileManager;
import com.miracle.ksh.util.MyUtil;
import com.miracle.ksh.util.ThumbnailManager;
import com.miracle.psw.model.MemberDetailVO;
import com.miracle.psw.model.MemberVO;

@Controller
public class VoteController {
	
	@Autowired
	private InterVoteService service;
	
	@Autowired
	private KshFileManager fileManager;
	
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	@RequestMapping(value="/voteList.mr", method={RequestMethod.GET})
	public String voteList(HttpServletRequest req, HttpSession session){
		
		List<HashMap<String, String>> voteList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req);//돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		
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
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			voteList = service.VoteListYesPaging2(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		} else{
			//검색어가 없는 경우
			voteList = service.VoteListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.VoteTotalCount2(map);
		} else{
			//검색어가 없는 경우
			totalCount = service.VoteTotalCount1();
		}
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "voteList.mr");	
		
		pagebar += "</ul>";
		
		
		req.setAttribute("gobackURL", gobackURL);
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalCount", totalCount);
		
		req.setAttribute("voteList", voteList);
		req.setAttribute("voteItemList", voteItemList);
		req.setAttribute("voteCommList", voteCommList);
		
		return "ksh/vote/votelist.all";
	}
	
	@RequestMapping(value="/voteEndList.mr", method={RequestMethod.GET})
	public String voteEndList(HttpServletRequest req){
		
		List<HashMap<String, String>> voteEndList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req);//돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자
		
		req.setAttribute("gobackURL", gobackURL);
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		
		//System.out.println(colname + " / " + search);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		
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
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			voteEndList = service.VoteEndListYesPaging2(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		} else{
			//검색어가 없는 경우
			voteEndList = service.VoteEndListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.VoteEndTotalCount2(map);
		} else{
			//검색어가 없는 경우
			totalCount = service.VoteEndTotalCount1();
		}
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "voteEndList.mr");	
		
		pagebar += "</ul>";
		
		
		req.setAttribute("gobackURL", gobackURL);
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);	
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalCount", totalCount);
		
		req.setAttribute("voteEndList", voteEndList);
		req.setAttribute("voteItemList", voteItemList);
		req.setAttribute("voteCommList", voteCommList);
		
		return "ksh/vote/voteEndlist.all";
	}
	
	
	@RequestMapping(value="/voteMyList.mr", method={RequestMethod.GET})
	public String voteMyList(HttpServletRequest req, HttpSession session){
		
		List<HashMap<String, String>> voteMyList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req);//돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자
		
		req.setAttribute("gobackURL", gobackURL);
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		String votekind = req.getParameter("votekind");
		//String fk_teamwon_idx = session.getAttribute("fk_teamwon_idx");
		
		if(votekind == null || votekind.trim().isEmpty() || votekind.equals("null")){
			votekind = "ing";
		}
		
		//System.out.println(votekind);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		map.put("votekind", votekind);
		
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
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			voteMyList = service.VoteMyListYesPaging2(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		} else{
			//검색어가 없는 경우
			voteMyList = service.VoteMyListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.VoteMyTotalCount2(map);
		} else{
			//검색어가 없는 경우
			totalCount = service.VoteMyTotalCount1(map);
		}
		
		//System.out.println(totalCount);
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, votekind, "voteMyList.mr");	
		
		pagebar += "</ul>";
		
		req.setAttribute("gobackURL", gobackURL);
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalCount", totalCount);
		
		req.setAttribute("voteMyList", voteMyList);
		req.setAttribute("voteItemList", voteItemList);
		req.setAttribute("votekind", votekind);
		req.setAttribute("voteCommList", voteCommList);
		
		return "ksh/vote/voteMylist.all";
	}
	
	
	@RequestMapping(value="/voteAdd.mr", method={RequestMethod.GET})
	public String voteAdd(HttpServletRequest req){
		
		return "ksh/vote/voteAdd.all";
	}
	
	
	@RequestMapping(value="/voteAddEnd.mr", method={RequestMethod.POST})
	public String voteAddEnd(MultipartHttpServletRequest req){
		
		HttpSession session = req.getSession();
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		//System.out.println(loginUser.getIdx());
		
		String idx = String.valueOf(loginUser.getIdx());
		
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		String startdate = req.getParameter("datepicker1");
		String enddate = req.getParameter("datepicker2");
		
		//System.out.println(subject);
		
		String[] items = req.getParameterValues("items");
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		Date startday = null;
		Date endday = null;
		
		try {
			startday = format.parse(startdate);
			endday = format.parse(enddate);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		int compare = startday.compareTo(endday);
		
		
		boolean itemFlag = false;
		int itemValues = 0;
		
		for (String str : items) {
			if (str == null || str.length() == 0) {
				break;
			} else {
				itemValues++;
			}
			
			if(items.length == itemValues) {
			    itemFlag = true;
		    }
        }
			
		if(compare > 0){
			String msg = "종료일이 시작일보다 날짜가 앞섭니다.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else if(itemFlag == false){
			
			String msg = "문항은 두 문항 이상 입력해야 합니다.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
			
		} else {
		
			HashMap<String, String> mapVote = new HashMap<String, String>();
			mapVote.put("subject", subject);
			mapVote.put("content", content);
			mapVote.put("startdate", startdate);
			mapVote.put("enddate", enddate);
			mapVote.put("idx", idx);
			
			//System.out.println(subject + "/" + content + "/" + enddate);
			
			int x = service.VoteAdd(mapVote);
			
			
			int lastidx = service.VoteLastIdx(); //막 추가된 투표글의 idx를 알아보자
			
			
			HashMap<String, Object> mapVoteItem = new HashMap<String, Object>();
			mapVoteItem.put("lastidx", lastidx);

			int n = 0;
		    int m = 0;
		    int count = 0;
	    	
	    	for(int i=0; i<items.length; i++){
	    		mapVoteItem.put("items", items[i]);
	    		m = service.VoteItemAdd(mapVoteItem);
	    		
	    		if(m==1) count++;
	    	}
	    	
	    	if(items.length == count) {
			    n=1;
		    }
		    else {
		 	   n=0;
		    }
		    
		    
		    req.setAttribute("x", x);
			req.setAttribute("n", n);
			req.setAttribute("m", m);
			
			return "ksh/vote/voteAddEnd.all";
		
		}
	}
	
	
	@RequestMapping(value="/voteChoice.mr", method={RequestMethod.GET})
	public String voteChoice(HttpServletRequest req){
		
		String vote_idx = req.getParameter("vote_idx");
		String voteitem_idx = req.getParameter("voteitem_idx");
		String teamwon_idx = req.getParameter("teamwon_idx");
		//String ip = req.getRemoteAddr();
		String gobackURL = req.getParameter("gobackURL");
		
		//System.out.println("확인 : " + ip);

		HashMap<String, String> mapVotedChk = new HashMap<String, String>();
		mapVotedChk.put("vote_idx", vote_idx);
		mapVotedChk.put("teamwon_idx", teamwon_idx);
		
		String cnt = service.VotedCheck(mapVotedChk); //중복투표를 검사해보자
		
		//System.out.println(vote_idx + " / " + voteitem_idx + " / " + teamwon_idx);
		System.out.println(cnt);
		
		if(cnt != null && !cnt.trim().isEmpty() && !cnt.equals("null")){
			String msg = "이미 해당 투표에 참여하셨습니다.";
			//String loc = "voteList.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", gobackURL);
			
			
			return "ksh/msg.not";
		} else {
			
			HashMap<String, String> mapVoted = new HashMap<String, String>();
			mapVoted.put("vote_idx", vote_idx);
			mapVoted.put("voteitem_idx", voteitem_idx);
			mapVoted.put("teamwon_idx", teamwon_idx);
			
			int n = service.VotedAdd(mapVoted);
			
			int m = service.VoteNumUpdate(voteitem_idx);
			
			if(n>0 && m>0){
				String msg = "투표가 완료되었습니다.";
				//String loc = "voteList.mr";
				
				req.setAttribute("msg", msg);
				req.setAttribute("loc", gobackURL);
				
				
				return "ksh/msg.not";
				
			} else {
				String msg = "투표하는 과정에서 에러가 발생했습니다.";
				//String loc = "voteList.mr";
				
				req.setAttribute("msg", msg);
				req.setAttribute("loc", gobackURL);
				
				return "ksh/msg.not";
			}
		}

	}
	
	
	@RequestMapping(value="/voteDel.mr", method={RequestMethod.GET})
	public String voteDel(HttpServletRequest req){
		
		String idx = req.getParameter("idx");
		String gobackURL = req.getParameter("gobackURL");
		
		//System.out.println(gobackURL);
		
		/*
		if(!loginuser.getIdx().equals(MemberVO.getIdx())){
			String msg = "다른 사용자의 투표글은 삭제가 불가합니다.";
			//String loc = "javascript:history.back()";
			
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", gobackURL);
			
			return "ksh/msg.not";
		}
		*/
		int result = service.VoteDel(idx);
		
		//req.setAttribute("result", result);
		
		if(result > 0){
			String msg = "삭제가 정상적으로 완료되었습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "삭제가 정상적으로 처리되지 못하였습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}

	}
	
	
	@RequestMapping(value="/voteEdit.mr", method={RequestMethod.GET})
	public String voteEdit(HttpServletRequest req){
		
		String idx = req.getParameter("idx");
		//System.out.println(idx);
		
		VoteVO votevo = service.VoteView(idx);
		List<VoteItemVO> voteitemvo = service.VoteItemView(idx);
		int cnt = service.VoteItemViewCnt(idx);
		
		/*
		if(!loginuser.getIdx().equals(MemberVO.getIdx())){
			String msg = "다른 사용자의 투표글은 삭제가 불가합니다.";
			//String loc = "javascript:history.back()";
			
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", gobackURL);
			
			return "ksh/msg.not";
		}
		*/
		
		req.setAttribute("idx", idx);
		req.setAttribute("votevo", votevo);
		req.setAttribute("voteitemvo", voteitemvo);
		req.setAttribute("cnt", cnt);
		
		return "ksh/vote/voteEdit.all";
	}
	
	@RequestMapping(value="/voteEditEnd.mr", method={RequestMethod.POST})
	public String voteEditEnd(MultipartHttpServletRequest req) throws Throwable{
		
		String idx = req.getParameter("idx");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		String startdate = req.getParameter("datepicker1");
		String enddate = req.getParameter("datepicker2");
		
		//System.out.println(itemvo.getIdx());
		//System.out.println(idx);
		
		String none = "none";
				
		String[] items = req.getParameterValues("items");
		String[] itemidx = req.getParameterValues("itemidx");

		
		/*for(int i=0; i<items.length; i++){
			System.out.print(items[i] + "." + i + " ");
		}
		for(int i=0; i<itemidx.length; i++){
			System.out.print(itemidx[i] + "." + i + " ");
		}*/
		
		//System.out.println(items.length + " vs " + itemidx.length);
		
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
		Date startday = null;
		Date endday = null;
		
		try {
			startday = format.parse(startdate);
			endday = format.parse(enddate);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		int compare = startday.compareTo(endday);
		
		
		boolean itemFlag = false;
		int itemValues = 0;

        for (int i = 0; i < items.length; i++) {
        	
        	//System.out.println("내용 : " + items[i]);
        	//System.out.println("길이 : " + items.length);
        	
			if (items[i] == null || items[i].length() == 0) {
				break;
			} else {
				itemValues = items.length;
			}
			
			if(items.length == itemValues) {
			    itemFlag = true;
		    }
        }

		if(compare > 0){
			String msg = "종료일이 시작일보다 날짜가 앞섭니다.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else if(itemFlag == false){
			
			String msg = "문항은 두 문항 이상 입력해야 합니다.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
			
		} else {
		
			HashMap<String, String> mapVote = new HashMap<String, String>();
			mapVote.put("idx", idx);
			mapVote.put("subject", subject);
			mapVote.put("content", content);
			mapVote.put("startdate", startdate);
			mapVote.put("enddate", enddate);
			
			//System.out.println(subject + "/" + content + "/" + enddate);
			
			int x = service.VoteEdit(mapVote);
			
			HashMap<String, Object> mapVoteItem = new HashMap<String, Object>();
			mapVoteItem.put("idx", idx);
			mapVoteItem.put("none", none);
			
			int n = service.VoteItemEdit(mapVoteItem, items, itemidx);
		    
		    
		    req.setAttribute("x", x);
			req.setAttribute("n", n);
			
			return "ksh/vote/voteEditEnd.all";
		
		}

	}
	
	@RequestMapping(value="/voteReadyList.mr", method={RequestMethod.GET})
	public String voteReadyList(HttpServletRequest req){
		
		List<HashMap<String, String>> voteReadyList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req);//돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자
		
		req.setAttribute("gobackURL", gobackURL);
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		
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
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			voteReadyList = service.VoteReadyListYesPaging2(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		} else{
			//검색어가 없는 경우
			voteReadyList = service.VoteReadyListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList();
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.VoteReadyTotalCount2(map);
		} else{
			//검색어가 없는 경우
			totalCount = service.VoteReadyTotalCount1();
		}
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "voteReadyList.mr");	
		
		pagebar += "</ul>";
		
		req.setAttribute("gobackURL", gobackURL);
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalCount", totalCount);
		
		req.setAttribute("voteReadyList", voteReadyList);
		req.setAttribute("voteItemList", voteItemList);
		req.setAttribute("voteCommList", voteCommList);
		
		return "ksh/vote/voteReadyList.all";
	}
	
	
	@RequestMapping(value="/voteCallChart.mr", method={RequestMethod.GET})
	public String voteCallChart(HttpServletRequest req){
		
		String idx = req.getParameter("idx");
		
		JSONArray jsonMap = new JSONArray();
		
		if(!idx.trim().isEmpty()){
			List<VoteItemVO> list = service.VoteItemChart(idx);
			
			if(list != null){
				for(VoteItemVO vo : list){
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("no", vo.getIdx());
					jsonObj.put("name", vo.getFk_vote_idx());
					jsonObj.put("email", vo.getItem());
					jsonObj.put("addr", vo.getVotenum());
					
					jsonMap.put(jsonObj);
				}
			}
		}

		String str_jsonMap = jsonMap.toString();

		req.setAttribute("str_jsonMap", str_jsonMap);
		
		return "ksh/json/Chart.not";
	}
	
	
	@RequestMapping(value="/voteCommAdd.mr", method={RequestMethod.GET})
	public String voteCommAdd(HttpServletRequest req, HttpServletResponse response){
		
		HttpSession session = req.getSession();
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String gobackURL = req.getParameter("gobackURL");
		String comment = req.getParameter("comment");
		String voteidx = req.getParameter("voteidx");
		String getidx = String.valueOf(loginUser.getIdx());
		
		//System.out.println(comment + " / " + voteidx + " / " + getidx);
		System.out.println(gobackURL);

		int fk_teamwon_idx = service.getFk_teamwon_idx(getidx);
		
		String str_idx = String.valueOf(fk_teamwon_idx);
		
		HashMap<String, String> commMap = new HashMap<String, String>();
		commMap.put("comment", comment);
		commMap.put("voteidx", voteidx);
		commMap.put("fk_teamwon_idx", str_idx);
		
		
		int result = service.addComment(commMap);
		
		if(result > 0){
			//댓글쓰기와 원 게시물(tblBoard 테이블)에 댓글의 갯수(1씩 증가)의 증가가 성공한다면
			req.setAttribute("msg", "댓글 작성완료");
			req.setAttribute("loc", gobackURL);
			
		} else {
			//댓글쓰기가 실패 or 댓글의 갯수(1씩 증가)의 증가가 실패한다면
			req.setAttribute("msg", "댓글 작성실패");
			req.setAttribute("loc", gobackURL);
		}
		
		return "ksh/msg.not";
	}
	
	
	@RequestMapping(value="/voteCommDel.mr", method={RequestMethod.GET})
	public String voteCommDel(HttpServletRequest req){
		
		HttpSession session = req.getSession();
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String gobackURL = req.getParameter("gobackURL");
		String delidx = req.getParameter("delidx");
		String getidx = String.valueOf(loginUser.getIdx());
		
		//System.out.println(comment + " / " + voteidx + " / " + getidx);
		System.out.println("확인용 : " + delidx);
		//System.out.println(gobackURL);

		int fk_teamwon_idx = service.getFk_teamwon_idx(getidx);
		
		String str_idx = String.valueOf(fk_teamwon_idx);
		
		HashMap<String, String> commMap = new HashMap<String, String>();
		commMap.put("delidx", delidx);
		commMap.put("fk_teamwon_idx", str_idx);
		
		
		int result = service.DelComment(commMap);
		
		if(result > 0){
			//댓글쓰기와 원 게시물(tblBoard 테이블)에 댓글의 갯수(1씩 증가)의 증가가 성공한다면
			req.setAttribute("msg", "댓글 삭제완료");
			req.setAttribute("loc", gobackURL);
			
		} else {
			//댓글쓰기가 실패 or 댓글의 갯수(1씩 증가)의 증가가 실패한다면
			req.setAttribute("msg", "댓글 삭제실패");
			req.setAttribute("loc", gobackURL);
		}
		
		return "ksh/msg.not";
	}
	
	
}
