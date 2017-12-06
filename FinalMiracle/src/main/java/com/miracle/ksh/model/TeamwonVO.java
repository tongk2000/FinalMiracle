package com.miracle.ksh.model;

public class TeamwonVO {
	
	private int idx;
	private int fk_team_idx;
	private int fk_member_idx;
	private int status;
	private String regdate;
	private String disdate;
	
	public TeamwonVO() {}

	public TeamwonVO(int idx, int fk_team_idx, int fk_member_idx, int status, String regdate, String disdate) {
		super();
		this.idx = idx;
		this.fk_team_idx = fk_team_idx;
		this.fk_member_idx = fk_member_idx;
		this.status = status;
		this.regdate = regdate;
		this.disdate = disdate;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getFk_team_idx() {
		return fk_team_idx;
	}

	public void setFk_team_idx(int fk_team_idx) {
		this.fk_team_idx = fk_team_idx;
	}

	public int getFk_member_idx() {
		return fk_member_idx;
	}

	public void setFk_member_idx(int fk_member_idx) {
		this.fk_member_idx = fk_member_idx;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getDisdate() {
		return disdate;
	}

	public void setDisdate(String disdate) {
		this.disdate = disdate;
	}
	
	
	
}
