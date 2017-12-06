package com.miracle.kdh.model;

public class TeamInfoVO {
	private String team_idx;
	private String teamwon_idx;
	private String teamwon_status;
	
	public TeamInfoVO(){}
	public TeamInfoVO(String team_idx, String teamwon_idx, String teamwon_status) {
		super();
		this.team_idx = team_idx;
		this.teamwon_idx = teamwon_idx;
		this.teamwon_status = teamwon_status;
	}
	public String getTeam_idx() {
		return team_idx;
	}
	public void setTeam_idx(String team_idx) {
		this.team_idx = team_idx;
	}
	public String getTeamwon_idx() {
		return teamwon_idx;
	}
	public void setTeamwon_idx(String teamwon_idx) {
		this.teamwon_idx = teamwon_idx;
	}
	public String getTeamwon_status() {
		return teamwon_status;
	}
	public void setTeamwon_status(String teamwon_status) {
		this.teamwon_status = teamwon_status;
	}
	
	
}
