package com.miracle.ksh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class VoteDAO implements InterVoteDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<HashMap<String, String>> VoteListNoPaging() {
		List<HashMap<String, String>> voteList = sqlsession.selectList("kshVote.VoteListNoPaging");
		return voteList;
	}

	@Override
	public List<VoteItemVO> VoteItemList() {
		List<VoteItemVO> voteItemList = sqlsession.selectList("kshVote.VoteItemList");
		return voteItemList;
	}

	@Override
	public List<HashMap<String, String>> VoteEndListNoPaging() {
		List<HashMap<String, String>> voteEndList = sqlsession.selectList("kshVote.VoteEndListNoPaging");
		return voteEndList;
	}

	@Override
	public int VoteAdd(HashMap<String, String> mapVote) {
		int n = sqlsession.insert("kshVote.VoteAdd", mapVote);
		return n;
	}

	@Override
	public int VoteItemAdd(HashMap<String, Object> mapVoteItem) {
		int n = sqlsession.insert("kshVote.VoteItemAdd", mapVoteItem);
		return n;
	}

	@Override
	public int VoteItemImageAdd(HashMap<String, Object> mapVoteItem) {
		int n = sqlsession.insert("kshVote.VoteItemImageAdd", mapVoteItem);
		return n;
	}

	@Override
	public int VoteLastIdx() {
		int n = sqlsession.selectOne("kshVote.VoteLastIdx");
		return n;
	}

	@Override
	public int VoteNumUpdate(String voteitem_idx) {
		int n = sqlsession.update("kshVote.VoteNumUpdate", voteitem_idx);
		return n;
	}

	@Override
	public int VoteTotalCount1(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteTotalCount1", map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteList = sqlsession.selectList("kshVote.VoteListYesPaging1", map);
		return voteList;
	}

	@Override
	public List<HashMap<String, String>> VoteEndListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteEndList = sqlsession.selectList("kshVote.VoteEndListYesPaging1", map);
		return voteEndList;
	}

	@Override
	public int VoteEndTotalCount1(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteEndTotalCount1", map);
		return n;
	}

	@Override
	public int VotedAdd(HashMap<String, String> mapVoted) {
		int n = sqlsession.insert("kshVote.VotedAdd", mapVoted);
		return n;
	}

	@Override
	public String VotedCheck(HashMap<String, String> mapVotedChk) {		
		String cnt = sqlsession.selectOne("kshVote.VotedCheck", mapVotedChk);
		return cnt;
	}

	@Override
	public List<HashMap<String, String>> VoteListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteList = sqlsession.selectList("kshVote.VoteListYesPaging2", map);
		return voteList;
	}

	@Override
	public int VoteTotalCount2(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteTotalCount2", map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteEndListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteEndList = sqlsession.selectList("kshVote.VoteEndListYesPaging2", map);
		return voteEndList;
	}

	@Override
	public int VoteEndTotalCount2(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteEndTotalCount2", map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteMyListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteMyList = sqlsession.selectList("kshVote.VoteMyListYesPaging1", map);
		return voteMyList;
	}

	@Override
	public List<HashMap<String, String>> VoteMyListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteMyList = sqlsession.selectList("kshVote.VoteMyListYesPaging2", map);
		return voteMyList;
	}

	@Override
	public int VoteDel(String idx) {
		int result = sqlsession.update("kshVote.VoteDel", idx);
		return result;
	}

	@Override
	public VoteVO VoteView(String idx) {
		VoteVO votevo = sqlsession.selectOne("kshVote.VoteView", idx);
		return votevo;
	}

	@Override
	public List<VoteItemVO> VoteItemView(String idx) {
		List<VoteItemVO> voteitemvo = sqlsession.selectList("kshVote.VoteItemView", idx);
		return voteitemvo;
	}

	@Override
	public int VoteItemViewCnt(String idx) {
		int cnt = sqlsession.selectOne("kshVote.VoteItemViewCnt", idx);
		return cnt;
	}

	@Override
	public int VoteEdit(HashMap<String, String> mapVote) {
		int n = sqlsession.update("kshVote.VoteEdit", mapVote);
		return n;
	}

	@Override
	public int VoteItemEdit(HashMap<String, Object> mapVoteItem) {
		int n = sqlsession.update("kshVote.VoteItemEdit", mapVoteItem);
		
		//System.out.println(n);
		
		return n;
	}

	@Override
	public int VoteItemImageEdit(HashMap<String, Object> mapVoteItem) {
		int n = sqlsession.update("kshVote.VoteItemImageEdit", mapVoteItem);
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteReadyListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteReadyList = sqlsession.selectList("kshVote.VoteReadyListYesPaging1", map);
		return voteReadyList;
	}

	@Override
	public List<HashMap<String, String>> VoteReadyListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteReadyList = sqlsession.selectList("kshVote.VoteReadyListYesPaging2", map);
		return voteReadyList;
	}

	@Override
	public int VoteReadyTotalCount1(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteReadyTotalCount1", map);
		return n;
	}

	@Override
	public int VoteReadyTotalCount2(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteReadyTotalCount2", map);
		return n;
	}

	@Override
	public int VoteMyTotalCount1(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteMyTotalCount1", map);
		return n;
	}

	@Override
	public int VoteMyTotalCount2(HashMap<String, String> map) {
		int n = sqlsession.selectOne("kshVote.VoteMyTotalCount2", map);
		return n;
	}

	@Override
	public void VoteItemRestAdd(HashMap<String, Object> mapVoteItem) {
		sqlsession.selectOne("kshVote.VoteItemRestAdd", mapVoteItem);
	}

	@Override
	public void VoteItemRestDel(HashMap<String, Object> mapVoteItem) {
		sqlsession.delete("kshVote.VoteItemRestDel", mapVoteItem);
	}

	@Override
	public int VoteItemMaxRest() {
		int n = sqlsession.selectOne("kshVote.VoteItemMaxRest");
		return n;
	}

	@Override
	public List<VoteItemVO> VoteItemChart(String idx) {
		List<VoteItemVO> list = sqlsession.selectList("kshVote.VoteItemChart", idx);
		return list;
	}

	@Override
	public List<HashMap<String, String>> VoteCommList() {
		List<HashMap<String, String>> voteCommList = sqlsession.selectList("kshVote.VoteCommList");
		return voteCommList;
	}

	@Override
	public int getFk_teamwon_idx(String getidx) {
		int n = sqlsession.selectOne("kshVote.getFk_teamwon_idx", getidx);
		return n;
	}

	@Override
	public int addComment(HashMap<String, String> commMap) {
		int result = sqlsession.insert("kshVote.addComment", commMap);
		return result;
	}

	@Override
	public int DelComment(HashMap<String, String> commMap) {
		int result = sqlsession.insert("kshVote.DelComment", commMap);
		return result;
	}


}
