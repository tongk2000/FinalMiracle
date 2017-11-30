package com.miracle.kdh.model;

public class Folder_CommentVO {
	// create table tbl_folder_comment
	private int idx; //             number not null              -- 폴더댓글 번호
	private int fk_folder_idx; //   number not null              -- fk_폴더번호
	private int fk_teamwon_idx; //  number not null              -- fk_팀원번호(소속된 팀원. folder_teamwon 에서 받음) 
	private String content; //         Nvarchar2(200) not null      -- 댓글내용
	private int status; //          number default 1 not null    -- 상태값(0:삭제, 1:게시)
	private String writeDate; //       date default sysdate         -- 작성일
	// ,constraint PK_fc_idx primary key (idx)
	// ,constraint FK_fc_fk_folder_idx foreign key (fk_folder_idx) references tbl_folder(idx)
	// ,constraint FK_fc_fk_teamwon_idx foreign key (fk_teamwon_idx) references tbl_folder_teamwon(idx)
	// ,constraint CK_fc_status check (status in (0, 1))
	// );
	
	private String userid; // userid 알아오기용(컬럼은 없음)
	
	public Folder_CommentVO() {}

	public Folder_CommentVO(int idx, int fk_folder_idx, int fk_teamwon_idx, String content, int status,
			String writeDate, String userid) {
		super();
		this.idx = idx;
		this.fk_folder_idx = fk_folder_idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		this.content = content;
		this.status = status;
		this.writeDate = writeDate;
		this.userid = userid;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getFk_folder_idx() {
		return fk_folder_idx;
	}

	public void setFk_folder_idx(int fk_folder_idx) {
		this.fk_folder_idx = fk_folder_idx;
	}

	public int getFk_teamwon_idx() {
		return fk_teamwon_idx;
	}

	public void setFk_teamwon_idx(int fk_teamwon_idx) {
		this.fk_teamwon_idx = fk_teamwon_idx;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getwriteDate() {
		return writeDate;
	}

	public void setwriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}
