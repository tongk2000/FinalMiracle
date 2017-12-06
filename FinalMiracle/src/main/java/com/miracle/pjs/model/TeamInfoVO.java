package com.miracle.pjs.model;

public class TeamInfoVO {
	private int fk_team_idx;		// 팀번호
	private int fk_member_idx;		// 팀원번호
	private int status;				// 팀원상태
	
	public TeamInfoVO(){}
	public TeamInfoVO(int fk_team_idx, int fk_member_idx, int status) {
		super();
		this.fk_team_idx = fk_team_idx;
		this.fk_member_idx = fk_member_idx;
		this.status = status;
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
	
}
