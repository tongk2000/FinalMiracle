package com.miracle.pjs.model;

public class NoticeVO {
	
	private int idx;							// 기본키
	private String fk_userid;					// 유저아이디
	private String pwd; 						// 공지사항 글의 비번
	private String subject; 					// 공지사항 제목
	private String content;		       			// 공지사항 내용
	private String regday;		        		// 공지사항 올린 일자
	private int readCount;		    			// 조회수
	private int depth;               			// 답글의 깊이 
	private int groupno;            			// 답변글의 소속글을 나타냄           -- 자바에서 자동으로 1추가되도록 한다.
	private int ref_idx;              			// 원글의 idx를 나타낸다.
	private int status;		          			// 상태값(삭제:0, 게시:1)
	private int commentCount;   				// 댓글수
	public NoticeVO(){}
	public NoticeVO(int idx, String fk_userid, String pwd, String subject, String content, String regday, int readCount,
			int depth, int groupno, int ref_idx, int status, int commentCount) {
		super();
		this.idx = idx;
		this.fk_userid = fk_userid;
		this.pwd = pwd;
		this.subject = subject;
		this.content = content;
		this.regday = regday;
		this.readCount = readCount;
		this.depth = depth;
		this.groupno = groupno;
		this.ref_idx = ref_idx;
		this.status = status;
		this.commentCount = commentCount;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegday() {
		return regday;
	}
	public void setRegday(String regday) {
		this.regday = regday;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getGroupno() {
		return groupno;
	}
	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}
	public int getRef_idx() {
		return ref_idx;
	}
	public void setRef_idx(int ref_idx) {
		this.ref_idx = ref_idx;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	
}
