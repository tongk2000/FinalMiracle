package com.miracle.psw.model;

public class FreeBoardVO {

	private int idx;                // 글번호
	private String userid;          // 사용자ID
	private String name;            // 글쓴이
	private String subject;         // 글제목
	private String content;         // 글내용    -- clob
	private int readCnt;            // 글조회수
	private int commentCnt;    		// 댓글수
	private int groupno;            // 답변글쓰기에 있어서 그룹번호 원글(부모글)과 답변글은 동일한 groupno 를 가진다. 
	                                // 답변글이 아닌 원글(부모글)인 경우 groupno 의 값은 groupno 컬럼의 최대값(max)+1 로 한다.                                                
	private int fk_idx;        		// fk_idx 컬럼은 절대로 foreign key가 아니다.fk_idx 컬럼은 자신의 글(답변글)에 있어서 원글(부모글)이 누구인지에 대한 정보값이다.
	                                // 답변글쓰기에 있어서 답변글이라면 fk_seq 컬럼의 값은 원글(부모글)의 idx 컬럼의 값을 가지게 되며, 답변글이 아닌 원글일 경우 0 을 가지도록 한다.                                              
	private int depthno;        	// 답변글쓰기에 있어서 답변글 이라면 원글(부모글)의 depthno + 1 을 가지게 되며, 답변글이 아닌 원글일 경우 0 을 가지도록 한다.
	private String regDate;         // 글쓴시간
	private int status;             // 글삭제여부   1:사용가능한글, 0:삭제된글 
	private int infoStatus;     	// 일반글: 0   공지사항: 1
	
	
	public FreeBoardVO() { }
	
	public FreeBoardVO(int idx, String userid, String name, String subject, String content, int readCnt, int commentCnt,
			int groupno, int fk_idx, int depthno, String regDate, int status, int infoStatus) {

		this.idx = idx;
		this.userid = userid;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.readCnt = readCnt;
		this.commentCnt = commentCnt;
		this.groupno = groupno;
		this.fk_idx = fk_idx;
		this.depthno = depthno;
		this.regDate = regDate;
		this.status = status;
		this.infoStatus = infoStatus;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public int getGroupno() {
		return groupno;
	}

	public void setGroupno(int groupno) {
		this.groupno = groupno;
	}

	public int getFk_idx() {
		return fk_idx;
	}

	public void setFk_idx(int fk_idx) {
		this.fk_idx = fk_idx;
	}

	public int getDepthno() {
		return depthno;
	}

	public void setDepthno(int depthno) {
		this.depthno = depthno;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getInfoStatus() {
		return infoStatus;
	}

	public void setInfoStatus(int infoStatus) {
		this.infoStatus = infoStatus;
	}
	
	
	
	
	
	
}
