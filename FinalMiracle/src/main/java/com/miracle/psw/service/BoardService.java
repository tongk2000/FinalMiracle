package com.miracle.psw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.model.FreeBoardVO;
import com.miracle.psw.model.FreeCommentVO;
import com.miracle.psw.model.InterBoardDAO;
import com.miracle.psw.model.MemberDetailVO;
import com.miracle.psw.model.MemberVO;

@Service
public class BoardService implements InterBoardService {

	@Autowired
	private InterBoardDAO dao;
	
	//////////////////////////////////////////////////////////////////// FAQ 게시판 ////////////////////////////////////////////////
	// ====================================================== *** FAQ 게시판 *** ===================================================
	@Override
	public List<FaqBoardVO> faqList() {
		List<FaqBoardVO> list = dao.faqList();
		return list;
	}

	@Override
	public List<FaqBoardVO> faqListWithSearch(HashMap<String, String> map) {
		List<FaqBoardVO> vo = dao.faqListWithSearch(map);
		return vo;
	}
	@Override
	public List<FaqBoardVO> faqListWithNoSearch(HashMap<String, String> map) {
		List<FaqBoardVO> vo = dao.faqListWithNoSearch(map);
		return vo;
	}

	@Override
	public int getTotalCountWithSearch(HashMap<String, String> map) {
		int cnt = dao.getTotalCountWithSearch(map);
		return cnt;
	}
	@Override
	public int getTotalCountWithNoSearch(HashMap<String, String> map) {
		int cnt = dao.getTotalCountWithNoSearch(map);
		return cnt;
	}

	@Override
	public int add(FaqBoardVO faqvo) {  // FAQ 게시판 글쓰기
		int n = dao.add(faqvo);
		return n;
	}
	
	//////////////////////////////////////////////////////////////////////////////////// 자유게시판 //////////////////////////////////
	// ====================================================== *** 자유게시판 *** =====================================================
	@Override
	public List<FreeBoardVO> freeList() {
		List<FreeBoardVO> vo = dao.freeList();
		return vo;
	}

	@Override
	public int freeAdd(FreeBoardVO freevo) {  // 자유게시판 글쓰기
		/* ======= 글쓰기가 원글인지 답글인지 구분하여 tbl_free 에 insert
		 * 원글 : tbl_free groupno컬럼 값 max + 1
		 * 답변글 : 넘겨받은 groupno컬럼 값 그대로 insert 
		 */
		if(freevo.getFk_idx().equals("") || freevo.getFk_idx().trim().isEmpty()) {  // 원글 쓰기인 경우
			int groupno = dao.getGroupMaxno() + 1;
			freevo.setGroupno(String.valueOf(groupno));
		}
		int n = dao.freeAdd(freevo);  // 답변글 쓰기인 경우
		return n;
	}

	// ======================= *** 자유게시판 선택한 1개 글 내용 보여주기 (조회수 증가 후 보여주기 / 조회수 증가 없이 보여주기) *** =============
	@Override
	public FreeBoardVO getView(String idx, String userid) {  // 자유게시판 클릭한 게시글 1개 보여주기(조회수 증가 후)
		FreeBoardVO vo = dao.getView(idx);  // 자유게시판 글 보여주기 
	
		if(userid != null && !vo.getUserid().equals(userid)) {
			dao.setAddReadCnt(idx); // 자유게시판 글(readCnt) 조회수 1 증가시키기
			vo = dao.getView(idx);
		}
		return vo;		
	}

	
	// ========================= *** 자유게시판 글 조회수(readCnt) 증가 없이 보여주기 *** =====================
	@Override
	public FreeBoardVO getViewWithNoReadCnt(String idx) {  // 자유게시판 글 조회수(readCnt) 증가 없이 보여주기
		FreeBoardVO vo = dao.getView(idx);
		return vo;
	}


	// ===================== *** 자유게시판 검색 유/무에 따른 목록 보여주기 *** ==================================================
	@Override
	public List<FreeBoardVO> freeListWithNoSearch(HashMap<String, String> map) {
		List<FreeBoardVO> vo = dao.freeListWithNoSearch(map);
		return vo;
	}
	@Override
	public List<FreeBoardVO> freeListWithSearch(HashMap<String, String> map) {
		List<FreeBoardVO> vo = dao.freeListWithSearch(map);
		return vo;
	}

	// ============================= *** 자유게시판 검색 유/무에 따른 총 페이지 값 알아오기 *** =====================================
	@Override
	public int getFreeTotalCountWithSearch(HashMap<String, String> map) {
		int cnt = dao.getFreeTotalCountWithSearch(map);
		return cnt;
	}
	@Override
	public int getFreeTotalCountWithNoSearch(HashMap<String, String> map) {
		int cnt = dao.getFreeTotalCountWithNoSearch(map);
		return cnt;
	}

	// ============================= *** 자유게시판 글 수정하기 *** ========================================================
	@Override
	public int freeEdit(HashMap<String, Object> map) {  // 1개 글 수정하기
		int n = dao.freeEdit(map);
		return n;
	}

	/* ========================================= *** 자유게시판 선택한 조회글에서 댓글쓰기 (Transaction) *** =====================
	   1. tbl_freeComment 테이블에 insert 된 다음에
	   2. tbl_freeComment 테이블에 commentCnt 컬럼의 값이 1증가(update) 하도록 요청한다.
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int addComment(FreeCommentVO commentvo) throws Throwable {  // 1개 글 조회된 페이지에서 해당 게시글에 댓글 달기
		int result = 0;
		int n = 0;
		n = dao.addComment(commentvo);
		
		if(n==1) {
			result = dao.updateCommentCnt(commentvo.getParentIdx());
		}
		return result;
	}

	// =========================================== *** 자유게시판 선택한 조회글에서 댓글 목록 보여주기 *** ============================
	@Override
	public List<FreeCommentVO> freeListComment(String idx) {  // 자유게시판 댓글 목록 불러오기  
		List<FreeCommentVO> list = dao.freeListComment(idx);
		return list;
	}

	// =========================================== *** 자유게시판 목록에서 선택한 사용자 정보 보여주기 *** ======================
	@Override
	public MemberVO showUserInfo(HashMap<String, Object> map) {
		MemberVO vo = dao.showUserInfo(map);
		return vo;
	}
	@Override
	public MemberDetailVO showUserDetailInfo(HashMap<String, Object> map) {
		MemberDetailVO vo = dao.showUserDetailInfo(map);
		return vo;
	}

	// =========================================== *** 자유게시판 해당글 1개 삭제하기(Transaction) *** ================================
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@Override
	public int delFree(String idx) throws Throwable {
		int count = 0;
		int result1 = 0;
		int result2 = 0;
		
		int n = 0;
		
		count = dao.isExistComment(idx); // 해당글의 댓글 유무 확인하기
		result1 = dao.deleteContent(idx);  // 해당글 1개 삭제하기
		
		if(count > 0){
			result2 = dao.deleteComment(idx);  // 댓글이 존재하면 해당글의 댓글 삭제하기
		}
		
		if( (result1 > 0 && (count>0 && result2>0)) || (result1 > 0 && count == 0) ) {  //  게시글 1개 삭제(덧글 있는 경우 Or 덧글 없는 경우)
			n = 1;
		}
		
		return n;
	}





	
	
	
	
	

	
	
}
