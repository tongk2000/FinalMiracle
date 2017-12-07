package com.miracle.pjs.controller;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.miracle.pjs.model.MapVO;
import com.miracle.pjs.model.ReplyVO;
import com.miracle.pjs.service.PjsinterService;
import com.miracle.pjs.util.MyUtil;
import com.miracle.psw.model.MemberVO;


@Controller
public class GeniousPjs {
	
	@Autowired
	private PjsinterService service;

/*=======================================================================================================================================================*/	
	
	// ==== *** 공지사항 게시판 *** ==== //
	@RequestMapping(value="noticeList.mr", method={RequestMethod.GET}) // 공지사항 게시판 리스트
	public String notice(HttpServletRequest req, HttpSession session) {	
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");// 팀의 정보를 가져온다. team_idx, teamwon_idx, teamwon_status
		HashMap<String, String> team = new HashMap<String, String>();  // 유저아이디와 팀번호가 유일한 유저를 불러온다.
		team.put("userid", ((MemberVO) session.getAttribute("loginUser")).getUserid()); // 유저의 아이디를 가져온다.
		team.put("teamidx", teamInfo.get("team_idx")); 
		//if(mvo != null) {
			HashMap<String, String> userTeam = service.getUserTeam(team); // 유저의 팀 정보를 가져온다. teamNum, userid, name, status
			req.setAttribute("userTeam", userTeam); // 세션에서 얻을 수 없는 유저의 팀정보를 뷰단으로 보내 여러 조건에 비교용으로 쓴다.
			session.setAttribute("readCount", "1"); // 게시판 리스트에서 게시글을 읽어야만 readcont가 올라가도록 설정!
			/* ============================== 페이징 처리 시 필요한 변수들! ============================== */
			int sizePerPage = 0;
			int currentPage = 0;
			String str_sizePerPage = req.getParameter("sizePerPage");
			if(str_sizePerPage==null || "".equals(str_sizePerPage)) {
				sizePerPage = 10;
			}
			else {
				if(!"10".equals(sizePerPage) && !"5".equals(sizePerPage) && !"3".equals(sizePerPage)){
					sizePerPage = 10;
				}
				else {
					try{ 
						sizePerPage = Integer.parseInt(str_sizePerPage);
					} catch (NumberFormatException e) {
						String msg="숫자값만 입력하세요!";
						String loc="location.href='../../miracle/noticeList.mr;";
						req.setAttribute("msg",msg);
						req.setAttribute("loc",loc);
						sizePerPage = 10;
						return "pjs/error.not";
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
			String searchType = req.getParameter("searchType");
			String searchString = req.getParameter("searchString");
			String teamNum = req.getParameter("teamNum");
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("searchType", searchType);
			map.put("searchString", searchString);
			map.put("sNum", sNum);
			map.put("eNum", eNum);
			/*if(teamNum == null || "".equals(teamNum)) {
				if(userTeam.size() > 1) {
					List<String> tn = new ArrayList<String>();
					for(int i=0; i<userTeam.size(); i++){
						tn.add(userTeam.get(i).get("teamNum"));
					}
					map.put("tn", tn);
				}
				else {
					map.put("teamNum", userTeam.get(0).get("teamNum"));
				}
			}
			else {
				map.put("teamNum", teamNum);
			} */
			if(teamNum==null||"".equals(teamNum))
				map.put("teamNum", userTeam.get("teamNum"));
			else
				map.put("teamNum", teamNum);
			int totalCount = service.getNoticeCount(map); 
			int totalPage=(int)Math.ceil((double)totalCount / sizePerPage);
			String pagebar = MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentPage, searchType, searchString, null, "noticeList.mr");
			List<HashMap<String, String>> list = service.getNoticeList(map); 
			req.setAttribute("list", list);
			req.setAttribute("searchType", searchType);
			req.setAttribute("searchString", searchString);
			req.setAttribute("pagebar", pagebar);
			return "pjs/notice/noticeList.all";
		//}
		/*else {
			String msg = "로그인이 안된 상태입니다.";
			String loc = "location.href='../../miracle';"; // 현재경로 기준으로 위치바꿈!
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			return "pjs/error.not";
		}*/
	}/* ================================================================================================================================================== */
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
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeUserInfo.mr", method={RequestMethod.GET})	// 공지사항 게시판글의 유저정보보기
	public String noticeUserInfo(HttpServletRequest req) {
		// 게시판에서 유저이름, 이미지 클릭시 해당 유저정보를 보여주는 메소드
		String id = req.getParameter("userid"); // 해당 번호의 글내용을 가져온다.
		HashMap<String, String> userinfo = service.getViewContent(id);
		req.setAttribute("userinfo", userinfo);
		return "pjs/notice/noticeUserInfo.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeWrite.mr", method={RequestMethod.POST})	// 공지사항 게시판글 쓰기 
	public String noticeWrite(HttpServletRequest req) {
		// 게시판을 클릭해서 글을 쓸 경우
		String userid = req.getParameter("userid"); // teamNum
		String teamNum = req.getParameter("teamNum");
		HashMap<String, String> team = new HashMap<String, String>();
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		HashMap<String, String> map = service.getUserTeam(team); // teamNum , userid , teamNum , status 받는다.  ******************************
		req.setAttribute("map", map);
		return "pjs/notice/noticeWrite.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeDel.mr", method={RequestMethod.GET})	// 공지사항 게시판글 삭제
	public String noticeDel(HttpServletRequest req) {
		// 게시판에서 삭제버튼을 눌렸을 때
		String idx = req.getParameter("idx");
		int n = service.delNoticeIdx(idx);
		String loc = "location.href='noticeList.mr;'";
		if(n > 0) {
			String msg = "삭제 성공!";
			req.setAttribute("msg", msg);
		}
		else {
			String msg = "삭제 실패";
			req.setAttribute("msg", msg);
		}
		req.setAttribute("loc", loc);
		return "pjs/error.not";		
	}/* ================================================================================================================================================== */
	@RequestMapping(value="getnoticeReplyList.mr", method={RequestMethod.GET})	// 공지사항 게시판글 수정
	public String getnoticeReplyList(HttpServletRequest req, HttpSession session) {
		// 공지사항 게시판의 해당 글을 볼 때 그 글의 코멘트를 가져오는 메소드
		String nidx = req.getParameter("nidx");				//tbl_notice의 idx
		List<ReplyVO> comment = service.getComment(nidx);
		System.out.println("=====================확인용================="+comment.get(0).getRegday()+"       "+comment.size());
		String sessionid = ((MemberVO)session.getAttribute("loginUser")).getUserid();
		req.setAttribute("comment", comment);
		req.setAttribute("sessionid", sessionid);
		return "pjs/notice/comment.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="setnoticeReplyList.mr", method={RequestMethod.POST})	// 공지사항 게시판글 수정
	public void setnoticeReplyList(HttpServletRequest req) {
		// 공지사항 게시판의 해당 글을 볼 때 그 글의 코멘트를 가져오는 메소드
		String idx = req.getParameter("idx");
		String co = req.getParameter("contents");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("idx", idx);
		map.put("comment", co);
		int n = service.setComment(map);
		if(n == 0) {
			System.out.println("================== 삽입실패 ==================");
		}
		else {
			System.out.println("-----------------삽입성공------------------");
		}
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeView.mr", method={RequestMethod.GET})	// 공지사항 게시판글 보기 
	public String noticeView(HttpServletRequest req, HttpSession session) {
		String userid = req.getParameter("userid");  // tbl_notice의 fk_userid
		String nidx = req.getParameter("idx");		 // tbl_notice의 idx
		String teamidx = req.getParameter("teamidx");// 뷰단에서 받아온 team_idx
		String sessionid = "pjs";//((MemberVO)session.getAttribute("loginUser")).getUserid();
		if("1".equals((String)session.getAttribute("readCount"))&&!userid.equals(sessionid)) {
			// 조회수를 올린다.!!!!!!!!!!!!!!!!!!!!!!!!!
			int n = service.updateReadCount(nidx);
			if(n > 0)
				session.removeAttribute("readCount");
			else 
				System.out.println("==================디비 업데이트 실패===================");
		}
		HashMap<String, String> view = new HashMap<String, String>();
		view.put("nidx", nidx);
		view.put("teamidx", teamidx);
		HashMap<String, String> map =  service.getIdxTeam(view); // team_idx , userid 받는다.
		//List<ReplyVO> comment = service.getComment(nidx); // 해당 nidx에 해당하는 comment를 가져온다.
		//req.setAttribute("sessionid", sessionid);
		//req.setAttribute("comment", comment);
		req.setAttribute("map", map);
		req.setAttribute("nidx",nidx);
		return "pjs/notice/noticeView.all";
	}
	
	
	
/*=======================================================================================================================================================*/	
	
	// ==== *** 마음의 소리 게시판 *** ==== //
	@RequestMapping(value="mindList.mr", method={RequestMethod.GET})
	public String mindList(HttpServletRequest req, HttpSession session) {
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser"); // 유저의 정보를 가져온다.
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo"); // 팀의 정보를 가져온다.
		HashMap<String, String> team = new HashMap<String, String>(); // 유저아이디와 팀번호가 유일한 유저를 불러온다.
		team.put("userid", mvo.getUserid());
		team.put("teamidx", teamInfo.get("team_idx"));
		//if(mvo != null) {
			HashMap<String, String> userTeam = service.getUserTeam(team); // 유저의 팀 정보를 가져온다. ******************************
			req.setAttribute("userTeam", userTeam); // 세션에서 얻을 수 없는 유저의 팀정보를 뷰단으로 보내 여러 조건에 비교용으로 쓴다.
			session.setAttribute("readCount", "1"); // 게시판 리스트에서 게시글을 읽어야만 readcont가 올라가도록 설정!
			/* ========== 유저정보 불러오기 끝 ========== */
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
		//}
		/*else {
			String msg = "로그인이 안된 상태입니다.";
			String loc = "location.href='../../miracle';"; // 현재경로 기준으로 위치바꿈!
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			return "pjs/error.not";
		}*/
		
	}/* ================================================================================================================================================== */
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
	}/* ================================================================================================================================================== */
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
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindDel.mr", method={RequestMethod.GET})	// 공지사항 게시판글 삭제
	public String mindDel(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return "noticeView.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindEdit.mr", method={RequestMethod.GET})	// 공지사항 게시판글 수정
	public String mindEdit(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String idx = req.getParameter("idx");
		req.setAttribute("idx", idx);
		return "noticeView.all";
	}/* ================================================================================================================================================== */
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
		String choice = req.getParameter("choice");
		String searchString = req.getParameter("searchString");
		if(!(choice==null||searchString==null||"0".equals(choice))) {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("choice", choice);
			map.put("searchString", searchString);
			List<MapVO> list = service.getMapWithSearch(map); // 전체 리스트를 반환한다.
			req.setAttribute("list", list);
			req.setAttribute("choice", choice);
			req.setAttribute("searchString", searchString);
		}
		else {
			List<MapVO> list = service.getMap(); // 전체 리스트를 반환한다.
			req.setAttribute("list", list);
			req.setAttribute("choice", choice);
			req.setAttribute("searchString", searchString);
		}
		return "pjs/map/googleMap.all";
	}/* =======================================================================================================1=========================================== */
	@RequestMapping(value="googleMapJSON.mr", method={RequestMethod.GET})
	public String googleMapJSON(HttpServletRequest req) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchString", req.getParameter("searchString") );
		map.put("choice", req.getParameter("choice") );
		// System.out.println("================처음에 초이스값은?======================="+req.getParameter("choice")); 0 이다.
		String googleMap = service.getSearchJSON(map);
		req.setAttribute("googleMap", googleMap);
		return "pjs/map/googleMapJSON.not";
	}/* =======================================================================================================1=========================================== */
	@RequestMapping(value="googleMapTeamInfoJSON.mr", method={RequestMethod.GET})
	public String googleMapTeamInfoJSON(HttpServletRequest req) {
		String map_team_idx = req.getParameter("map_team_idx");
		String map_idx = req.getParameter("map_idx");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("map_idx", map_idx);
		if(map_team_idx==null||"0".equals(map_team_idx)){ // null이거나 0일 때 음식점 정보를 가져온다.
			HashMap<String, String> googleMapFood = service.getMapFood(map_idx);
			req.setAttribute("googleMap", googleMapFood);
			req.setAttribute("n", "0");
		}
		else { // null이 아니면 팀 정보를 가져온다.
			List<HashMap<String, String>> googleMapTeam = service.getMapTeam(map_idx);
			req.setAttribute("googleMap", googleMapTeam);
			req.setAttribute("n", "1");
		}
		return "pjs/map/googleMapTeamInfoJSON.not";
	}
	
/*=======================================================================================================================================================*/	
	
	
	// ==== *** 쪽지 *** ==== //
	@RequestMapping(value="memo.mr", method={RequestMethod.GET})
	public String memo(HttpServletRequest req) {
		return "pjs/memo/?.all";
	}
	
	
/*=======================================================================================================================================================*/	

	
}		
