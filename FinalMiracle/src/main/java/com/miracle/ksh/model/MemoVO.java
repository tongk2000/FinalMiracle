package com.miracle.ksh.model;

public class MemoVO {
	
	private int idx; //메모번호
	private int fk_member_idx; //회원번호
	private int fk_teamwon_idx; //팀원번호
	private String subject; //제목
	private String content; //내용
	private String groups; //분류
	private String regdate; //등록일
	private String editdate; //최종수정일
	
	public MemoVO() {	}

	public MemoVO(int idx, int fk_member_idx, int fk_teamwon_idx, String subject, String content, String groups,
			String regdate, String editdate) {
		super();
		this.idx = idx;
		this.fk_member_idx = fk_member_idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		this.subject = subject;
		this.content = content;
		this.groups = groups;
		this.regdate = regdate;
		this.editdate = editdate;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getFk_member_idx() {
		return fk_member_idx;
	}

	public void setFk_member_idx(int fk_member_idx) {
		this.fk_member_idx = fk_member_idx;
	}

	public int getFk_teamwon_idx() {
		return fk_teamwon_idx;
	}

	public void setFk_teamwon_idx(int fk_teamwon_idx) {
		this.fk_teamwon_idx = fk_teamwon_idx;
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

	public String getGroups() {
		return groups;
	}

	public void setGroups(String groups) {
		this.groups = groups;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getEditdate() {
		return editdate;
	}

	public void setEditdate(String editdate) {
		this.editdate = editdate;
	}


}
