package com.miracle.pjs.model;

import java.util.List;

import com.miracle.pjs.util.MyUtil;

public class PagingVO {
	private int sizePerPage;
	private int totalCount;
	private int totalPage;
	private int blockSize;
	private int sNum;
	private int eNum;
	private int currentPage;
	private String url;
	private String pagebar;
	
	private List<ReplyVO> comment;
	
	public PagingVO(){}
	public PagingVO(int sizePerPage, int totalCount, int totalPage, int blockSize, int sNum, int eNum, int currentPage,
			String url, String pagebar, List<ReplyVO> comment) {
		super();
		this.sizePerPage = sizePerPage;
		this.totalCount = totalCount;
		this.totalPage = totalPage;
		this.blockSize = blockSize;
		this.sNum = sNum;
		this.eNum = eNum;
		this.currentPage = currentPage;
		this.url = url;
		this.pagebar = pagebar;
		this.comment = comment;
	}
	
	public String getPagebar() {
		return pagebar;
	}
	public void setPagebar(int sizePerPage, int blockSize, int totalPage, int currentPage, String url) {
		this.pagebar = MyUtil.getPageBar2(sizePerPage, blockSize, totalPage, currentPage, url);
	}
	public int getSizePerPage() {
		return sizePerPage;
	}
	public void setSizePerPage(int sizePerPage) {
		this.sizePerPage = sizePerPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalCount, int sizePerPage) {
		this.totalPage = (int)Math.ceil((double)totalCount / sizePerPage);
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getsNum() {
		return sNum;
	}
	public void setsNum(int currentPage, int sizePerPage) {
		this.sNum = ((currentPage - 1)*sizePerPage)+1;
	}
	public int geteNum() {
		return eNum;
	}
	public void seteNum(int sNum, int sizePerPage) {
		this.eNum = sNum + sizePerPage - 1;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<ReplyVO> getComment() {
		return comment;
	}
	public void setComment(List<ReplyVO> comment) {
		this.comment = comment;
	}
	
}
