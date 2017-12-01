package com.miracle.kdh.model;

public class Folder_TeamwonVO {
	// create table tbl_folder_teamwon
	private int idx; //             number not null              -- 폴더팀원 번호
	private int fk_folder_idx; //   number not null              -- fk_폴더번호
	private int fk_teamwon_idx; //  number not null              -- fk_팀원번호(소속된 팀원) 
	private int acceptability; //   number default 1 not null    -- 수락여부(-1:수락거절, 0:수락대기, 1:수락완료)
	private int status; //          number default 1 not null    -- 상태값(0:탈퇴, 1:일반, 2:관리자등급(만든사람(팀장)과 같은 권한))
	// ,constraint PK_ft_idx primary key (idx)
	// ,constraint FK_ft_fk_folder_idx foreign key (fk_folder_idx) references tbl_folder(idx)
	// ,constraint FK_ft_fk_teamwon_idx foreign key (fk_teamwon_idx) references tbl_teamwon(idx)
	// ,constraint CK_ft_acceptability check (acceptability in (-1, 0, 1))
	// ,constraint CK_ft_status check (status in (0, 1, 2))
	// );
	
	private String userid; // userid 알아오기용(컬럼은 없음)
	private int proceedingTaskCnt;
	private int completeTaskCnt;
	
	public Folder_TeamwonVO() {}

	public Folder_TeamwonVO(int idx, int fk_folder_idx, int fk_teamwon_idx, int acceptability, int status,
			String userid, int proceedingTaskCnt, int completeTaskCnt) {
		super();
		this.idx = idx;
		this.fk_folder_idx = fk_folder_idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		this.acceptability = acceptability;
		this.status = status;
		this.userid = userid;
		this.proceedingTaskCnt = proceedingTaskCnt;
		this.completeTaskCnt = completeTaskCnt;
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

	public int getAcceptability() {
		return acceptability;
	}

	public void setAcceptability(int acceptability) {
		this.acceptability = acceptability;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getProceedingTaskCnt() {
		return proceedingTaskCnt;
	}

	public void setProceedingTaskCnt(int proceedingTaskCnt) {
		this.proceedingTaskCnt = proceedingTaskCnt;
	}

	public int getCompleteTaskCnt() {
		return completeTaskCnt;
	}

	public void setCompleteTaskCnt(int completeTaskCnt) {
		this.completeTaskCnt = completeTaskCnt;
	}
	
}
