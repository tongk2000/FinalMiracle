package com.miracle.psw.model;

public class MemberVO {

	private int idx;        //  회원번호
	private String userid;  //  회원ID
	private String pwd;     //  회원pwd
	private String name;    //  회원명
	private String img;     //  회원사진
	private int status;		//  회원상태값
	


	public MemberVO() { }
	
	public MemberVO(int idx, String userid, String pwd, String name, String img, int status) {

		this.idx = idx;
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.img = img;
		this.status = status;
	}


	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
}




