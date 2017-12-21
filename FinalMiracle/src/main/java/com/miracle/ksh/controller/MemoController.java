package com.miracle.ksh.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.miracle.ksh.model.MemoVO;
import com.miracle.ksh.service.InterMemoService;
import com.miracle.ksh.service.InterVoteService;
import com.miracle.ksh.util.MyUtil;
import com.miracle.psw.model.MemberVO;

@Controller
public class MemoController {

	@Autowired
	private InterMemoService service;
	
	//메모 리스트를 뽑아오자
	@RequestMapping(value="/memoList.mr", method={RequestMethod.GET})
	public String memoList(HttpServletRequest req, HttpSession session){
		
		List<HashMap<String, String>> memoList = null;
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String fk_member_idx = String.valueOf(loginUser.getIdx()); //회원 idx
		String folder = req.getParameter("folder"); //메모분류
		String colname = req.getParameter("colname"); //검색분류
		String search = req.getParameter("search"); //검색내용
		String gobackURL = MyUtil.getCurrentURL(req);
		
		List<String> folderlist = service.getfolderList(fk_member_idx); //분류 리스트를 뽑아오자
		
		HashMap<String, String> memoMap = new HashMap<String, String>();
		memoMap.put("fk_member_idx", fk_member_idx);
		memoMap.put("colname", colname);
		memoMap.put("search", search);
		
		String str_currentShowPageNo = req.getParameter("currentShowPageNo");
		String str_sizePerPage = req.getParameter("sizePerPage");
		String period = req.getParameter("period"); //기간별 설정
		
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
		
		if(period == null){
			//게시판의 초기화면
			period = "-1";
		}
		
		if(folder == null){
			folder = "전체"; //분류의 기본값을 전체로 줘보자
		}
		
		//System.out.println("확인 : " + folder);
		
		startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
		endRno =  startRno + sizePerPage - 1;
		
		
		memoMap.put("startRno", String.valueOf(startRno));
		memoMap.put("endRno", String.valueOf(endRno));
		memoMap.put("period", period);
		memoMap.put("folder", folder);
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있	는 경우
			memoList = service.memoList2(memoMap);
		} else{
			//검색어가 없는 경우
			memoList = service.memoList1(memoMap);
		}
		
		if( (colname != null && search != null) && (!colname.trim().isEmpty() && !search.trim().isEmpty()) && (!colname.equals("null") && !search.equals("null"))){
			//검색어가 있는 경우
			totalCount = service.MemoTotalCount2(memoMap);
		} else{
			//검색어가 없는 경우
			totalCount = service.MemoTotalCount1(memoMap);
		}
		
		
		totalPage = (int)Math.ceil((double)totalCount/sizePerPage);
		
		String pagebar = "<ul>";
		
		pagebar += MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentShowPageNo, colname, search, period, "memoList.mr");	
		
		pagebar += "</ul>";

		req.setAttribute("folderlist", folderlist);
		req.setAttribute("gobackURL", gobackURL);
		req.setAttribute("folder", folder);
		
		req.setAttribute("pagebar", pagebar);
		req.setAttribute("colname", colname);
		req.setAttribute("search", search);
		req.setAttribute("sizePerPage", sizePerPage);
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("period", period);
		
		req.setAttribute("memoList", memoList);		
		
		return "ksh/memo/memolist.all";
	}
	
	
	//메모 작성하는 페이지를 띄워보자
	@RequestMapping(value="/memoAdd.mr", method={RequestMethod.GET})
	public String memoAdd(HttpServletRequest req, HttpSession session){

		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String fk_member_idx = String.valueOf(loginUser.getIdx());
		
		List<String> folderlist = service.getfolderList(fk_member_idx); //회원만의 폴더리스트들을 뽑아오자

		req.setAttribute("folderlist", folderlist);
		
		return "ksh/memo/memoadd.all";
	}
	
	//메모를 작성해보자
	@RequestMapping(value="/memoAddEnd.mr", method={RequestMethod.POST})
	public String memoAddEnd(HttpServletRequest req, HttpSession session){
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String fk_member_idx = String.valueOf(loginUser.getIdx()); //회원 idx
		String subject = req.getParameter("subject"); //제목
		String content = req.getParameter("content"); //내용
		String folder = req.getParameter("folder"); //분류
		String newfolder = req.getParameter("newfolder"); //새 분류
		
		String gobackURL = req.getParameter("gobackURL");		
		
		HashMap<String, String> memoMap = new HashMap<String, String>();
		memoMap.put("fk_member_idx", fk_member_idx);
		memoMap.put("subject", subject);
		memoMap.put("content", content);
		memoMap.put("folder", folder);
		memoMap.put("newfolder", newfolder);
		
		int n = service.MemoAdd(memoMap);
		
		req.setAttribute("n", n);
		req.setAttribute("gobackURL", gobackURL);
		
		return "ksh/memo/memoaddEnd.all";
	}
	
	//메모를 수정하는 페이지를 띄워보자
	@RequestMapping(value="/memoEdit.mr", method={RequestMethod.GET})
	public String memoEdit(HttpServletRequest req, HttpSession session){
		
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		String fk_member_idx = String.valueOf(loginUser.getIdx());
		
		String idx = req.getParameter("idx"); //수정하려는 메모 idx
		String gobackURL = req.getParameter("gobackURL");
		
		//System.out.println("확인용 : " + idx);
		
		List<MemoVO> memovo = service.getMemoVO(idx); //수정하려는 메모의 내용들을 받아오자
		List<String> folderlist = service.getfolderList(fk_member_idx); //회원의 메모 분류들을 받아오자

		req.setAttribute("memovo", memovo);
		req.setAttribute("folderlist", folderlist);
		req.setAttribute("gobackURL", gobackURL);
		
		return "ksh/memo/memoedit.all";
	}
	
	//메모를 수정해보자
	@RequestMapping(value="/memoEditEnd.mr", method={RequestMethod.POST})
	public String memoEditEnd(HttpServletRequest req){
		
		String idx = req.getParameter("idx"); //메모 idx
		String subject = req.getParameter("subject"); //제목
		String content = req.getParameter("content"); //내용
		String folder = req.getParameter("folder"); //분류
		
		String gobackURL = req.getParameter("gobackURL");
		
		HashMap<String, String> memoMap = new HashMap<String, String>();
		memoMap.put("idx", idx);
		memoMap.put("subject", subject);
		memoMap.put("content", content);
		memoMap.put("folder", folder);
		
		int n = service.MemoEdit(memoMap); //메모를 수정해보자
		
		req.setAttribute("n", n);
		req.setAttribute("gobackURL", gobackURL);
		
		return "ksh/memo/memoeditEnd.all";
	}
	
	//메모를 휴지통으로 보내보자
	@RequestMapping(value="/memoGarbage.mr", method={RequestMethod.GET})
	public String memoGarbage(HttpServletRequest req){
		
		String idx = req.getParameter("idx"); //메모 idx
		String gobackURL = req.getParameter("gobackURL");
		
		int n = service.MemoGarbage(idx); //메모를 휴지통으로 보내보자
		
		
		if(n > 0){
			String msg = "해당 메모를 휴지통으로 보냈습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "해당 메모를 휴지통으로 보내는 데 실패했습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
		
	}
	
	//체크박스에 선택한 메모들을 휴지통으로 보내보자
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@RequestMapping(value="/memoChkGarbage.mr", method={RequestMethod.GET})
	public String memoChkGarbage(HttpServletRequest req){
		
		String[] idxs = req.getParameterValues("chk_memo"); //선택된 메모 idx들
		String gobackURL = req.getParameter("gobackURL");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		int cnt = 0;
		
		for(int i = 0; i<idxs.length; i++){
			int n = 0;
			
			map.put("idxs", idxs[i]);
			n = service.MemoGarbage(map); //메모를 휴지통으로 보내보자
			
			if(n == 1){
				cnt++;
			}
		}
		
		if(cnt == idxs.length){
			String msg = "선택된 메모들을 휴지통으로 보냈습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "선택된 메모들을 휴지통으로 보내는 데 실패했습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
		
	}
	
	//메모를 삭제해보자
	@RequestMapping(value="/memoRestore.mr", method={RequestMethod.GET})
	public String memoRestore(HttpServletRequest req){
		
		String idx = req.getParameter("idx");
		String gobackURL = req.getParameter("gobackURL");
		
		int n = service.MemoRestore(idx); //메모를 삭제해보자
		
		
		if(n > 0){
			String msg = "해당 메모를 복구했습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "해당 메모를 복구하는데 실패했습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
	}
	
	
	//휴지통에 존재하는 체크박스에 선택한 메모들을 복구시켜보자
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@RequestMapping(value="/memoChkRestore.mr", method={RequestMethod.GET})
	public String memoChkRestore(HttpServletRequest req){
		
		String[] idxs = req.getParameterValues("chk_memo"); //선택된 메모 idx들
		String gobackURL = req.getParameter("gobackURL");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		int cnt = 0;
		
		for(int i = 0; i<idxs.length; i++){
			int n = 0;
			
			map.put("idxs", idxs[i]);
			n = service.MemoRestore(map); //메모를 휴지통으로 보내보자
			
			if(n == 1){
				cnt++;
			}
		}
		
		if(cnt == idxs.length){
			String msg = "선택된 메모들의 복구가 완료되었습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "선택된 메모들의 복구에 실패하였습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
		
	}
	
	//메모를 삭제해보자
	@RequestMapping(value="/memoDel.mr", method={RequestMethod.POST})
	public String memoDel(HttpServletRequest req){
		
		
		String idx = req.getParameter("idx");
		String gobackURL = req.getParameter("gobackURL");
		
		int n = service.MemoDel(idx);
		
		
		if(n > 0){
			String msg = "해당 메모를 삭제했습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "해당 메모를 삭제하는데 실패했습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
	}
	
	//선택된 메모들을 삭제시켜보자
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@RequestMapping(value="/memoChkDel.mr", method={RequestMethod.POST})
	public String memoChkDel(HttpServletRequest req){
		
		String[] idxs = req.getParameterValues("chk_memo"); //선택된 메모 idx들
		String gobackURL = req.getParameter("gobackURL");
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		int cnt = 0;
		
		for(int i = 0; i<idxs.length; i++){
			int n = 0;
			
			map.put("idxs", idxs[i]);
			n = service.MemoDel(map); //메모를 휴지통으로 보내보자
			
			if(n == 1){
				cnt++;
			}
		}
		
		if(cnt == idxs.length){
			String msg = "선택된 메모들의 삭제가 완료되었습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "선택된 메모들의 삭제에 실패하였습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
		
	}
	
	//선택된 메모들의 분류를 변경시켜보자
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@RequestMapping(value="/memoUpdateFolder.mr", method={RequestMethod.POST})
	public String memoUpdateFolder(HttpServletRequest req, HttpSession session){
		
		String upfolder = req.getParameter("upfolder");
		String[] idxs = req.getParameterValues("chk_memo"); //선택된 메모 idx들
		String gobackURL = req.getParameter("gobackURL");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("upfolder", upfolder);
		
		int cnt = 0;
		
		for(int i = 0; i<idxs.length; i++){
			int n = 0;
			
			map.put("idxs", idxs[i]);
			n = service.MemoUpdateGroups(map); //메모를 휴지통으로 보내보자
			
			if(n == 1){
				cnt++;
			}
		}
		
		if(cnt == idxs.length){
			String msg = "선택된 메모들의 분류 변경이 완료되었습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "선택된 메모들의 분류 변경에 실패하였습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
	}
	
	
	//선택된 메모들의 분류를 변경시켜보자 (새 분류를 만들 경우)
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@RequestMapping(value="/memoCreateFolder.mr", method={RequestMethod.POST})
	public String memoCreateFolder(HttpServletRequest req, HttpSession session){
		
		String newfolder = req.getParameter("newfolder");
		String[] idxs = req.getParameterValues("chk_memo"); //선택된 메모 idx들
		String gobackURL = req.getParameter("gobackURL");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("newfolder", newfolder);
		
		int cnt = 0;
		
		for(int i = 0; i<idxs.length; i++){
			int n = 0;
			
			map.put("idxs", idxs[i]);
			n = service.MemoUpdateGroups(map); //메모를 휴지통으로 보내보자
			
			if(n == 1){
				cnt++;
			}
		}
		
		if(cnt == idxs.length){
			String msg = "선택된 메모들의 분류 변경이 완료되었습니다.";
			String loc = gobackURL;
			//"javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		} else {
			String msg = "선택된 메모들의 분류 변경에 실패하였습니다.";
			String loc = gobackURL;
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			return "ksh/msg.not";
		}	
		
	}
	
	
}
