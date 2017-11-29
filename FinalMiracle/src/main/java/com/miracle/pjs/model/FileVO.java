package com.miracle.pjs.model;

public class FileVO {
	
	private int idx;                    	// 기본키
	private String filename;		      	// WAS(톰캣)에 저장될 파일명
	private String orgFilename;  			// 진짜 파일명
	private int fileSize;     	      		// 파일크기
	private int fk_idx;               		// 왜래키(tbl_note)
	public FileVO(){}
	public FileVO(int idx, String filename, String orgFilename, int fileSize, int fk_idx) {
		super();
		this.idx = idx;
		this.filename = filename;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.fk_idx = fk_idx;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getOrgFilename() {
		return orgFilename;
	}
	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public int getFk_idx() {
		return fk_idx;
	}
	public void setFk_idx(int fk_idx) {
		this.fk_idx = fk_idx;
	}
	
}
