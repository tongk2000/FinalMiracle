package com.miracle.ksh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.ksh.model.InterVoteDAO;
import com.miracle.ksh.model.VoteItemVO;
import com.miracle.ksh.model.VoteVO;

@Service
public class VoteService implements InterVoteService {

	
	@Autowired
	private InterVoteDAO dao;
	
	@Override
	public List<HashMap<String, String>> VoteListNoPaging() {
		List<HashMap<String, String>> voteList = dao.VoteListNoPaging();
		return voteList;
	}

	@Override
	public List<VoteItemVO> VoteItemList() {
		List<VoteItemVO> voteItemList = dao.VoteItemList();
		return voteItemList;
	}

	@Override
	public List<HashMap<String, String>> VoteEndListNoPaging() {
		List<HashMap<String, String>> voteEndList = dao.VoteEndListNoPaging();
		return voteEndList;
	}

	@Override
	public int VoteAdd(HashMap<String, String> mapVote) {
		int n = dao.VoteAdd(mapVote);
		return n;
	}

	@Override
	public int VoteItemAdd(HashMap<String, Object> mapVoteItem) {
		int n = dao.VoteItemAdd(mapVoteItem);
		return n;
	}

	@Override
	public int VoteItemImageAdd(HashMap<String, Object> mapVoteItem) {
		int n = dao.VoteItemImageAdd(mapVoteItem);
		return n;
	}

	@Override
	public int VoteLastIdx() {
		int n = dao.VoteLastIdx();
		return n;
	}

	@Override
	public int VoteNumUpdate(String voteitem_idx) {
		int n = dao.VoteNumUpdate(voteitem_idx);
		return n;
	}

	@Override
	public int VoteTotalCount1() {
		int n = dao.VoteTotalCount1();
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteList = dao.VoteListYesPaging1(map);
		return voteList;
	}

	@Override
	public List<HashMap<String, String>> VoteEndListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteEndList = dao.VoteEndListYesPaging1(map);
		return voteEndList;
	}

	@Override
	public int VoteEndTotalCount1() {
		int n = dao.VoteEndTotalCount1();
		return n;
	}

	@Override
	public int VotedAdd(HashMap<String, String> mapVoted) {
		int n = dao.VotedAdd(mapVoted);
		return n;
	}

	@Override
	public String VotedCheck(HashMap<String, String> mapVotedChk) {
		String cnt = dao.VotedCheck(mapVotedChk);
		return cnt;
	}

	@Override
	public List<HashMap<String, String>> VoteListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteList = dao.VoteListYesPaging2(map);
		return voteList;
	}

	@Override
	public int VoteTotalCount2(HashMap<String, String> map) {
		int n = dao.VoteTotalCount2(map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteEndListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteEndList = dao.VoteEndListYesPaging2(map);
		return voteEndList;
	}

	@Override
	public int VoteEndTotalCount2(HashMap<String, String> map) {
		int n = dao.VoteEndTotalCount2(map);
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteMyListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteMyList = dao.VoteMyListYesPaging1(map);
		return voteMyList;
	}

	@Override
	public List<HashMap<String, String>> VoteMyListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteMyList = dao.VoteMyListYesPaging2(map);
		return voteMyList;
	}

	@Override
	public int VoteDel(String idx) {
		int result = dao.VoteDel(idx);
		return result;
	}

	@Override
	public VoteVO VoteView(String idx) {
		VoteVO votevo = dao.VoteView(idx);
		return votevo;
	}

	@Override
	public List<VoteItemVO> VoteItemView(String idx) {
		List<VoteItemVO> voteitemvo = dao.VoteItemView(idx);
		return voteitemvo;
	}

	@Override
	public int VoteItemViewCnt(String idx) {
		int cnt = dao.VoteItemViewCnt(idx);
		return cnt;
	}

	@Override
	public int VoteEdit(HashMap<String, String> mapVote) {
		int n = dao.VoteEdit(mapVote);
		return n;
	}

	@Override
	public int VoteItemEdit(HashMap<String, Object> mapVoteItem) {
		int n = dao.VoteItemEdit(mapVoteItem);
		return n;
	}

	@Override
	public int VoteItemImageEdit(HashMap<String, Object> mapVoteItem) {
		int n = dao.VoteItemImageEdit(mapVoteItem);
		return n;
	}

	@Override
	public List<HashMap<String, String>> VoteReadyListYesPaging1(HashMap<String, String> map) {
		List<HashMap<String, String>> voteReadyList = dao.VoteReadyListYesPaging1(map);
		return voteReadyList;
	}

	@Override
	public List<HashMap<String, String>> VoteReadyListYesPaging2(HashMap<String, String> map) {
		List<HashMap<String, String>> voteReadyList = dao.VoteReadyListYesPaging2(map);
		return voteReadyList;
	}

	@Override
	public int VoteReadyTotalCount1() {
		int n = dao.VoteReadyTotalCount1();
		return n;
	}

	@Override
	public int VoteReadyTotalCount2(HashMap<String, String> map) {
		int n = dao.VoteReadyTotalCount2(map);
		return n;
	}

	@Override
	public int VoteMyTotalCount1(HashMap<String, String> map) {
		int n = dao.VoteMyTotalCount1(map);
		return n;
	}

	@Override
	public int VoteMyTotalCount2(HashMap<String, String> map) {
		int n = dao.VoteMyTotalCount2(map);
		return n;
	}

	@Override
	public void VoteItemRestAdd(HashMap<String, Object> mapVoteItem) {
		dao.VoteItemRestAdd(mapVoteItem);
	}

	@Override
	public void VoteItemRestDel(HashMap<String, Object> mapVoteItem) {
		dao.VoteItemRestDel(mapVoteItem);
	}

	@Override
	public int VoteItemMaxRest() {
		int n = dao.VoteItemMaxRest();
		return n;
	}

	
}
