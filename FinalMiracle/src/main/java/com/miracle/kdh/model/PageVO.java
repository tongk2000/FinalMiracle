package com.miracle.kdh.model;

//페이징 처리값을 쉽게 받기 위해 VO로 값을 받아옴
public class PageVO {
	private int showIdx; // 만약 어떤 글의 댓글을 본다고 하면 해당 글의 번호를 저장함
	private int selectPage; // 현재 선택한 페이지
	private int sizePerPage; // 한번에 보여줄 글 갯수
	private int blockSize; // 한번에 보여줄 페이지번호의 갯수
	private String function; // pageBar 에 넣을 함수 이름
	private String pageBar; // pageBar 를 여기에 넣어서 페이지 값 유지와 함께 넘겨줄 생각
	
	public PageVO(){}
	public PageVO(int showIdx, int selectPage, int sizePerPage, int blockSize, String function) {
		super();
		this.showIdx = showIdx;
		this.selectPage = selectPage;
		this.sizePerPage = sizePerPage;
		this.blockSize = blockSize;
/*		this.pnum1 = selectPage*sizePerPage - sizePerPage + 1;
		this.pnum2 = selectPage*sizePerPage;*/
		// 뷰단에서 controller 로 갈때 둘다 자동으로는 안들어감
		this.function = function;
	}
	
	public int getShowIdx() {
		return showIdx;
	}
	public void setShowIdx(int showIdx) {
		this.showIdx = showIdx;
	}
	public int getSelectPage() {
		return selectPage;
	}
	public void setSelectPage(int selectPage) {
		this.selectPage = selectPage;
	}
	public int getSizePerPage() {
		return sizePerPage;
	}
	public void setSizePerPage(int sizePerPage) {
		this.sizePerPage = sizePerPage;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	
	public int getPnum1() {
		return this.selectPage * this.sizePerPage - this.sizePerPage + 1;
	}
	public int getPnum2() {
		return this.selectPage * this.sizePerPage;
	}
/*	public void setPnum1(int selectPage, int sizePerPage) {
		this.pnum1 = selectPage*sizePerPage - sizePerPage + 1;
	}
	public void setPnum2(int selectPage, int sizePerPage) {
		this.pnum2 = selectPage*sizePerPage;
	}*/ 
	// 뷰단에서 controller 로 갈때 둘다 자동으로는 안들어감
	
	public String getFunction() {
		return function;
	}
	public void setFunction(String function) {
		this.function = function;
	}
	public String getPageBar() {
		return pageBar;
	}
	public void setPageBar(String pageBar) {
		this.pageBar = pageBar;
	}
}










