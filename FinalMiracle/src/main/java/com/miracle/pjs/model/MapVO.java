package com.miracle.pjs.model;

public class MapVO {
	private int idx;	            	  	// 기본키
	private double latitude;	   		   	// 위도
	private double longitude;	  		 	// 경도
	private int team_idx;	  	 		 	// 왜래키(팀테이블 참조, 팀 테이블의 조장값 하나)
	private String name;				 	// 위치이름
	public MapVO(){}
	public MapVO(int idx, double latitude, double longitude, int team_idx, String name) {
		super();
		this.idx = idx;
		this.latitude = latitude;
		this.longitude = longitude;
		this.team_idx = team_idx;
		this.name = name;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public int getTeam_idx() {
		return team_idx;
	}
	public void setTeam_idx(int team_idx) {
		this.team_idx = team_idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
