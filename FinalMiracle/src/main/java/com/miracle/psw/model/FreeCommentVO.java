package com.miracle.psw.model;

public class FreeCommentVO {

	private int idx;              // 댓글번호
	private String userid;        // 사용자ID
	private String content;    	  // 댓글내용
	private String regDate;    	  // 작성일자
	private int parentIdx;    	  // 원게시물 글번호
	private int status;           // 글삭제여부 1 : 사용가능한 글,  0 : 삭제된 글
	                              // 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
	private int groupno;
	private int depthno;
	private int orderno;
	
	public int getGroupno() {
		return groupno;
	}

	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}

	public int getDepthno() {
		return depthno;
	}

	public void setDepthno(int depthno) {
		this.depthno = depthno;
	}

	public int getOrderno() {
		return orderno;
	}

	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}

	private String name;
	private String img;
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public FreeCommentVO() { }
	
	public FreeCommentVO(int idx, String userid, String content, String regDate, int parentIdx, int status
						,int groupno, int depthno, int orderno) {
		
		this.idx = idx;
		this.userid = userid;
		this.content = content;
		this.regDate = regDate;
		this.parentIdx = parentIdx;
		this.status = status;
		this.groupno = groupno;
		this.depthno = depthno;
		this.orderno = orderno;
	}

	
	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getParentIdx() {
		return parentIdx;
	}

	public void setParentIdx(int parentIdx) {
		this.parentIdx = parentIdx;
	}

	public int getStatus() {
		return status;
	}
	
	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
	
	
}
