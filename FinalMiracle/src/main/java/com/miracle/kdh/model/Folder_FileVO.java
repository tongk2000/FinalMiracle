package com.miracle.kdh.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Folder_FileVO {
	// create table tbl_folder_file
	private int idx; //            number not null           -- 폴더 파일 IDX
	private int fk_folder_idx; //  number not null           -- fk_폴더번호
	private int fk_teamwon_idx; // number not null          -- fk_팀원번호(소속된 팀원. folder_teamwon 에서 받음) 
	private String serFilename; //       varchar2(100) not null    -- 파일명(톰캣)
	private String orgFilename; //    varchar2(100) not null    -- 파일명(사용자)
	private long filesize; //       number not null           -- 파일크기
	// ,constraint PK_ff_idx primary key (idx)
	// ,constraint FK_ff_fk_folder_idx foreign key (fk_folder_idx) references tbl_folder(idx)
	// );
	
	private String userid; // 올린 사람 가져오기용
	
	public Folder_FileVO() {}
	public Folder_FileVO(int idx, int fk_folder_idx, int fk_teamwon_idx, String serFilename, String orgFilename,
			long filesize, String userid) {
		super();
		this.idx = idx;
		this.fk_folder_idx = fk_folder_idx;
		this.fk_teamwon_idx = fk_teamwon_idx;
		this.serFilename = serFilename;
		this.orgFilename = orgFilename;
		this.filesize = filesize;
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
	public String getSerFilename() {
		return serFilename;
	}
	public void setSerFilename(String serFilename) {
		this.serFilename = serFilename;
	}
	public String getOrgFilename() {
		return orgFilename;
	}
	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
}
