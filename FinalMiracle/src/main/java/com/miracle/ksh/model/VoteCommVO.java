package com.miracle.ksh.model;

public class VoteCommVO {
	
	private int idx;
	private int fk_vote_idx;
	private int fk_teamwon_idx;
	private String content;
	private int status; //상태값 0-삭제됨 1-존재함
	private String commdate;
	
	
	public VoteCommVO() {	}


	public VoteCommVO(int idx, int fk_vote_idx, int fk_teamwon_idx, String content, int status, String commdate) {
		super();
		this.idx = idx;
		this.fk_vote_idx = fk_vote_idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		this.content = content;
		this.status = status;
		this.commdate = commdate;
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
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public String getCommdate() {
		return commdate;
	}


	public void setCommdate(String commdate) {
		this.commdate = commdate;
	}
	
	
	
	
}
