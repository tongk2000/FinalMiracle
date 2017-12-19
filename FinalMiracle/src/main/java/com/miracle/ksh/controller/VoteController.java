package com.miracle.ksh.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.miracle.ksh.model.VoteCommVO;
import com.miracle.ksh.model.VoteItemVO;
import com.miracle.ksh.model.VoteVO;
import com.miracle.ksh.service.InterVoteService;
import com.miracle.ksh.util.MyUtil;
import com.miracle.psw.model.MemberVO;

@Controller
public class VoteController {
	
	@Autowired
	private InterVoteService service;
	
	//전체 투표 리스트를 가져와보자
	@RequestMapping(value="/voteList.mr", method={RequestMethod.GET})
	public String voteList(HttpServletRequest req, HttpSession session){
		
		//세션값을 불러와보자
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		
		//리스트가 3개 필요하다. 투표리스트, 투표항목리스트, 투표댓글리스트
		List<HashMap<String, String>> voteList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req); //돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		
		String fk_team_idx = teamInfo.get("team_idx");
		String teamwon_status = teamInfo.get("teamwon_status");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		map.put("fk_team_idx", fk_team_idx);
		
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
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1; //시작 페이지 번호
		endRno =  startRno + sizePerPage - 1; //끝 페이지 번호
		
		map.put("startRno", String.valueOf(startRno));
		map.put("endRno", String.valueOf(endRno));
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			voteList = service.VoteListYesPaging2(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList(map);
		} else{
			//검색어가 없는 경우
			voteList = service.VoteListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList(map);
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.VoteTotalCount2(map);
		} else{
			//검색어가 없는 경우
			totalCount = service.VoteTotalCount1(map);
		}
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "voteList.mr");	
		
		pagebar += "</ul>";
		
		
		req.setAttribute("gobackURL", gobackURL);
		req.setAttribute("teamwon_status", teamwon_status);
		
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
	
	//종료된 투표 리스트를 뽑아오자
	@RequestMapping(value="/voteEndList.mr", method={RequestMethod.GET})
	public String voteEndList(HttpServletRequest req, HttpSession session){
		
		//세션 값을 불러오자
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		
		List<HashMap<String, String>> voteEndList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req); //돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자
		
		req.setAttribute("gobackURL", gobackURL);
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		
		String fk_team_idx = teamInfo.get("team_idx");
		String teamwon_status = teamInfo.get("teamwon_status");
		
		//System.out.println(colname + " / " + search);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		map.put("fk_team_idx", fk_team_idx);
		
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
			voteCommList = service.VoteCommList(map);
		} else{
			//검색어가 없는 경우
			voteEndList = service.VoteEndListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList(map);
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.VoteEndTotalCount2(map);
		} else{
			//검색어가 없는 경우
			totalCount = service.VoteEndTotalCount1(map);
		}
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "voteEndList.mr");	
		
		pagebar += "</ul>";
		
		
		req.setAttribute("gobackURL", gobackURL);
		req.setAttribute("teamwon_status", teamwon_status);
		
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
	
	
	//내가 만든 투표 리스트를 뽑아오자
	@RequestMapping(value="/voteMyList.mr", method={RequestMethod.GET})
	public String voteMyList(HttpServletRequest req, HttpSession session){
		
		//세션 값을 불러오자
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		
		List<HashMap<String, String>> voteMyList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req); //돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자
		
		req.setAttribute("gobackURL", gobackURL);
		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		String votekind = req.getParameter("votekind"); //나의 투표 안에서도 투표 중, 투표 시작 전, 투표 종료된 것을 나눠주기 위한 것
		//String fk_teamwon_idx = session.getAttribute("fk_teamwon_idx");
		
		String fk_team_idx = teamInfo.get("team_idx");
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");
		String teamwon_status = teamInfo.get("teamwon_status");
		
		if(votekind == null || votekind.trim().isEmpty() || votekind.equals("null")){
			votekind = "ing"; //votekind의 기본 값은 투표 중으로 설정하자
		}
		
		//System.out.println(votekind);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		map.put("votekind", votekind);
		map.put("fk_team_idx", fk_team_idx);
		map.put("fk_teamwon_idx", fk_teamwon_idx);
		
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
			voteCommList = service.VoteCommList(map);
		} else{
			//검색어가 없는 경우
			voteMyList = service.VoteMyListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList(map);
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
		req.setAttribute("teamwon_status", teamwon_status);                                                                                
		
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
	
	//투표 작성 페이지를 불러오자
	@RequestMapping(value="/voteAdd.mr", method={RequestMethod.GET})
	public String voteAdd(HttpServletRequest req){
		
		return "ksh/vote/voteAdd.all";
	}
	
	
	//투표 작성 페이지에서 다 작성하면 실행해보자
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@RequestMapping(value="/voteAddEnd.mr", method={RequestMethod.POST})
	public String voteAddEnd(HttpServletRequest req, HttpSession session){
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser"); //로그인된 정보를 불러오자
		
		//System.out.println(loginUser.getIdx());
		
		String idx = String.valueOf(loginUser.getIdx());
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");
		
		String subject = req.getParameter("subject"); //제목
		String content = req.getParameter("content"); //내용
		String startdate = req.getParameter("datepicker1"); //투표시작일
		String enddate = req.getParameter("datepicker2"); //투표종료일
		
		//System.out.println(subject);
		
		String[] items = req.getParameterValues("items"); //항목들
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd"); //날짜의 포맷 설정
		Date startday = null;
		Date endday = null;
		Date today = null;
		
		Calendar c1 = Calendar.getInstance();
		String todate = format.format(c1.getTime());
		
		try {
			startday = format.parse(startdate); //투표시작일을 Date 형식으로 바꿔보자
			endday = format.parse(enddate); //투표종료일을 Date 형식으로 바꿔보자
			today = format.parse(todate);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		int compare1 = startday.compareTo(endday); //투표시작일과 투표종료일의 간격을 알아보자
		int compare2 = today.compareTo(endday); //현재 날짜와 투표종료일 사이의 간격을 알아보자
		
		
		boolean itemFlag = false; //항목이 2개 이상 썼는지 판별하는 플래그
		int itemValues = 0; //작성된 항목이 몇개 있는지 판별해보자
		
		for (String str : items) {
			if (str == null || str.length() == 0) { //빈 칸이라면
				break;
			} else {
				itemValues++; //빈 칸이 아니라면 작성된 항목으로 인식
			}
			
			if(items.length == itemValues) {
			    itemFlag = true; //전체 항목들의 수와 작성된 항목들의 수가 같다면 플래그를 올려보자
		    }
        }
			
		if(compare1 > 0){ //간격이 있다면 
			String msg = "종료일이 시작일보다 날짜가 앞섭니다.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else if(compare2 > 0){
			String msg = "종료일이 현재일보다 날짜가 앞섭니다.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else if(itemFlag == false){ //작성된 항목들이 2개 미만으로 썼다면
			
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
			mapVote.put("fk_teamwon_idx", fk_teamwon_idx);
			
			//System.out.println(subject + "/" + content + "/" + enddate);
			
			int x = service.VoteAdd(mapVote); //투표글을 만들어보자
			
			
			int lastidx = service.VoteLastIdx(); //막 추가된 투표글의 idx를 알아보자
			
			
			HashMap<String, Object> mapVoteItem = new HashMap<String, Object>();
			mapVoteItem.put("lastidx", lastidx);

			int n = 0;
		    int m = 0;
		    int count = 0;
	    	
		    
		    //투표의 문항들을 만들어보자
	    	for(int i=0; i<items.length; i++){
	    		mapVoteItem.put("items", items[i]);
	    		m = service.VoteItemAdd(mapVoteItem);
	    		
	    		if(m==1) count++;
	    	}
	    	
	    	//문항들을 다 만들었다면
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
	
	
	//문항 중 하나를 골라서 투표해보자
	@RequestMapping(value="/voteChoice.mr", method={RequestMethod.GET})
	public String voteChoice(HttpServletRequest req, HttpSession session){
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		
		String vote_idx = req.getParameter("vote_idx"); //투표글 idx
		String voteitem_idx = req.getParameter("voteitem_idx"); //문항 idx
		//String teamwon_idx = req.getParameter("teamwon_idx");
		//String ip = req.getRemoteAddr();
		String gobackURL = req.getParameter("gobackURL");
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");
		
		//System.out.println("확인 : " + ip);

		HashMap<String, String> mapVotedChk = new HashMap<String, String>();
		mapVotedChk.put("vote_idx", vote_idx);
		mapVotedChk.put("teamwon_idx", fk_teamwon_idx);
		
		String cnt = service.VotedCheck(mapVotedChk); //중복투표를 검사해보자
		
		//System.out.println(vote_idx + " / " + voteitem_idx + " / " + teamwon_idx);
		//System.out.println(cnt);
		
		if(cnt != null && !cnt.trim().isEmpty() && !cnt.equals("null")){ //중복투표 카운트가 0/null이 아니라면
			String msg = "이미 해당 투표에 참여하셨습니다.";
			//String loc = "voteList.mr";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", gobackURL);
			
			
			return "ksh/msg.not";
		} else {
			//중복투표 안했다면
			
			HashMap<String, String> mapVoted = new HashMap<String, String>();
			mapVoted.put("vote_idx", vote_idx);
			mapVoted.put("voteitem_idx", voteitem_idx);
			mapVoted.put("teamwon_idx", fk_teamwon_idx);
			
			int n = service.VotedAdd(mapVoted); //투표 기록 테이블에 기록을 남겨보자
			
			int m = service.VoteNumUpdate(voteitem_idx); //해당 문항의 득표 수를 올려보자
			
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
	
	
	//투표글을 삭제해보자
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
		int result = service.VoteDel(idx); //본격적으로 투표글을 삭제해보자
		
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
	
	
	//투표글 수정하는 페이지를 띄워보자
	@RequestMapping(value="/voteEdit.mr", method={RequestMethod.GET})
	public String voteEdit(HttpServletRequest req){
		
		String idx = req.getParameter("idx"); //수정하려는 투표글
		String gobackURL = req.getParameter("gobackURL");
		//System.out.println(idx);
		
		VoteVO votevo = service.VoteView(idx); //수정하려는 투표글의 원 내용을 가져오자
		List<VoteItemVO> voteitemvo = service.VoteItemView(idx); //수정하려는 투표글의 문항들의 내용들을 가져오자
		int cnt = service.VoteItemViewCnt(idx); //문항들의 개수를 구해오자
		
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
		req.setAttribute("gobackURL", gobackURL);
		
		return "ksh/vote/voteEdit.all";
	}
	
	//투표글을 최종적으로 수정해보자
	@RequestMapping(value="/voteEditEnd.mr", method={RequestMethod.POST})
	public String voteEditEnd(MultipartHttpServletRequest req) throws Throwable{
		
		String idx = req.getParameter("idx"); //투표글 idx
		String subject = req.getParameter("subject"); //제목
		String content = req.getParameter("content"); //내용
		String startdate = req.getParameter("datepicker1"); //투표시작일
		String enddate = req.getParameter("datepicker2"); //투표종료일
		String gobackURL = req.getParameter("gobackURL");
		
		//System.out.println(itemvo.getIdx());
		//System.out.println(idx);
		
		String none = "none"; //분류가 미정일 경우 none으로
				
		String[] items = req.getParameterValues("items"); //투표 항목 내용들
		String[] itemidx = req.getParameterValues("itemidx"); //투표 항목 idx들

		
		/*for(int i=0; i<items.length; i++){
			System.out.print(items[i] + "." + i + " ");
		}
		for(int i=0; i<itemidx.length; i++){
			System.out.print(itemidx[i] + "." + i + " ");
		}*/
		
		//System.out.println(items.length + " vs " + itemidx.length);
		
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd"); //날짜 형식 지정
		Date startday = null;
		Date endday = null;
		Date today = null;
		
		Calendar c1 = Calendar.getInstance();
		String todate = format.format(c1.getTime());
		
		try {
			startday = format.parse(startdate); //투표시작일을 넣어보자
			endday = format.parse(enddate); //투표종료일을 넣어보자
			today = format.parse(todate);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		int compare1 = startday.compareTo(endday); //투표시작일과 투표종료일 사이의 간격을 알아보자
		int compare2 = today.compareTo(endday); //현재 날짜와 투표종료일 사이의 간격을 알아보자
		
		
		boolean itemFlag = false; //항목이 2개 이상 썼는지 판별하는 플래그
		int itemValues = 0; //작성된 항목이 몇개 있는지 판별해보자

        for (int i = 0; i < items.length; i++) {
        	
        	//System.out.println("내용 : " + items[i]);
        	//System.out.println("길이 : " + items.length);
        	
			if (items[i] == null || items[i].length() == 0) { //항목이 작성되었는지 판별해보자
				break;
			} else {
				itemValues++;
			}
			
			if(items.length == itemValues) {
			    itemFlag = true;
		    }
        }

		if(compare1 > 0){
			String msg = "종료일이 시작일보다 날짜가 앞섭니다.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else if(compare2 > 0){
			String msg = "종료일이 현재일보다 날짜가 앞섭니다.";
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
			
			int x = service.VoteEdit(mapVote); //투표글을 수정해보자
			
			HashMap<String, Object> mapVoteItem = new HashMap<String, Object>();
			mapVoteItem.put("idx", idx);
			mapVoteItem.put("none", none);
			
			int n = service.VoteItemEdit(mapVoteItem, items, itemidx);
		    
		    
		    req.setAttribute("x", x);
			req.setAttribute("n", n);
			req.setAttribute("gobackURL", gobackURL);
			
			return "ksh/vote/voteEditEnd.all";
		
		}

	}
	
	//투표 시작 전 리스트를 뽑아오자
	@RequestMapping(value="/voteReadyList.mr", method={RequestMethod.GET})
	public String voteReadyList(HttpServletRequest req, HttpSession session){
		
		//세션을 불러오자
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		
		List<HashMap<String, String>> voteReadyList = null;
		List<VoteItemVO> voteItemList = null;
		List<HashMap<String, String>> voteCommList = null;
		
		String gobackURL = MyUtil.getCurrentURL(req);//돌아갈 페이지를 위해서 현재 페이지의 주소를 뷰단으로 넘겨주자		
		String colname = req.getParameter("colname");
		String search = req.getParameter("search");
		
		String fk_team_idx = teamInfo.get("team_idx");
		String teamwon_status = teamInfo.get("teamwon_status");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("colname", colname);
		map.put("search", search);
		map.put("fk_team_idx", fk_team_idx);
		
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
			voteCommList = service.VoteCommList(map);
		} else{
			//검색어가 없는 경우
			voteReadyList = service.VoteReadyListYesPaging1(map);
			voteItemList = service.VoteItemList();
			voteCommList = service.VoteCommList(map);
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.VoteReadyTotalCount2(map);
		} else{
			//검색어가 없는 경우
			totalCount = service.VoteReadyTotalCount1(map);
		}
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, null, "voteReadyList.mr");	
		
		pagebar += "</ul>";
		
		req.setAttribute("gobackURL", gobackURL);
		req.setAttribute("teamwon_status", teamwon_status);
		
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
	
	//투표 차트 결과를 띄워보자
	@RequestMapping(value="/voteCallChart.mr", method={RequestMethod.GET})
	public String voteCallChart(HttpServletRequest req){
		
		String idx = req.getParameter("idx"); //투표글 idx
		
		JSONArray jsonMap = new JSONArray();
		
		if(!idx.trim().isEmpty()){
			List<VoteItemVO> list = service.VoteItemChart(idx); //차트에 띄울 문항들을 갖고오자
			
			if(list != null){
				for(VoteItemVO vo : list){
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("idx", vo.getIdx());
					jsonObj.put("name", vo.getFk_vote_idx());
					jsonObj.put("item", vo.getItem());
					jsonObj.put("votenum", vo.getVotenum());
					
					jsonMap.put(jsonObj);
				}
			}
		}

		String str_jsonMap = jsonMap.toString();

		req.setAttribute("str_jsonMap", str_jsonMap);
		
		return "ksh/json/Chart.not";
	}
	
	
	//투표 댓글을 써보자
	@RequestMapping(value="/voteCommAdd.mr", method={RequestMethod.GET})
	public String voteCommAdd(HttpServletRequest req, HttpSession session){
		
		//세션을 넣어보자
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		//MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String gobackURL = req.getParameter("gobackURL");
		String comment = req.getParameter("comment"); //댓글 내용
		String voteidx = req.getParameter("voteidx"); //투표글 idx
		//String getidx = String.valueOf(loginUser.getIdx());
		String fk_teamwon_idx = teamInfo.get("teamwon_idx");
		
		//System.out.println("확인용 : " + comment + " / " + voteidx + " / " + fk_teamwon_idx);
		//System.out.println(gobackURL);

		//int fk_teamwon_idx = service.getFk_teamwon_idx(getidx);
		
		//String str_idx = String.valueOf(fk_teamwon_idx);
		
		comment.replace("\r\n", "<br>");
		
		HashMap<String, String> commMap = new HashMap<String, String>();
		commMap.put("comment", comment);
		commMap.put("voteidx", voteidx);
		commMap.put("fk_teamwon_idx", fk_teamwon_idx);
		
		
		
		int result = service.addComment(commMap); //투표 댓글을 넣어보자
		
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
	
	
	//댓글을 삭제해보자
	@RequestMapping(value="/voteCommDel.mr", method={RequestMethod.GET})
	public String voteCommDel(HttpServletRequest req){
		
		HttpSession session = req.getSession();
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String gobackURL = req.getParameter("gobackURL");
		String delidx = req.getParameter("delidx"); //삭제할 투표글 idx
		String getidx = String.valueOf(loginUser.getIdx()); //로그인한 회원의 idx
		
		//System.out.println(comment + " / " + voteidx + " / " + getidx);
		//System.out.println("확인용 : " + delidx);
		//System.out.println(gobackURL);

		int fk_teamwon_idx = service.getFk_teamwon_idx(getidx); //팀원 idx를 구해보자
		
		String str_idx = String.valueOf(fk_teamwon_idx);
		
		HashMap<String, String> commMap = new HashMap<String, String>();
		commMap.put("delidx", delidx);
		commMap.put("fk_teamwon_idx", str_idx);
		
		
		int result = service.DelComment(commMap); //댓글을 삭제해보자
		
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
