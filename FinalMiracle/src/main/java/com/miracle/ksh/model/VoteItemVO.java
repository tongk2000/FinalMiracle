package com.miracle.ksh.model;

public class VoteItemVO {
	
	private int idx;
	private int fk_vote_idx;
	private String item;
	private int votenum;
	
	
	public VoteItemVO() {	}


	public VoteItemVO(int idx, int fk_vote_idx, String item, int votenum) {
		super();
		this.idx = idx;
		this.fk_vote_idx = fk_vote_idx;
		this.item = item;
		this.votenum = votenum;
	}


	public int getIdx() {
		return idx;
	}


	public void setIdx(int idx) {
		this.idx = idx;
	}


	public int getFk_vote_idx() {
		return fk_vote_idx;
	}


	public void setFk_vote_idx(int fk_vote_idx) {
		this.fk_vote_idx = fk_vote_idx;
	}


	public String getItem() {
		return item;
	}


	public void setItem(String item) {
		this.item = item;
	}


	public int getVotenum() {
		return votenum;
	}


	public void setVotenum(int votenum) {
		this.votenum = votenum;
	}

	
	

}
