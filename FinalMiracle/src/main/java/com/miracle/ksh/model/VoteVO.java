package com.miracle.ksh.model;

public class VoteVO {
	
	private int idx;
	private int fk_teamwon_idx;
	private String subject;
	private String content;
	private String startdate;
	private String enddate;
	private int status; //상태값
	
	public VoteVO() {	}

	public VoteVO(int idx, int fk_teamwon_idx, String subject, String content, String startdate, String enddate,
			int status) {
		super();
		this.idx = idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		this.subject = subject;
		this.content = content;
		this.startdate = startdate;
		this.enddate = enddate;
		this.status = status;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getFk_teamwon_idx() {
		return fk_teamwon_idx;
	}

	public void setFk_teamwon_idx(int fk_teamwon_idx) {
		this.fk_teamwon_idx = fk_teamwon_idx;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
