package com.miracle.ksh.model;

public class VoteCommVO {
	
	private int idx;
	private int fk_vote_idx;
	private int fk_teamwon_idx;
	private String Content;
	private int status; //상태값 0-삭제됨 1-존재함
	
	
	public VoteCommVO() {	}


	public VoteCommVO(int idx, int fk_vote_idx, int fk_teamwon_idx, String content, int status) {
		this.idx = idx;
		this.fk_vote_idx = fk_vote_idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		Content = content;
		this.status = status;
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


	public int getFk_teamwon_idx() {
		return fk_teamwon_idx;
	}


	public void setFk_teamwon_idx(int fk_teamwon_idx) {
		this.fk_teamwon_idx = fk_teamwon_idx;
	}


	public String getContent() {
		return Content;
	}


	public void setContent(String content) {
		Content = content;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
	

}
