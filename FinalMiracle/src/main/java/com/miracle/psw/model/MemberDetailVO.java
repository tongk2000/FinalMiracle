package com.miracle.psw.model;

public class MemberDetailVO {

	private int idx;     	 	// 회원상세번호
	private int fk_member_idx;  // fk_회원번호
	private String birth1;   	// 회원생년
	private String birth2;   	// 회원생월
	private String birth3;   	// 회원생일
	private String hp1;      	// 회원연락처1
	private String hp2;      	// 회원연락처2
	private String hp3;      	// 회원연락처3
	private String email;    	// 회원이메일
	private String post1;    	// 회원우편번호1
	private String post2;    	// 회원우편번호2
	private String addr1;    	// 회원주소1
	private String addr2;    	// 회원주소1
	private String profile;  	// 회원프로필(인사말 등)
	private String regdate;  	// 회원가입일
	private int status;   	 	// 회원상태(0:탈퇴, 1:정상)
	
	
	public MemberDetailVO() { }
	
	public MemberDetailVO(int idx, int fk_member_idx, String birth1, String birth2, String birth3, String hp1,
			String hp2, String hp3, String email, String post1, String post2, String addr1, String addr2,
			String profile, String regdate, int status) {

		this.idx = idx;
		this.fk_member_idx = fk_member_idx;
		this.birth1 = birth1;
		this.birth2 = birth2;
		this.birth3 = birth3;
		this.hp1 = hp1;
		this.hp2 = hp2;
		this.hp3 = hp3;
		this.email = email;
		this.post1 = post1;
		this.post2 = post2;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.profile = profile;
		this.regdate = regdate;
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

	public String getBirth1() {
		return birth1;
	}

	public void setBirth1(String birth1) {
		this.birth1 = birth1;
	}

	public String getBirth2() {
		return birth2;
	}

	public void setBirth2(String birth2) {
		this.birth2 = birth2;
	}

	public String getBirth3() {
		return birth3;
	}

	public void setBirth3(String birth3) {
		this.birth3 = birth3;
	}

	public String getHp1() {
		return hp1;
	}

	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}

	public String getHp2() {
		return hp2;
	}

	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}

	public String getHp3() {
		return hp3;
	}

	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	
	
	
	
	
	
}
