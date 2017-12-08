package com.miracle.ksh.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.miracle.ksh.model.InterVoteDAO;
import com.miracle.ksh.model.VoteCommVO;
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
	public int VoteTotalCount1(HashMap<String, String> map) {
		int n = dao.VoteTotalCount1(map);
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
	public int VoteEndTotalCount1(HashMap<String, String> map) {
		int n = dao.VoteEndTotalCount1(map);
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
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})  
	public int VoteItemEdit(HashMap<String, Object> mapVoteItem, String[] items, String[] itemidx) {
		
		int n = 0;
	    int m = 0;
	    int count = 0;

	    /*for(int i=0; i<items.length; i++){
			System.out.println(items[i] + i);
		}*/
	    
	    //System.out.println(itemidx.length - items.length);
	    
	    if (items.length > itemidx.length){ //입력한 문항 수 > 테이블에 있는 문항 수
	    	List<Object> restArray = new ArrayList<Object>();
	    	int rest = 0;	
	    	int gap = items.length - itemidx.length;
	    	
	    	for(int i=0; i<items.length - itemidx.length; i++){
	    		//System.out.println(items[i] + i);
	    		dao.VoteItemRestAdd(mapVoteItem);
	    		rest = dao.VoteItemMaxRest();
	    		restArray.add(rest);
	    	}
	    	
	    	for(int i=0; i<items.length; i++){
	    		
	    		if(i < gap){
	    			mapVoteItem.put("items", items[i]);
		    		mapVoteItem.put("itemidx", itemidx[i]);
		    		restArray.add(rest);
		    		//System.out.println(items[i] + "-" + i + " / " + itemidx[i] + "-" + i);
		    		m = dao.VoteItemEdit(mapVoteItem);
	    		} else {
	    			int j = 0;
	    			
	    			mapVoteItem.put("items", items[i]);
	    			mapVoteItem.put("itemidx", restArray.get(j));
	    			
	    			j++;
	    			
	    			m = dao.VoteItemEdit(mapVoteItem);
	    		}
	    		if(m==1) count++;
	    	}
	    	
	    	if(items.length == count) {
			    n=1;
		    }
		    else {
		 	   n=0;
		    }
	    	
	    } else if(items.length < itemidx.length){ //입력한 문항 수 < 테이블에 있는 문항 수
	    	
	    	for(int i=0; i<itemidx.length - items.length; i++){
	    		//System.out.println(itemidx.length - items.length);
	    		mapVoteItem.put("items", items[i]);
	    		mapVoteItem.put("itemidx", itemidx[i]);
	    		//System.out.println(items[i] + "-" + i + " / " + itemidx[i] + "-" + i);
	    		m = dao.VoteItemEdit(mapVoteItem);
	    		
	    		if(m==1) count++;
	    	}
	    	
	    	for(int i = items.length; i < itemidx.length; i++){
	    		mapVoteItem.put("itemidx", itemidx[i]);
	    		dao.VoteItemRestDel(mapVoteItem);
	    	}
	    	
	    	if(itemidx.length - items.length == count) {
			   n=1;
		    }
		    else {
		 	   n=0;
		    }
	    	
	    } else{ //입력한 문항 수 == 테이블에 있는 문항 수
	    	
	    	for(int i=0; i<items.length; i++){
	    		mapVoteItem.put("items", items[i]);
	    		mapVoteItem.put("itemidx", itemidx[i]);
	    		//System.out.println(items[i] + "-" + i + " / " + itemidx[i] + "-" + i);
	    		m = dao.VoteItemEdit(mapVoteItem);
	    		
	    		if(m==1) count++;
	    	}
	    	
	    	if(items.length == count) {
			    n=1;
		    }
		    else {
		 	   n=0;
		    }
	    	
	    }
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
	public int VoteReadyTotalCount1(HashMap<String, String> map) {
		int n = dao.VoteReadyTotalCount1(map);
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

	@Override
	public List<VoteItemVO> VoteItemChart(String idx) {
		List<VoteItemVO> list = dao.VoteItemChart(idx);
		return list;
	}

	@Override
	public List<HashMap<String, String>> VoteCommList(HashMap<String, String> map) {
		List<HashMap<String, String>> voteCommList = dao.VoteCommList(map);
		return voteCommList;
	}

	@Override
	public int getFk_teamwon_idx(String getidx) {
		int n = dao.getFk_teamwon_idx(getidx);
		return n;
	}

	@Override
	public int addComment(HashMap<String, String> commMap) {
		int result = dao.addComment(commMap);
		return result;
	}

	@Override
	public int DelComment(HashMap<String, String> commMap) {
		int result = dao.DelComment(commMap);
		return result;
	}

	
}
