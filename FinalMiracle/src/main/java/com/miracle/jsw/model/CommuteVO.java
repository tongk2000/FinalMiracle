package com.miracle.jsw.model;

public class CommuteVO {

	
	private int wt_idx;  		// 출퇴근 번호
	private String wt_date;  	// 일자
	private int fk_member_idx;	// fk_회원번호
	private String stime;  		// 출근시간
	private String etime;  		// 퇴근시간
	private int status;  		// 0.출근전 1.출근체크 2.퇴근체크
	private int wstatus;  		// 0.정상 1.지각 2.조퇴 3.결근 4.지각,조퇴
	
	
	
	
	
}
