package com.miracle.kdh.model;

public class FolderVO {
	// create table tbl_folder
	private int idx; //            number not null             -- 폴더번호
	private int fk_teamwon_idx; // number not null             -- fk_팀원번호(만든사람. 팀장)
	private String subject; //        Nvarchar2(100) not null     -- 폴더제목
	private String content; //        Nvarchar2(500)              -- 폴더내용(개요 간단히)
	private String startDate; //     date default sysdate        -- 시작일
	private String lastDate; //       date                        -- 마감일
	private int fk_folder_idx; //  number default 0 not null   -- fk_폴더번호(해당 폴더에 소속되있다는 표시. 0은 본인이 최상위 폴더라는뜻)
	private int groupNo; //        number not null             -- 폴더 그룹번호(계층쿼리 정렬용)
	private int depth; //          number default 0 not null   -- 들여쓰기 깊이(계층쿼리 들여쓰기용)
	private int category; //       number default 1 not null   -- 카테고리(1:폴더, 2:할일)
	private int status; //         number default 2 not null   -- 상태값(-2:삭제, -1:보류(부결시), 0:완료, 1:진행중, 2:찬성대기(폴더만 찬성여부를 따르며 할일은 그냥 통보))
	private int importance; //     number default 0 not null   -- 중요도(0~10)
	// ,constraint PK_folder_idx primary key (idx)
	// ,constraint FK_folder_fk_teamwon_idx foreign key (fk_teamwon_idx) references tbl_teamwon(idx)
	// ,constraint CK_folder_category check (category in (1, 2))
	// ,constraint CK_folder_status check (status in (-1, 0, 1))
	// ,constraint CK_folder_importance check (importance between 0 and 10)
	// );
	
	private int dayCnt; // 기한 지났는지 확인용
	private int importanceAvg; // 하위 폴더의 중요도 평균 내기용
	private int downCnt; // 하위 요소의 갯수 받아오기용
	
	public FolderVO(){}
	public FolderVO(int idx, int fk_teamwon_idx, String subject, String content, String startDate, String lastDate,
			int fk_folder_idx, int groupNo, int depth, int category, int status, int importance, int dayCnt,
			int importanceAvg, int downCnt) {
		super();
		this.idx = idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		this.subject = subject;
		this.content = content;
		this.startDate = startDate;
		this.lastDate = lastDate;
		this.fk_folder_idx = fk_folder_idx;
		this.groupNo = groupNo;
		this.depth = depth;
		this.category = category;
		this.status = status;
		this.importance = importance;
		this.dayCnt = dayCnt;
		this.importanceAvg = importanceAvg;
		this.downCnt = downCnt;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getLastDate() {
		return lastDate;
	}
	public void setLastDate(String lastDate) {
		this.lastDate = lastDate;
	}
	public int getFk_folder_idx() {
		return fk_folder_idx;
	}
	public void setFk_folder_idx(int fk_folder_idx) {
		this.fk_folder_idx = fk_folder_idx;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getImportance() {
		return importance;
	}
	public void setImportance(int importance) {
		this.importance = importance;
	}
	public int getDayCnt() {
		return dayCnt;
	}
	public void setDayCnt(int dayCnt) {
		this.dayCnt = dayCnt;
	}
	public int getImportanceAvg() {
		return importanceAvg;
	}
	public void setImportanceAvg(int importanceAvg) {
		this.importanceAvg = importanceAvg;
	}
	public int getDownCnt() {
		return downCnt;
	}
	public void setDownCnt(int downCnt) {
		this.downCnt = downCnt;
	}
}
