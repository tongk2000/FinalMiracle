package com.miracle.kdh.model;

public class Folder_FileVO {
	// create table tbl_folder_file
	private int idx; //            number not null           -- 폴더 파일 IDX
	private int fk_folder_idx; //  number not null           -- fk_폴더번호
	private String filename; //       varchar2(100) not null    -- 파일명(톰캣)
	private String orgfilename; //    varchar2(100) not null    -- 파일명(사용자)
	private int filesize; //       number not null           -- 파일크기
	// ,constraint PK_ff_idx primary key (idx)
	// ,constraint FK_ff_fk_folder_idx foreign key (fk_folder_idx) references tbl_folder(idx)
	// );
	
	public Folder_FileVO() {}
	public Folder_FileVO(int idx, int fk_folder_idx, String filename, String orgfilename, int filesize) {
		super();
		this.idx = idx;
		this.fk_folder_idx = fk_folder_idx;
		this.filename = filename;
		this.orgfilename = orgfilename;
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
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOrgfilename() {
		return orgfilename;
	}
	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}
	public int getFilesize() {
		return filesize;
	}
	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}
	
	
}
