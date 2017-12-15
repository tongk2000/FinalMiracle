package com.miracle.pjs.model;

public class ReplyVO {
	private int idx;                    // 소속된 글의 idx	(tbl_notice)
	private String reply_content;  		// 댓글의 내용
	private int ref_idx;              	// 댓글의 소속
	private int reply_dep;		      	// 댓글의 깊이(0:댓글, 1:댓글의 댓글, 2:댓글의 댓글의 댓글)
	private int reply_group;		  	// 어느 글에 소속되어 있는 지
	private String regday;              // 댓글 작성일자
	private String sesid;				// 아이디
	private String img;					// 이미지
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSesid() {
		return sesid;
	}
	public void setSesid(String sesid) {
		this.sesid = sesid;
	}
	public ReplyVO(){}
	public ReplyVO(int idx, String reply_content, int ref_idx, int reply_dep, int reply_group, String regday) {
		super();
		this.idx = idx;
		this.reply_content = reply_content;
		this.ref_idx = ref_idx;
		this.reply_dep = reply_dep;
		this.reply_group = reply_group;
		this.regday = regday;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public int getRef_idx() {
		return ref_idx;
	}
	public void setRef_idx(int ref_idx) {
		this.ref_idx = ref_idx;
	}
	public int getReply_dep() {
		return reply_dep;
	}
	public void setReply_dep(int reply_dep) {
		this.reply_dep = reply_dep;
	}
	public int getReply_group() {
		return reply_group;
	}
	public void setReply_group(int reply_group) {
		this.reply_group = reply_group;
	}
	public String getRegday() {
		return regday;
	}
	public void setRegday(String regday) {
		this.regday = regday;
	}
	
}
