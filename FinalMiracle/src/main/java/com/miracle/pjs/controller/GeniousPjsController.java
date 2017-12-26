package com.miracle.pjs.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.miracle.pjs.model.FileVO;
import com.miracle.pjs.model.MapVO;
import com.miracle.pjs.model.MindFileVO;
import com.miracle.pjs.model.NoticeFileVO;
import com.miracle.pjs.model.PagingVO;
import com.miracle.pjs.service.PjsinterService;
import com.miracle.pjs.util.MyUtil;
import com.miracle.pjs.util.PjsFileManager;
import com.miracle.psw.model.MemberVO;

@Controller
public class GeniousPjsController {
	
	@Autowired
	private PjsinterService service;

	@Autowired
	private PjsFileManager filemanager;
	
	
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
			String url = MyUtil.getCurrentURL(req);
			session.setAttribute("gobackURL", url);
			HashMap<String, String> userTeam = service.getUserTeam(team); // 유저의 팀 정보를 가져온다.  teamNum, m.userid, m.idx as memberNum, w.status, m.img
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
			if("null".equals(searchString) || "null".equals(searchType) ) {
				searchType="";
				searchString="";
			}
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
			System.out.println("페이지처리================================"+sizePerPage+" "+blockSize+" "+currentPage+" "+searchType+" "+searchString);
			String pagebar = MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentPage, searchType, searchString, null, "noticeList.mr");
			List<HashMap<String, String>> list = service.getNoticeList(map); 
			for(int i=0; i<list.size(); i++) {
				map.put("idx", list.get(i).get("n_idx"));
				int count = service.getCountReply(map);
				String str_count = String.valueOf(count);
				list.get(i).put("count", str_count);
				String file = service.getfilenamelist(map);
				list.get(i).put("file", file);
			}
			String totalNum = service.getCountNum(map);
			req.setAttribute("totalNum", totalNum);
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
		String t_idx = req.getParameter("t_idx");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchString", searchString);
		map.put("searchType", searchType);
		map.put("t_idx", t_idx);
		String list = service.getNoticeJSONList(map);
		req.setAttribute("list", list);
		return "pjs/notice/noticeListJSON.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeUserInfo.mr", method={RequestMethod.GET})	// 공지사항 게시판글의 유저정보보기
	public String noticeUserInfo(HttpServletRequest req) {
		// 게시판에서 유저이름, 이미지 클릭시 해당 유저정보를 보여주는 메소드
		String id = req.getParameter("userid"); // 해당 번호의 글내용을 가져온다.
		HashMap<String, String> userinfo = service.getViewContent(id);
		// userid, name, img, age, hp, addr, profile, img, email
		JSONArray jsonList = new JSONArray();
		if( !userinfo.get("idx").trim().isEmpty() && !userinfo.get("userid").trim().isEmpty() ) {
			// search값에 해당하는 제목를 가져온다.
			JSONObject jobj = new JSONObject();
			jobj.put("infoUserid", userinfo.get("userid"));
			jobj.put("infoName", userinfo.get("name"));
			jobj.put("infoHp1", userinfo.get("hp"));
			jobj.put("infoBirth1", userinfo.get("age"));
			jobj.put("infoAddr1", userinfo.get("addr"));
			jobj.put("infoEmail", userinfo.get("email"));
			jobj.put("infoProfile", userinfo.get("profile"));
			jobj.put("infoImg", userinfo.get("img"));
			
			jsonList.put(jobj);
		}
		String searchJSON = jsonList.toString(); // .toString() 변환이유 : 출력목적!!
		//System.out.println("searchJSON 문자열값 : "+searchJSON);
		req.setAttribute("searchJSON", searchJSON);
		System.out.println("searchJSON="+searchJSON);
		//req.setAttribute("userinfo", userinfo);
		return "pjs/notice/noticeUserInfo.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeWrite.mr", method={RequestMethod.POST})	// 공지사항 게시판글 쓰기 
	public String noticeWrite(HttpServletRequest req, HttpSession session) {
		// 게시판을 클릭해서 글을 쓸 경우
		String idx = req.getParameter("idx");
		String userid = req.getParameter("userid");
		String teamNum = req.getParameter("teamNum");
		HashMap<String, String> team = new HashMap<String, String>();
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		HashMap<String, String> map = service.getUserTeam(team); // teamNum , userid , teamNum , memberNum, status 받는다.  ******************************

		String addr="";
		if(session.getAttribute("gobackURL")!=null) {
			addr = (String) session.getAttribute("gobackURL");
			session.removeAttribute("gobackURL");
		}
		
		req.setAttribute("gobackURL", addr);
		req.setAttribute("map", map);
		req.setAttribute("idx", idx);
		return "pjs/notice/noticeWrite.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeWriteEnd.mr", method={RequestMethod.POST})	// 공지사항 게시판글 쓰기 
	public String noticeWriteEnd(HttpServletRequest req, HttpSession ses, MultipartHttpServletRequest freq) {
		// 게시판을 클릭해서 글을 쓸 경우
		String userid = req.getParameter("userid");
		String teamNum = req.getParameter("teamNum");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		//String idx = req.getParameter("idx");
		
		HashMap<String, String> team = new HashMap<String, String>();
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		team.put("subject", subject);
		team.put("content", content.replace("\r\n","<br>"));
		// 첨부파일이 있는지 없는지 알아오기
		NoticeFileVO filevo = new NoticeFileVO();
		filevo.setAttach(freq.getFile("attach"));
		int n = 0;
		if(!filevo.getAttach().isEmpty()) {
			String root = ses.getServletContext().getRealPath("/");
			String path = root + "resources"+File.separator+"files";
			String newFileName = "";
			byte[] bytes=null;
			long fileSize=0;
			try{
				bytes = filevo.getAttach().getBytes();
				newFileName = filemanager.doFileUpload(bytes, filevo.getAttach().getOriginalFilename(), path);
				filevo.setFileName(newFileName); // 0001230410240104.jsp
				filevo.setOrgFilename(filevo.getAttach().getOriginalFilename()); // 강아지.jpg
				fileSize = filevo.getAttach().getSize();
				filevo.setFileSize(String.valueOf(fileSize));
				if(!filevo.getAttach().isEmpty()) {
					System.out.println("파일 첨부 되니?");
					team.put("newfilename", newFileName);
					team.put("originalfilename", filevo.getAttach().getOriginalFilename());
					team.put("filesize", String.valueOf(fileSize));
					String num = service.getNiticefileNum();
					String number = String.valueOf(Integer.parseInt(num)+1);
					team.put("number", number);
					n= service.setNoticeWriteWithFile(team);
				}
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		else {
			n = service.setNoticeWrite(team);
		}
		///////////////////////////
		String msg="";
		String loc="location.href='noticeList.mr;'";
		if(n>0) 
			msg="입력성공!";
		else 
			msg="입력실패!";
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		return "pjs/error.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeDel.mr", method={RequestMethod.GET})	// 공지사항 게시판글 삭제
	public String noticeDel(HttpServletRequest req) {
		// 게시판에서 삭제버튼을 눌렸을 때
		String str_idx = req.getParameter("idx");
		System.out.println("str_idx => " + str_idx);
		// 46,21
		String[] idxArr = str_idx.split(",");
		HashMap<String,String> paramap = new HashMap<String,String>();
		for(int i=0; i<idxArr.length; i++) {
			paramap.put("idxArr"+i, idxArr[i]);
		}
		int n = service.delNoticeIdx(paramap, idxArr);
		String loc="location.href='noticeList.mr;'";
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
		PagingVO pvo = new PagingVO();
		pvo.setSizePerPage(10);
		String str_currentPage = req.getParameter("currentShowPageNo");
		if(str_currentPage==null || "".equals(str_currentPage)) {
			pvo.setCurrentPage(1);
		}
		else {
			pvo.setCurrentPage(Integer.parseInt(str_currentPage));	
		}
		pvo.setBlockSize(3);
		pvo.setsNum(pvo.getCurrentPage(), pvo.getSizePerPage());
		pvo.seteNum(pvo.getsNum(), pvo.getSizePerPage());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sNum", pvo.getsNum());
		map.put("eNum", pvo.geteNum());
		String idx = req.getParameter("nidx");				//tbl_notice의 idx
		map.put("idx", idx);
		pvo.setTotalCount(service.getReplyCount(map)); 
		pvo.setTotalPage(pvo.getTotalCount(), pvo.getSizePerPage());
		pvo.setPagebar(pvo.getSizePerPage(), pvo.getBlockSize(), pvo.getTotalPage(), pvo.getCurrentPage(), "getnoticeReplyList.mr"); 
		pvo.setComment(service.getComment(map));
		for(int i =0; i<pvo.getComment().size(); i++) {
			System.out.println("==============================================리플"+pvo.getComment().get(i).getSesid());
		}
		//String sessionid = ((MemberVO)session.getAttribute("loginUser")).getUserid();
		req.setAttribute("idx", idx);
		req.setAttribute("pvo", pvo);
		//req.setAttribute("sessionid", sessionid);
		return "pjs/notice/comment.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="getnoticeReplyListajax.mr", method={RequestMethod.GET})	// 공지사항 게시판글 수정
	public String getnoticeReplyListajax(HttpServletRequest req, HttpSession session) {
		// 공지사항 게시판의 해당 글을 볼 때 그 글의 코멘트를 가져오는 메소드
		PagingVO pvo = new PagingVO();
		pvo.setSizePerPage(10);
		String str_currentPage = req.getParameter("currentShowPageNo");
		System.out.println("str_currentPage : "+str_currentPage);
		if(str_currentPage==null || "".equals(str_currentPage)) {
			pvo.setCurrentPage(1);
		}
		else {
			pvo.setCurrentPage(Integer.parseInt(str_currentPage));	
		}
		pvo.setBlockSize(3);
		pvo.setsNum(pvo.getCurrentPage(), pvo.getSizePerPage());
		System.out.println("setsNum====================="+pvo.getsNum());
		pvo.seteNum(pvo.getsNum(), pvo.getSizePerPage());
		System.out.println("seteNum====================="+pvo.geteNum());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("sNum", pvo.getsNum());
		map.put("eNum", pvo.geteNum());
		String idx = req.getParameter("idx");				//tbl_notice의 idx
		map.put("idx", idx);
		pvo.setTotalCount(service.getReplyCount(map)); 
		pvo.setTotalPage(pvo.getTotalCount(), pvo.getSizePerPage());
		pvo.setPagebar(pvo.getSizePerPage(), pvo.getBlockSize(), pvo.getTotalPage(), pvo.getCurrentPage(), "getnoticeReplyListajax.mr"); 
		pvo.setComment(service.getComment(map));
		System.out.println("pvo"+pvo.getTotalCount()+" "+pvo.getTotalPage()+" "+pvo.getPagebar()+" "+pvo.getComment().size());
		//String sessionid = ((MemberVO)session.getAttribute("loginUser")).getUserid();
		req.setAttribute("idx", idx);
		req.setAttribute("pvo", pvo);
		//req.setAttribute("sessionid", sessionid);
		return "pjs/notice/comment.not";
	}/* ================================================================================================================================================== */

	@RequestMapping(value="setnoticeReplyList.mr", method={RequestMethod.POST})	// 공지사항 게시판글 수정
	public void setnoticeReplyList(HttpServletRequest req) {
		// 공지사항 게시판의 해당 글을 볼 때 그 글의 코멘트를 가져오는 메소드
		String idx = req.getParameter("idx");
		String co = req.getParameter("contents");
		String userid = req.getParameter("userid");
		System.out.println("================댓글쓸때================"+idx+" "+co+" "+userid);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("idx", idx);
		map.put("comment", co.replace("\r\n","<br>"));
		map.put("userid", userid);
		int n = service.setComment(map); 
		if(n>0) System.out.println("댓글 입력 성공");
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeView.mr", method={RequestMethod.GET})	// 공지사항 게시판글 보기 
	public String noticeView(HttpServletRequest req, HttpSession session) {
		String userid = req.getParameter("userid");  // tbl_notice의 fk_userid
		String nidx = req.getParameter("idx");		 // tbl_notice의 idx
		String teamidx = req.getParameter("teamidx");// 뷰단에서 받아온 team_idx
		String sessionid = ((MemberVO)session.getAttribute("loginUser")).getUserid();
		if("1".equals((String)session.getAttribute("readCount"))&&!userid.equals(sessionid)) {
			// 조회수를 올린다.!!!!!!!!!!!!!!!!!!!!!!!!!
			int n = service.updateReadCount(nidx);
			if(n > 0) {
				session.removeAttribute("readCount");
				System.out.println("=========================여기오냐? 조회수!!=====================");
			}	
		}
		HashMap<String, String> view = new HashMap<String, String>();
		view.put("nidx", nidx);
		view.put("teamidx", teamidx);
		HashMap<String, String> info = service.getNoticeInfo(view);
		HashMap<String, String> map =  service.getIdxTeam(view); // USERID, IMG, SUBJECT, CONTENT, STATUS, IDX, FILENAME, ORGFILENAME, FILESIZE, FK_IDX
		NoticeFileVO file = service.getfilename(nidx);
		//List<ReplyVO> comment = service.getComment(nidx); // 해당 nidx에 해당하는 comment를 가져온다.
		//req.setAttribute("sessionid", sessionid);
		//req.setAttribute("comment", comment);
		
		String addr = "";
		if(session.getAttribute("gobackURL")!=null) {
			addr = (String) session.getAttribute("gobackURL");
			session.removeAttribute("gobackURL");
		}
		
		req.setAttribute("gobackURL", addr);
		req.setAttribute("info", info);
		req.setAttribute("file", file);
		req.setAttribute("map", map);
		req.setAttribute("nidx",nidx);
		return "pjs/notice/noticeView.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeEditWrite.mr", method={RequestMethod.GET})	// 공지사항 게시판글 수정
	public String noticeEditWrite(HttpServletRequest req) {
		// 공지사항 게시판의 수정글을 쓰는 메소드
		String nidx = req.getParameter("nidx");
		String userid = req.getParameter("userid");
		String teamNum = req.getParameter("teamNum");
		HashMap<String, String> user = new HashMap<String, String>();
		user.put("userid", userid);
		user.put("teamidx", teamNum);
		HashMap<String, String> map = service.getUserTeam(user); // teamNum , userid , teamNum , memberNum, status 받는다.  ******************************
		req.setAttribute("map", map); // 수정글 쓰기 들어간다.
		req.setAttribute("nidx", nidx);
		return "pjs/notice/noticeEditWrite.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeEditWriteEnd.mr", method={RequestMethod.POST})	// 공지사항 게시판글 수정
	public String noticeEditWriteEnd(HttpServletRequest req) {
		// 수정글 쓰기 완료
		//String depth = String.valueOf(Integer.parseInt(service.getDepth(req.getParameter("nidx")))+1);
		HashMap<String, String> layer = service.getDepth(req.getParameter("nidx"));
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", req.getParameter("userid"));
		map.put("teamNum", req.getParameter("teamNum"));
		map.put("subject", req.getParameter("subject"));
		map.put("content", req.getParameter("content").replace("\r\n", "<br>"));
		map.put("nidx", req.getParameter("idx"));
		map.put("depth", String.valueOf(Integer.parseInt(layer.get("depth"))+1));
		map.put("groupno", layer.get("groupno"));
		int n = service.setNoticeEditWrite(map);
		String loc="location.href='../../miracle/noticeList.mr;'";
		if(n > 0) {
			String msg = "입력성공!";
			req.setAttribute("msg", msg);
		}
		else {
			String msg = "입력실패";
			req.setAttribute("msg", msg);
		}
		req.setAttribute("loc", loc);
		return "pjs/error.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="download.mr", method = {RequestMethod.GET})
	public void download(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		String nidx = req.getParameter("nidx");
		String fidx = req.getParameter("fidx");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("nidx", nidx);
		map.put("fidx", fidx);
		System.out.println("nidx========="+nidx+"======================="+fidx);
		// 첨부파일이 있는 글번호

		// 첨부파일이 있는 글번호에서
		// 201611220930481985323774614.jpg 처럼
		// 이러한 fileName 값을 DB에서 가져와야 한다.
		// 또한 orgFileName 값도 DB에서 가져와야 한다.

		FileVO vo = service.getViewWithNoAddCount(map);
		// 조회수 증가 없이 1개 글 가져오기
		// 먼저 board.xml 에 가서 id가 getView 인것에서
		// select 절에 fileName, orgFilename, fileSize 컬럼을
		// 추가해주어야 한다.

		String fileName = vo.getFilename();
		// 201611220930481985323774614.jpg 와 같은 것이다.
		// 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
		String orgFilename = vo.getOrgFilename();
		// Desert.jpg 처럼 다운받을 사용자에게 보여줄 파일명.

		// 첨부파일이 저장되어 있는
		// WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다.
		// 이 경로는 우리가 파일첨부를 위해서
		// /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		String root = session.getServletContext().getRealPath("/");
		System.out.println("root================================"+root);
		String path = root + "resources" + File.separator + "files";
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.

		// **** 다운로드 하기 **** //
		// 다운로드가 실패할 경우 메시지를 띄워주기 위해서
		// boolean 타입 변수 flag 를 선언한다.
		boolean flag = false;
		flag = filemanager.doFileDownload(fileName, orgFilename, path, res);
		// 다운로드가 성공이면 true 를 반납해주고,
		// 다운로드가 실패이면 false 를 반납해준다.
		if (!flag) {
			// 다운로드가 실패할 경우 메시지를 띄워준다.
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = null;
			try {
				writer = res.getWriter();
				// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
			} catch (IOException e) {
			}
			writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.!!')</script>");
		}
}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeViewEdit.mr", method={RequestMethod.GET})	// 공지사항 게시판글 수정
	public String noticeViewEdit(HttpServletRequest req) {
		// 공지사항 게시판의 수정글을 쓰는 메소드
		String nidx = req.getParameter("idx");
		String teamNum = req.getParameter("teamidx");
		System.out.println("==================수정 오니==================="+nidx+" "+teamNum );
		HashMap<String, String> view = new HashMap<String, String>();
		view.put("nidx", nidx);
		view.put("teamidx", teamNum);
		HashMap<String, String> map =  service.getIdxTeam(view); // USERID, IMG, SUBJECT, CONTENT, STATUS, IDX, FILENAME, ORGFILENAME, FILESIZE, FK_IDX
		NoticeFileVO file = service.getfilename(nidx);
		//List<ReplyVO> comment = service.getComment(nidx); // 해당 nidx에 해당하는 comment를 가져온다.
		//req.setAttribute("sessionid", sessionid);
		//req.setAttribute("comment", comment);
		req.setAttribute("file", file);
		req.setAttribute("map", map);
		req.setAttribute("nidx",nidx);
		req.setAttribute("teamNum", teamNum);
		return "pjs/notice/noticeViewEdit.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="noticeViewEditEnd.mr", method={RequestMethod.POST})	// 공지사항 게시판글 수정
	public String noticeViewEditEnd(HttpServletRequest req) {
		// 게시판을 클릭해서 글을 쓸 경우
		String userid = req.getParameter("userid");
		String teamNum = req.getParameter("teamNum");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		String idx = req.getParameter("idx");
		System.out.println("======================여기오나?============="+userid+" "+teamNum+" "+subject+" "+content+" "+idx);
		HashMap<String, String> team = new HashMap<String, String>();
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		team.put("subject", subject);
		team.put("content", content.replace("\r\n","<br>"));
		team.put("idx", idx);
		int n = service.setUpdateWrite(team); // update
		System.out.println("===============================여긴 와?=====================");
		String msg="";
		String loc="location.href='noticeList.mr;'";
		if(n>0) 
			msg="수정성공!";
		else 
			msg="수정실패!";
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		return "pjs/error.not";
	}/* ================================================================================================================================================== */
	
/*=======================================================================================================================================================*/	

	
	
	
	
	
/*=======================================================================================================================================================*/	
	// ==== *** 마음의 소리 게시판 *** ==== //
	@RequestMapping(value="mindList.mr", method={RequestMethod.GET})
	public String mindList(HttpServletRequest req, HttpSession session) {
		// 팀장인 사람의 userid를 불러와야 한다.
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser"); // 유저의 정보를 가져온다.
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo"); // team_idx, teamwon_idx, teamwon_status
		HashMap<String, String> team = new HashMap<String, String>(); // 유저아이디와 팀번호가 유일한 유저를 불러온다.
		team.put("userid", mvo.getUserid());
		team.put("teamidx", teamInfo.get("team_idx"));
		//if(mvo != null) {
			String url = MyUtil.getCurrentURL(req);
			session.setAttribute("gobackURL", url);
			HashMap<String, String> userTeam = service.getUserTeam(team); // 유저의 팀 정보를 가져온다. ******************************
			req.setAttribute("userTeam", userTeam); // teamNum , userid  , memberNum, status 받는다.
			session.setAttribute("readCount", "1"); // 게시판 리스트에서 게시글을 읽어야만 readcont가 올라가도록 설정!
			/* ========== 유저정보 불러오기 끝 ========== */
			String searchType = req.getParameter("searchType");
			String searchString = req.getParameter("searchString");
			String str_sizePerPage = req.getParameter("sizePerPage");
			String str_currentPage = req.getParameter("currentShowPageNo");
			if("null".equals(searchString) || "null".equals(searchType) ) {
				searchType="";
				searchString="";
			}
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("searchType", searchType);
			map.put("searchString", searchString);
			map.put("status", userTeam.get("status"));
			map.put("userid", userTeam.get("userid"));
			map.put("teamNum", userTeam.get("teamNum"));
			List<HashMap<String, String>> list = service.getMindList(map, str_sizePerPage, str_currentPage); // 게시판을 가져오는 서비스단
			String pagebar = list.get(list.size()-1).get("pagebar");
			list.remove(list.size()-1);
			for(int i=0; i<list.size(); i++) {
				map.put("idx", list.get(i).get("d_idx"));
				String file = service.getMindfilenamelist(map);
				list.get(i).put("file", file);
			}
			req.setAttribute("sizePerPage", str_sizePerPage);
			req.setAttribute("searchType", searchType);
			req.setAttribute("searchString", searchString);
			req.setAttribute("pagebar", pagebar);
			req.setAttribute("list", list);
			req.setAttribute("userTeam", userTeam); //teamNum , userid  , memberNum, status
			return "pjs/mind/mindList.all";
			/* 리스트에서 m_idx, fk_userid subject regday readcount img, depth, status, t_idx, groupno, tstatus 받는다.*/ 
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
	public String mindJSON(HttpServletRequest req, HttpSession ses) {
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)ses.getAttribute("teamInfo");
		// team_idx, teamwon_idx, teamwon_status
		String searchString = req.getParameter("searchString");
		String searchType = req.getParameter("searchType");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchString", searchString);
		map.put("searchType", searchType);
		map.put("status", teamInfo.get("teamwon_status"));
		map.put("userid", ((MemberVO)ses.getAttribute("loginUser")).getUserid());
		map.put("teamNum", teamInfo.get("team_idx"));
		String list = service.getMindJSONList(map);
		req.setAttribute("list", list);
		return "pjs/mind/mindListJSON.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindView.mr", method={RequestMethod.GET})
	public String mindView(HttpServletRequest req, HttpSession session) {
		String userid = req.getParameter("userid");  // tbl_mind의 fk_userid
		String idx = req.getParameter("idx");		 // tbl_mind의 idx
		String teamidx = req.getParameter("teamNum");// 뷰단에서 받아온 team_idx
		String sessionid = ((MemberVO)session.getAttribute("loginUser")).getUserid();
		
		if("1".equals((String)session.getAttribute("readCount"))&&!userid.equals(sessionid)) {
			// 조회수를 올린다.!!!!!!!!!!!!!!!!!!!!!!!!!
			int n = service.updateMindReadCount(idx);
			if(n > 0)
				session.removeAttribute("readCount");
		}
		HashMap<String, String> view = new HashMap<String, String>();
		view.put("didx", idx);
		view.put("teamidx", teamidx);
		HashMap<String, String> map =  service.getMindIdxTeam(view); 
		MindFileVO file = service.getMindfilename(idx);
		// team_idx, userid, img, subject, content status 받는다.
		String addr="";
		if(file != null) 
			req.setAttribute("file", file);
		if(session.getAttribute("gobackURL")!=null) {
			addr = (String) session.getAttribute("gobackURL");
			session.removeAttribute("gobackURL");
		}
		req.setAttribute("addr", addr);
		req.setAttribute("map", map);
		req.setAttribute("didx",idx);
		return "pjs/mind/mindView.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindWrite.mr", method={RequestMethod.POST})	// 마음의 소리 게시판글 쓰기 
	public String mindWrite(HttpServletRequest req, HttpSession session) {
		String idx = req.getParameter("idx"); // 수정글의 idx
		System.out.println("idx====================="+idx);
		String userid = req.getParameter("userid");
		String teamNum = req.getParameter("teamNum");
		HashMap<String, String> team = new HashMap<String, String>();
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		HashMap<String, String> map = service.getUserTeam(team); // teamNum , userid , teamNum , status 받는다.  ******************************
		
		String addr = "";
		if(session.getAttribute("gobackURL")!=null) {
			addr = (String) session.getAttribute("gobackURL");
			session.removeAttribute("gobackURL");
		}
		
		req.setAttribute("gobackURL", addr);
		req.setAttribute("map", map);
		req.setAttribute("idx", idx);
		return "pjs/mind/mindWrite.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindReplyWrite.mr", method={RequestMethod.GET})	// 마음의 소리 답변글 쓰기
	public String mindReplyWrite(HttpServletRequest req) {
		String nidx = req.getParameter("nidx");
		System.out.println("nidx========================="+nidx);
		String userid = req.getParameter("userid");
		String teamNum = req.getParameter("teamNum");
		String chkid = req.getParameter("chkid");
		HashMap<String, String> team = new HashMap<String, String>();
		if(nidx != null || !"".equals(nidx) )
			team.put("nidx", nidx);
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		HashMap<String, String> map = service.getUserTeam(team); // teamNum , userid , memberNum, status 받는다.  ******************************
		req.setAttribute("map", map);
		req.setAttribute("nidx", nidx);
		req.setAttribute("chkid", chkid);
		return "pjs/mind/mindWrite.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="minddownload.mr", method = {RequestMethod.GET})
	public void minddownload(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		String idx = req.getParameter("idx");
		String fidx = req.getParameter("fidx");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("idx", idx);
		map.put("fidx", fidx);
		System.out.println("===================="+idx+" "+"fidx"+" "+fidx);
		// 첨부파일이 있는 글번호

		// 첨부파일이 있는 글번호에서
		// 201611220930481985323774614.jpg 처럼
		// 이러한 fileName 값을 DB에서 가져와야 한다.
		// 또한 orgFileName 값도 DB에서 가져와야 한다.

		FileVO vo = service.getmindViewWithNoAddCount(map);
		// 조회수 증가 없이 1개 글 가져오기
		// 먼저 board.xml 에 가서 id가 getView 인것에서
		// select 절에 fileName, orgFilename, fileSize 컬럼을
		// 추가해주어야 한다.

		String fileName = vo.getFilename();
		// 201611220930481985323774614.jpg 와 같은 것이다.
		// 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
		String orgFilename = vo.getOrgFilename();
		// Desert.jpg 처럼 다운받을 사용자에게 보여줄 파일명.

		// 첨부파일이 저장되어 있는
		// WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다.
		// 이 경로는 우리가 파일첨부를 위해서
		// /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "files";
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.

		// **** 다운로드 하기 **** //
		// 다운로드가 실패할 경우 메시지를 띄워주기 위해서
		// boolean 타입 변수 flag 를 선언한다.
		boolean flag = false;
		flag = filemanager.doFileDownload(fileName, orgFilename, path, res);
		// 다운로드가 성공이면 true 를 반납해주고,
		// 다운로드가 실패이면 false 를 반납해준다.
		if (!flag) {
			// 다운로드가 실패할 경우 메시지를 띄워준다.
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = null;
			try {
				writer = res.getWriter();
				// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
			} catch (IOException e) {
			}
			writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.!!')</script>");
		}
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindWriteEnd.mr", method={RequestMethod.POST})	// 마음의 소리 게시판글 쓰기 
	public String mindWriteEnd(HttpServletRequest req, HttpSession ses, MultipartHttpServletRequest freq) {
		// 게시판을 클릭해서 글을 쓸 경우 // nidx, subject, content ,userid, teanNum
		String idx = req.getParameter("idx");
		System.out.println("===========idx============="+idx);
		String userid = req.getParameter("userid");
		System.out.println("userid ==========================="+userid);
		String teamNum = req.getParameter("teamNum");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		HashMap<String, String> team = new HashMap<String, String>();
		//team.put("idx", idx);
		team.put("nidx", idx);
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		team.put("subject", subject);
		team.put("content", content.replace("\r\n","<br>"));
		if(idx != null && !"".equals(idx)) {
			HashMap<String, String> depth = service.getMindDepth(idx);
			team.put("depth", String.valueOf(Integer.parseInt(depth.get("depth"))+1) );
			team.put("chkid", req.getParameter("chkid"));
		}
		//int setMindWrite(HashMap<String, String> team); // 마음의 소리 글쓰기
		//int setMindWriteWithFile(HashMap<String, String> team); // 마음의 소리 글쓰기 파일첨부
		
		int n=service.setMindWrite(team); 
		if(n > 0) {
			int num = service.updateMindCheckNum(idx);
			System.out.println("==========================확인완료 업데이트 완료====================="+num);
		}
	        
	    // **** 첨부파일이 있는지 없는지 알아오기 끝 **** //
	    /*int n = service.add(boardvo);*/                // 파라미터로 vo가 오면 req로 오는 정보를 다 받는다.
	    /*=== #136. 파일첨부가 없는 경우 또는 파일첨부가 있는 경우 service 단으로 호출하기 , 먼저 위의 int n = service.add(boardvo); 주석처리 */
        MindFileVO filevo = new MindFileVO();
		filevo.setAttach(freq.getFile("attach"));
		if(!filevo.getAttach().isEmpty()) {
			String root = ses.getServletContext().getRealPath("/");
			String path = root + "resources"+File.separator+"files";
			String newFileName = "";
			byte[] bytes=null;
			long fileSize=0;
			try{
				bytes = filevo.getAttach().getBytes();
				newFileName = filemanager.doFileUpload(bytes, filevo.getAttach().getOriginalFilename(), path);
				filevo.setFileName(newFileName); // 0001230410240104.jsp
				filevo.setOrgFilename(filevo.getAttach().getOriginalFilename()); // 강아지.jpg
				fileSize = filevo.getAttach().getSize();
				filevo.setFileSize(String.valueOf(fileSize));
				if(!filevo.getAttach().isEmpty()) {
					team.put("newfilename", newFileName);
					team.put("originalfilename", filevo.getAttach().getOriginalFilename());
					team.put("filesize", String.valueOf(fileSize));
					String num = service.getMindfileNum();
					String number = String.valueOf(Integer.parseInt(num)+1);
					team.put("number", number);
					n = service.setMindWriteWithFile(team);
					System.out.println("n은============================="+n);
				}
				else {
					n = service.setMindWrite(team);
				}
			} catch(Exception e){
				n=0;
				e.printStackTrace();
			}
		}
		String msg="";
		String loc="location.href='mindList.mr;'";
		if(n>0) 
			msg="입력성공!";
		else 
			msg="입력실패!";
		System.out.println("=================msg============"+msg);
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		return "pjs/error.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindDel.mr", method={RequestMethod.GET})	// 마음의 소리 게시판글 삭제
	public String mindDel(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		// 게시판에서 삭제버튼을 눌렸을 때
		String str_idx = req.getParameter("idx");
		System.out.println("str_idx => " + str_idx);
		// 46,47
		String[] idxArr = str_idx.split(",");
		
		HashMap<String,String> paramap = new HashMap<String,String>();
		for(int i=0; i<idxArr.length; i++) {
			paramap.put("idxArr"+i, idxArr[i]);
		}
		
		int n = service.delMindIdx(paramap , idxArr);
		String loc="location.href='mindList.mr;'";
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
	@RequestMapping(value="mindUserInfo.mr", method={RequestMethod.GET})	// 마음의 소리 게시판글의 유저정보보기
	public String mindUserInfo(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우
		String id = req.getParameter("userid"); // 해당 번호의 글내용을 가져온다.
		HashMap<String, String> userinfo = service.getViewContent(id);
		req.setAttribute("userinfo", userinfo);
		return "pjs/mind/mindUserInfo.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindViewEdit.mr", method={RequestMethod.POST})	// 마음의 소리 게시판글의 유저정보보기
	public String mindViewEdit(HttpServletRequest req) {
		// 1. 게시판을 클릭해서 글을 볼 목적일 경우 //userid, 글번호(idx), teamNum
		String userid = req.getParameter("userid"); // 해당 번호의 글내용을 가져온다.
		String idx = req.getParameter("idx");
		String teamidx = req.getParameter("teamNum");
		HashMap<String, String> view = new HashMap<String, String>();
		view.put("didx", idx);
		view.put("teamidx", teamidx);
		view.put("userid", userid);
		HashMap<String, String> map =  service.getMindIdxTeam(view); 
		// team_idx, userid, img, subject, content status 받는다.;
		req.setAttribute("map", map);
		req.setAttribute("didx",idx);
		return "pjs/mind/mindViewEdit.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="mindViewEditEnd.mr", method={RequestMethod.POST})	// 마음의 소리 게시판글 쓰기 
	public String mindViewEditEnd(HttpServletRequest req, HttpSession ses, MultipartHttpServletRequest freq) {
		// 게시판을 클릭해서 글을 쓸 경우 // nidx, subject, content ,userid, teanNum
		//System.out.println("여기온다.!!!!!!!!!!!!!!!!ㄴ");
		String idx = req.getParameter("idx");
		String nidx = req.getParameter("nidx");
		String userid = req.getParameter("userid");
		String teamNum = req.getParameter("teamNum");
		String subject = req.getParameter("subject");
		String content = req.getParameter("content");
		System.out.println("================================"+idx+" "+nidx+" "+userid+" "+teamNum+ " "+ subject+" "+content);
		HashMap<String, String> team = new HashMap<String, String>();
		team.put("idx", idx);
		team.put("nidx", nidx);
		team.put("userid", userid);
		team.put("teamidx", teamNum);
		team.put("subject", subject);
		team.put("content", content.replace("\r\n","<br>"));
		/*if(nidx != null && !"".equals(nidx)) {
			HashMap<String, String> depth = service.getMindDepth(nidx);
			team.put("depth", String.valueOf(Integer.parseInt(depth.get("depth"))+1) );
			team.put("chkid", req.getParameter("chkid"));
		}*/
		int n=service.setMindViewEdit(team);
		/*if(n > 0) {
			int num = service.updateMindCheckNum(nidx);
			System.out.println("==========================확인완료 업데이트 완료====================="+num);
		}*/
		String msg="";
		String loc="location.href='mindList.mr;'";
		if(n>0) 
			msg="입력성공!";
		else 
			msg="입력실패!~~~~";
		System.out.println("=================msg============"+msg);
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		System.out.println("loc================================="+loc);
		return "pjs/error.not";
	}/* ================================================================================================================================================== */
/*=======================================================================================================================================================*/	
	
	
	
	
	
	
/*=======================================================================================================================================================*/	
	// ==== *** 구글맵 *** ==== //
	@RequestMapping(value="googleMapbasic.mr", method={RequestMethod.GET})
	public String googleMapbasic(HttpServletRequest req, HttpSession session) {
		@SuppressWarnings("unchecked")
		HashMap<String, String> map = (HashMap<String,String>)session.getAttribute("teaminfo");
		System.out.println("=========================="+map.get("team_idx"));
		List<MapVO> list = service.getMap(map); // 전체 리스트를 반환한다.
		req.setAttribute("list", list);
		return "pjs/map/googleMapbasic.not";
	}/* ================================================================================================================================================= */
	@RequestMapping(value="googleMap.mr", method={RequestMethod.GET})
	public String googleMap(HttpServletRequest req, HttpSession session) {
		@SuppressWarnings("unchecked")
		HashMap<String, String> teamInfo = (HashMap<String, String>)session.getAttribute("teamInfo");
		String team_idx = teamInfo.get("team_idx");
		String choice = req.getParameter("choice");
		String searchString = req.getParameter("searchString");
		System.out.println("searchString==========================================="+ searchString);
		System.out.println("choice==================================================="+choice);
		if(!(choice==null||searchString==null||!"0".equals(choice))) {
			System.out.println("특정 구글맵 오냐==============================================-------");
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("choice", choice);
			map.put("searchString", searchString);
			map.put("team_idx", team_idx);
			System.out.println("=========================="+map.get("team_idx"));
			List<MapVO> list = service.getMapWithSearch(map); // 전체 리스트를 반환한다.
			req.setAttribute("list", list);
			req.setAttribute("choice", choice);
			req.setAttribute("searchString", searchString);
		}
		else {
			System.out.println("전체 구글맵 오냐===================================================");
			List<MapVO> list = service.getMap(teamInfo); // 전체 리스트를 반환한다.
			req.setAttribute("list", list);
			req.setAttribute("choice", choice);
			req.setAttribute("searchString", searchString);
		}
		return "pjs/map/googleMap2.all";
	}/* ================================================================================================================================================= */

	@RequestMapping(value="googleMapJSON.mr", method={RequestMethod.GET})
	public String googleMapJSON(HttpServletRequest req) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchString", req.getParameter("searchString") );
		map.put("choice", req.getParameter("choice") );
		//System.out.println("================처음에 초이스값은?======================="+req.getParameter("choice"));
		String googleMap = service.getSearchJSON(map);
		req.setAttribute("googleMap", googleMap);
		return "pjs/map/googleMapJSON.not";
	}/* =======================================================================================================1=========================================== */
	@RequestMapping(value="googleMapTeamInfoJSON.mr", method={RequestMethod.GET})
	public String googleMapTeamInfoJSON(HttpServletRequest req) {
		String map_team_idx = req.getParameter("map_team_idx");
		String map_idx = req.getParameter("map_idx");
		System.out.println("오냐??????????????????????????"+map_team_idx+"    "+map_idx);
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
	}/* ================================================================================================================================================== */
/*=======================================================================================================================================================*/	
	
	
	
	
	
/*=======================================================================================================================================================*/	
	// ==== *** 쪽지 *** ==== //
	@SuppressWarnings("unchecked")
	@RequestMapping(value="memomemory.mr", method={RequestMethod.GET})
	public String memomemory(HttpServletRequest req, HttpSession ses) {
		String url = MyUtil.getCurrentURL(req);
		ses.setAttribute("gobackURL", url);
		HashMap<String, String> team = new HashMap<String, String>();  // 유저아이디와 팀번호가 유일한 유저를 불러온다.
		team.put("userid", ((MemberVO) ses.getAttribute("loginUser")).getUserid()); // 유저의 아이디를 가져온다.
		team.put("teamidx", ((HashMap<String, String>)ses.getAttribute("teamInfo")).get("team_idx")); 
		HashMap<String, String> userTeam = service.getUserTeam(team); // 유저의 팀 정보를 가져온다.  teamNum, m.userid, m.idx as memberNum, w.status, m.img		
		int sizePerPage=10;
		int currentPage=0;
		try {
			currentPage = Integer.parseInt(req.getParameter("currentPage"));
			if(currentPage<0){
				currentPage=1;
			}
		} catch(NumberFormatException e){
			currentPage=1;
		}
		int blockSize=3;
		String sNum = String.valueOf( ((currentPage - 1)*sizePerPage)+1 );
		String eNum = String.valueOf( Integer.parseInt(sNum) + sizePerPage - 1 );
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userTeam.get("userid"));
		map.put("teamNum", userTeam.get("teamNum"));
		map.put("sNum", sNum);
		map.put("eNum", eNum);
		int totalCount = service.getSenderMemo(map); 
		int totalPage=(int)Math.ceil((double)totalCount / sizePerPage);
		List<HashMap<String, String>> list = service.getSenderMemoList(map);// 보낸 쪽지 리스트 가저요기
		List<String> nArr = new ArrayList<String>();  
		String name="";
		for(int i=0; i<list.size(); i++) {
			HashMap<String, String> count = new HashMap<String, String>();
			count.put("idx", list.get(i).get("idx")); 
			count.put("userid", list.get(i).get("sender"));
			count.put("teamNum", list.get(i).get("teamnum"));
			List<String> nameArr = service.getReceiverNames(count);// 받은 사람 리스트 받기
			// String check = service.getCheckNum(map); // 읽었는지 여부를 반환한다.(웹소켓으로 적용)
			for(int j=0; j<nameArr.size(); j++) {
				if(j==nameArr.size()-1) {
					name += nameArr.get(j);
				} else {
					name += nameArr.get(j)+",";
				}
			}
			list.get(i).put("names", name);
			count.remove("idx");
			count.remove("userid");
			count.remove("teamNum");
			name = "";
		}
		for(int i=0; i<list.size(); i++) {
			String memoread = service.getmemoReadCount(list.get(i).get("idx"));
			System.out.println("================================="+list.get(i).get("idx"));
			list.get(i).put("read", memoread);
		}
		String pagebar = MyUtil.getPageBar(sizePerPage, blockSize, totalPage, currentPage, "memomemory.mr");
		
		req.setAttribute("nArr", nArr); // 이름 배열
		req.setAttribute("list", list); // IDX, SUBJECT, CONTENT, SENDER, SSTATUS, NAME, TEAMNUM, IMG, writedate
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("userTeam", userTeam); // teamNum, m.userid, m.idx as memberNum, w.status, m.img  필요없다고 판단 시 빼자!
		return "pjs/memo/memoSenderList.all";
	}/* =======================================================================================================1=========================================== */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="memoreceiver.mr", method={RequestMethod.GET})
	public String memosender(HttpServletRequest req, HttpSession ses) {
		String url = MyUtil.getCurrentURL(req);
		ses.setAttribute("gobackURL", url);
		// readCount를 주기위한 방안
		ses.setAttribute("readCount", "1");
		HashMap<String, String> team = new HashMap<String, String>();  // 유저아이디와 팀번호가 유일한 유저를 불러온다.
		team.put("userid", ((MemberVO) ses.getAttribute("loginUser")).getUserid()); // 유저의 아이디를 가져온다.
		team.put("teamidx", ((HashMap<String, String>)ses.getAttribute("teamInfo")).get("team_idx")); 
		HashMap<String, String> userTeam = service.getUserTeam(team); // 유저의 팀 정보를 가져온다.  teamNum, m.userid, m.idx as memberNum, w.status, m.img		
		int sizePerPage=10;
		int currentPage=0;
		try {
			currentPage = Integer.parseInt(req.getParameter("currentPage"));
			if(currentPage<0){
				currentPage=1;
			}
		} catch(NumberFormatException e){
			currentPage=1;
		}
		int blockSize=3;
		String sNum = String.valueOf( ((currentPage - 1)*sizePerPage)+1 );
		String eNum = String.valueOf( Integer.parseInt(sNum) + sizePerPage - 1 );
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userTeam.get("userid"));
		map.put("teamNum", userTeam.get("teamNum"));
		map.put("sNum", sNum);
		map.put("eNum", eNum);
		int totalCount = service.getReceiverMemo(map); 
		int totalPage=(int)Math.ceil((double)totalCount / sizePerPage);
		List<HashMap<String, String>> list = service.getReceiverMemoList(map);// 리스트 가저요기
		
		String pagebar = MyUtil.getPageBar(sizePerPage, blockSize, totalPage, currentPage, "memomemory.mr");
		
		req.setAttribute("list", list); // idx, receiver, rreadcount, readdate, subject, content , sender, writedate, name, img
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("userTeam", userTeam); // teamNum, m.userid, m.idx as memberNum, w.status, m.img  필요없다고 판단 시 빼자!
		return "pjs/memo/memoReceiverList.all";
	}/* =======================================================================================================1=========================================== */
	@SuppressWarnings("unchecked") // 컴파일러가 일반적으로 경고하는 내용 중 "이건 하지마"하고 제외시킬 때
	@RequestMapping(value="memoWrite.mr", method={RequestMethod.GET})
	public String memoWrite(HttpServletRequest req, HttpSession ses) {
		HashMap<String, String> team = new HashMap<String, String>();  // 유저아이디와 팀번호가 유일한 유저를 불러온다.
		team.put("userid", ((MemberVO) ses.getAttribute("loginUser")).getUserid()); // 유저의 아이디를 가져온다.
		team.put("teamidx", ((HashMap<String, String>)ses.getAttribute("teamInfo")).get("team_idx")); 
		HashMap<String, String> userTeam = service.getUserTeam(team); // 유저와 유저의 팀 정보를 가져온다.  teamNum, m.userid, m.idx as memberNum, w.status, m.img
		
		List<HashMap<String, String>> mapteam = service.getTeam(((HashMap<String, String>)ses.getAttribute("teamInfo")).get("team_idx"));//같은 팀 정보를 추출
		
		//List<HashMap<String, String>> mapAll = service.getAllMember();//모든 팀 정보를 추출
		req.setAttribute("mapteam", mapteam); // name, teamNum, userid
		//req.setAttribute("mapAll", mapAll);
		req.setAttribute("userTeam", userTeam);
		for(int i=0; i<mapteam.size(); i++) {
			System.out.println("==================="+mapteam.get(i).get("name"));
			System.out.println("==================="+mapteam.get(i).get("teamNum"));
			System.out.println("==================="+mapteam.get(i).get("idx"));
		}
		return "pjs/memo/memoWrite.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="memoWriteEnd.mr", method={RequestMethod.POST})
	public String memoWriteEnd(HttpServletRequest req) {
		String receiver = req.getParameter("idx");
		String subject = req.getParameter("subject").replaceAll("\r\n", "<br/>");
		String content = req.getParameter("content").replaceAll("\r\n", "<br/>");
		String writeUserid = req.getParameter("userid");
		String[] str_arr = receiver.split(",");
		List<String> list = new ArrayList<String>();
		int cnt=0;
		for(int i=0; i<str_arr.length; i++) {
			for(int j=i+1; j<str_arr.length; j++) {
				if(str_arr[i].equals(str_arr[j]))
					cnt++;
			}
			if(cnt==0) {
				list.add(str_arr[i]);
			}
			cnt=0;
		}
		for(int i=0; i<list.size(); i++) {
			System.out.println("======================list================"+list.get(i));
		}
		// 메모 insert하기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("subject",subject);
		map.put("content",content);
		map.put("writeuserid",writeUserid);
		int n = service.insertMemo(map, list);
		String loc="location.href='memoreceiver.mr;'";
		if(n > 0) {
			String msg = "입력 성공!";
			req.setAttribute("msg", msg);
		}
		else {
			String msg = "입력 실패";
			req.setAttribute("msg", msg);
		}
		req.setAttribute("list", list);
		req.setAttribute("n", n);
		req.setAttribute("loc", loc);
		return "pjs/alarm.not";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="memoSenderView.mr", method={RequestMethod.GET})
	public String memoSenderView(HttpServletRequest req, HttpSession ses) {
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("idx", req.getParameter("idx"));
		info.put("teamNum", req.getParameter("teamNum"));
		HashMap<String,String> map =  service.getSenderIdx(info);
		req.setAttribute("map", map); // IDX, SUBJECT, CONTENT, SENDER, SSTATUS, img, 팀원인지 팀장인지status
		req.setAttribute("teamNum", info.get("teamNum"));
		return "pjs/memo/memoSenderView.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="memoReceiverView.mr", method={RequestMethod.GET})
	public String memoReceiverView(HttpServletRequest req, HttpSession ses) {
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("idx", req.getParameter("idx"));
		info.put("teamNum", req.getParameter("teamNum"));
		HashMap<String,String> map =  service.getReceiverIdx(info); // r.idx, y.sender, r.rstatus, r.rreadcount, y.subject, y.content, y.sstatus, m.img , r.receiver
		if("1".equals(ses.getAttribute("readCount")) && !(map.get("sender").equals(((MemberVO)ses.getAttribute("loginUser")).getUserid())) && map.get("receiver").equals(((MemberVO)ses.getAttribute("loginUser")).getUserid()) ) {
			int readcount=service.checkReadCount(req.getParameter("idx"));
			if(readcount == 0) {
				int n = service.updateRreadCount(req.getParameter("idx"), ((MemberVO)ses.getAttribute("loginUser")).getUserid());
				System.out.println("================================n========================="+n);
			}
		}
		
		req.setAttribute("map", map); // IDX, SUBJECT, CONTENT, SENDER, SSTATUS, img, 팀원인지 팀장인지status
		req.setAttribute("teamNum", info.get("teamNum"));
		return "pjs/memo/memoReceiverView.all";
	}/* ================================================================================================================================================== */
	@RequestMapping(value="memosenderDel.mr", method={RequestMethod.POST})  /// **************************해야 한다.
	public String memosenderDel(HttpServletRequest req) {
		String str_idx = req.getParameter("idx");
		String[] idxArr = str_idx.split(",");
		HashMap<String,String[]> idx = new HashMap<String,String[]>();
		idx.put("idxArr", idxArr);
		int n = service.delSenderMemo(idx);
		
		String loc="location.href='memomemory.mr;'";
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
	} /* ================================================================================================================================================== */
	@RequestMapping(value="memoreceiverDel.mr", method={RequestMethod.POST}) /// **************************해야 한다.
	public String memoreceiverDel(HttpServletRequest req) {
		String str_idx = req.getParameter("idx");
		System.out.println("====================여기오니??=====================");
		String[] idxArr = str_idx.split(",");
		HashMap<String,String[]> idx = new HashMap<String,String[]>();
		idx.put("idxArr", idxArr);
		int n = service.delReceiverMemo(idx);
		
		String loc="location.href='memoreceiver.mr;'";
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
	@RequestMapping(value="alarm.mr", method={RequestMethod.GET})
	public String alarm(HttpServletRequest req) {
		String idx = req.getParameter("idx");
		String userid = req.getParameter("userid");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("idx", idx);
		map.put("userid", userid);
		
		JSONArray jsonList = new JSONArray();
		if( !map.get("idx").trim().isEmpty() && !map.get("userid").trim().isEmpty() ) {
			// search값에 해당하는 제목를 가져온다.
			String list = service.getMessage(map);
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("alarm", list);
				jsonList.put(jsonObj);
		}
		String searchJSON = jsonList.toString(); // .toString() 변환이유 : 출력목적!!
		//System.out.println("searchJSON 문자열값 : "+searchJSON);
		req.setAttribute("searchJSON", searchJSON);
		//System.out.println("================================1111=============================="+searchJSON);
		return "pjs/memo/JSON.not";
	}/* ================================================================================================================================================== */
	
	
/*=======================================================================================================================================================*/	

	
	
}		
