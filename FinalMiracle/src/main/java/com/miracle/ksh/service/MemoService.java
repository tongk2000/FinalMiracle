package com.miracle.ksh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.ksh.model.InterMemoDAO;
import com.miracle.ksh.model.MemoVO;

@Service
public class MemoService implements InterMemoService {

	@Autowired
	private InterMemoDAO dao;

	@Override
	public List<HashMap<String, String>> memoList1(HashMap<String, String> memoMap) {
		List<HashMap<String, String>> memoList = dao.memoList1(memoMap);
		return memoList;
	}
	
	@Override
	public List<HashMap<String, String>> memoList2(HashMap<String, String> memoMap) {
		List<HashMap<String, String>> memoList = dao.memoList2(memoMap);
		return memoList;
	}

	@Override
	public int MemoTotalCount1(HashMap<String, String> memoMap) {
		int n = dao.MemoTotalCount1(memoMap);
		return n;
	}

	@Override
	public int MemoTotalCount2(HashMap<String, String> memoMap) {
		int n = dao.MemoTotalCount2(memoMap);
		return n;
	}

	@Override
	public List<String> getfolderList() {
		List<String> folderList = dao.getfolderList();
		return folderList;
	}

	@Override
	public int MemoAdd(HashMap<String, String> memoMap) {
		int n = dao.MemoAdd(memoMap);
		return n;
	}

	@Override
	public List<MemoVO> getMemoVO(String idx) {
		List<MemoVO> memovo = dao.getMemoVO(idx);
		return memovo;
	}

	@Override
	public int MemoEdit(HashMap<String, String> memoMap) {
		int n = dao.MemoEdit(memoMap);
		return n;
	}

	@Override
	public int MemoGarbage(String idx) {
		int n = dao.MemoGarbage(idx);
		return n;
	}

	@Override
	public int MemoRestore(String idx) {
		int n = dao.MemoRestore(idx);
		return n;
	}

	@Override
	public int MemoDel(String idx) {
		int n = dao.MemoDel(idx);
		return n;
	}
	
}