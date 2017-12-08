package com.miracle.jsw.model;

public class Chat_memberVO {

	private int cm_idx; // 채팅원 번호
	private int fk_cr_idx; // fk_채팅방번호
	private int fk_member_idx; // fk_회원번호
	private int notreadmessage; // 안읽은 메시지 수
	private int cm_status; // 0.방에서 나감 1.정상 
	
	
	public int getCm_idx() {
		return cm_idx;
	}
	public void setCm_idx(int cm_idx) {
		this.cm_idx = cm_idx;
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
	public int getNotreadmessage() {
		return notreadmessage;
	}
	public void setNotreadmessage(int notreadmessage) {
		this.notreadmessage = notreadmessage;
	}
	public int getCm_status() {
		return cm_status;
	}
	public void setCm_status(int cm_status) {
		this.cm_status = cm_status;
	}
	
	public Chat_memberVO(){}
	public Chat_memberVO(int cm_idx, int fk_cr_idx, int fk_member_idx, int notreadmessage, int cm_status) {
		super();
		this.cm_idx = cm_idx;
		this.fk_cr_idx = fk_cr_idx;
		this.fk_member_idx = fk_member_idx;
		this.notreadmessage = notreadmessage;
		this.cm_status = cm_status;
	}
	
	
}
