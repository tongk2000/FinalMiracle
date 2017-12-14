package com.miracle.ksh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemoDAO implements InterMemoDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<HashMap<String, String>> memoList1(HashMap<String, String> memoMap) {
		List<HashMap<String, String>> memoList = sqlsession.selectList("kshMemo.memoList1", memoMap);
		return memoList;
	}
	
	@Override
	public List<HashMap<String, String>> memoList2(HashMap<String, String> memoMap) {
		List<HashMap<String, String>> memoList = sqlsession.selectList("kshMemo.memoList2", memoMap);
		return memoList;
	}

	@Override
	public int MemoTotalCount1(HashMap<String, String> memoMap) {
		int n = sqlsession.selectOne("kshMemo.MemoTotalCount1", memoMap);
		return n;
	}

	@Override
	public int MemoTotalCount2(HashMap<String, String> memoMap) {
		int n = sqlsession.selectOne("kshMemo.MemoTotalCount2", memoMap);
		return n;
	}

	@Override
	public List<String> getfolderList(String fk_member_idx) {
		List<String> folderlist = sqlsession.selectList("kshMemo.getfolderList", fk_member_idx);
		return folderlist;
	}

	@Override
	public int MemoAdd(HashMap<String, String> memoMap) {
		int n = sqlsession.insert("kshMemo.MemoAdd", memoMap);
		return n;
	}

	@Override
	public List<MemoVO> getMemoVO(String idx) {
		List<MemoVO> memovo = sqlsession.selectList("kshMemo.getMemoVO", idx);
		return memovo;
	}

	@Override
	public int MemoEdit(HashMap<String, String> memoMap) {
		int n = sqlsession.update("kshMemo.MemoEdit", memoMap);
		return n;
	}

	@Override
	public int MemoGarbage(String idx) {
		int n = sqlsession.update("kshMemo.MemoGarbage", idx);
		return n;
	}

	@Override
	public int MemoRestore(String idx) {
		int n = sqlsession.update("kshMemo.MemoRestore", idx);
		return n;
	}

	@Override
	public int MemoDel(String idx) {
		int n = sqlsession.delete("kshMemo.MemoDel", idx);
		return n;
	}

	@Override
	public int MemoGarbage(HashMap<String, String> map) {
		int n = sqlsession.update("kshMemo.MemoGarbages", map);
		return n;
	}

	@Override
	public int MemoRestore(HashMap<String, String> map) {
		int n = sqlsession.update("kshMemo.MemoRestores", map);
		return n;
	}

	@Override
	public int MemoDel(HashMap<String, String> map) {
		int n = sqlsession.delete("kshMemo.MemoDels", map);
		return n;
	}
	
}
