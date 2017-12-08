package com.miracle.jsw.model;

public class Chat_roomVO {
	
	private int cr_idx;  // 채팅방 번호
	private int fk_member_idx;  // fk_회원번호
	private String roomname;  // 채팅방이름 
	private int person;  // 인원
	private int cr_status;  // 0.삭제 1.정상
	
	public int getCr_idx() {
		return cr_idx;
	}
	public void setCr_idx(int cr_idx) {
		this.cr_idx = cr_idx;
	}
	public int getFk_member_idx() {
		return fk_member_idx;
	}
	public void setFk_member_idx(int fk_member_idx) {
		this.fk_member_idx = fk_member_idx;
	}
	public String getRoomname() {
		return roomname;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	public int getPerson() {
		return person;
	}
	public void setPerson(int person) {
		this.person = person;
	}
	public int getCr_status() {
		return cr_status;
	}
	public void setCr_status(int cr_status) {
		this.cr_status = cr_status;
	}
	
	public Chat_roomVO(){}
	
	public Chat_roomVO(int cr_idx, int fk_member_idx, String roomname, int person, int cr_status) {
		super();
		this.cr_idx = cr_idx;
		this.fk_member_idx = fk_member_idx;
		this.roomname = roomname;
		this.person = person;
		this.cr_status = cr_status;
	}
}
