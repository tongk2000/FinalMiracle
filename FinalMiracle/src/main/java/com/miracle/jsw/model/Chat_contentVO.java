package com.miracle.jsw.model;

public class Chat_contentVO {

	private int cc_idx; // 채팅 내용 번호
	private int fk_cr_idx; // fk_채팅방번호
	private int fk_member_idx; // fk_회원번호
	private String message; // 메시지
	private String time; // 메세지 입력시간
	private int readcount; // 읽은 사람수
	private String filename; // 서버 저장 파일명
	private String realfilename; // 실제파일명
	private String filesize; // 파일크기
	
	public int getCc_idx() {
		return cc_idx;
	}
	public void setCc_idx(int cc_idx) {
		this.cc_idx = cc_idx;
	}
	public int getFk_cr_idx() {
		return fk_cr_idx;
	}
	public void setFk_cr_idx(int fk_cr_idx) {
		this.fk_cr_idx = fk_cr_idx;
	}
	public int getFk_member_idx() {
		return fk_member_idx;
	}
	public void setFk_member_idx(int fk_member_idx) {
		this.fk_member_idx = fk_member_idx;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getRealfilename() {
		return realfilename;
	}
	public void setRealfilename(String realfilename) {
		this.realfilename = realfilename;
	}
	public String getFilesize() {
		return filesize;
	}
	public void setFilesize(String filesize) {
		this.filesize = filesize;
	}
	
	public Chat_contentVO(){}
	public Chat_contentVO(int cc_idx, int fk_cr_idx, int fk_member_idx, String message, String time, int readcount,
			String filename, String realfilename, String filesize) {
		super();
		this.cc_idx = cc_idx;
		this.fk_cr_idx = fk_cr_idx;
		this.fk_member_idx = fk_member_idx;
		this.message = message;
		this.time = time;
		this.readcount = readcount;
		this.filename = filename;
		this.realfilename = realfilename;
		this.filesize = filesize;
	}
}
