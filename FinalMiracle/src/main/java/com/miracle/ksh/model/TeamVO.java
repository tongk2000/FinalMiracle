package com.miracle.ksh.model;

public class TeamVO {
	
	private int idx;
	private int fk_member_idx;
	private String name;
	private String tel1;
	private String tel2;
	private String tel3;
	private String post1;
	private String post2;
	private String addr1;
	private String addr2;
	private String img;
	private String regdate;
	private String disdate;
	private int status;
	
	
	public TeamVO() {}


	public TeamVO(int idx, int fk_member_idx, String name, String tel1, String tel2, String tel3, String post1,
			String post2, String addr1, String addr2, String img, String regdate, String disdate, int status) {
		super();
		this.idx = idx;
		this.fk_member_idx = fk_member_idx;
		this.name = name;
		this.tel1 = tel1;
		this.tel2 = tel2;
		this.tel3 = tel3;
		this.post1 = post1;
		this.post2 = post2;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.img = img;
		this.regdate = regdate;
		this.disdate = disdate;
		this.status = status;
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


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getTel1() {
		return tel1;
	}


	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}


	public String getTel2() {
		return tel2;
	}


	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}


	public String getTel3() {
		return tel3;
	}


	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}


	public String getPost1() {
		return post1;
	}


	public void setPost1(String post1) {
		this.post1 = post1;
	}


	public String getPost2() {
		return post2;
	}


	public void setPost2(String post2) {
		this.post2 = post2;
	}


	public String getAddr1() {
		return addr1;
	}


	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}


	public String getAddr2() {
		return addr2;
	}


	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}


	public String getImg() {
		return img;
	}


	public void setImg(String img) {
		this.img = img;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}


	public String getDisdate() {
		return disdate;
	}


	public void setDisdate(String disdate) {
		this.disdate = disdate;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
	

}
