package com.miracle.psw.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.psw.model.FaqBoardVO;
import com.miracle.psw.model.FreeBoardVO;
import com.miracle.psw.model.InterBoardDAO;

@Service
public class BoardService implements InterBoardService {

	@Autowired
	private InterBoardDAO dao;

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

	@Override
	public List<FreeBoardVO> freeList() {
		List<FreeBoardVO> vo = dao.freeList();
		return vo;
	}

	@Override
	public int freeAdd(FreeBoardVO freevo) {  // 자유게시판 글쓰기
		int n = dao.freeAdd(freevo);
		return n;
	}

	@Override
	public FreeBoardVO getView(String idx, String userid) {  // 자유게시판 클릭한 게시글 1개 보여주기
		FreeBoardVO vo = dao.getView(idx);
		
		if(userid != null && !vo.getUserid().equals(userid)) {
			dao.setAddReadCnt(idx);
			vo = dao.getView(idx);
		}
		return vo;
	}

	
	
}
