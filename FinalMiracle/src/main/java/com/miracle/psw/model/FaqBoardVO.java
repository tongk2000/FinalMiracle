package com.miracle.psw.model;

public class FaqBoardVO {

	private int idx;              // 글번호
	private String subject;       // 글제목
	private String content;       // 글내용
	private int readCnt;      	  // 글조회수
	private String regDate;       // 글쓴시간
	private int status;           // 글삭제여부  1:사용가능한글, 0:삭제된글 
	
	private int category;		  // 문의 분류(범주)
	
	
	public FaqBoardVO() { }
	
	public FaqBoardVO(int idx, String subject, String content, int readCnt, String regDate, int status, int category) {
		
		this.idx = idx;
		this.subject = subject;
		this.content = content;
		this.readCnt = readCnt;
		this.regDate = regDate;
		this.status = status;
		this.category = category;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
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

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}
	
	
	
	
	
	
}





