package com.miracle.pjs.model;

import org.springframework.web.multipart.MultipartFile;

public class MindFileVO {
	

	/*	   ===== #131. 파일첨부를 하도록 VO 수정하기
	                먼저, 오라클에서 tblBoard 테이블에
	   3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에
	                아래의 작업을 해야 한다. ===== 
	*/
	private String idx;			 // 기본키
	private String fileName;     // WAS(톰캣)에 저장될 파일명(20161121324325454354353333432.png)
	private String orgFilename;  // 진짜 파일명(강아지.png). 사용자가 파일을 업로드 하거나 파일을 다운로드 할때 사용되어지는 파일명
	private String fileSize;     // 파일크기
	private String fk_idx; 		 // 참조키;
	
	private MultipartFile attach; // 진짜 파일 ==> WAS(톰캣) 디스크에 저장됨. -> 파일첨부할 때 여기로 들어온다.
	    // MultipartFile attach 는 오라클 데이터베이스 tblBoard 테이블의 컬럼이 아니다.!!!!!!   

	public MindFileVO() { }
	public MindFileVO(String idx, String fileName, String orgFilename, String fileSize, String fk_idx,
			MultipartFile attach) {
		super();
		this.idx = idx;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
		this.fk_idx = fk_idx;
		this.attach = attach;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getFk_idx() {
		return fk_idx;
	}

	public void setFk_idx(String fk_idx) {
		this.fk_idx = fk_idx;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
}
