package com.miracle.psw.model;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO implements InterMemberDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public int loginEnd(HashMap<String, String> map) {  // 로그인 여부 알아오기
		int n = sqlsession.selectOne("member_psw.loginEnd", map);
		return n;
	}

	@Override
	public MemberVO getLoginMember(String userid) {  // 로그인한 회원정보 알아오기
		MemberVO loginUser = sqlsession.selectOne("member_psw.getLoginMember", userid);
		return loginUser;
	}

	@Override
	public String getUserid(HashMap<String, String> map) {  // id 찾기
		String userid = sqlsession.selectOne("member_psw.getUserid", map);
		return userid;
	}

	@Override
	public int getUserExists(HashMap<String, String> map) { // pw 찾기
		int n = sqlsession.selectOne("member_psw.getUserExists", map);
		return n;
	}

	@Override
	public int updatePwd(HashMap<String, String> map) {  // pwd 변경하기
		int n = sqlsession.update("member_psw.updatePwd", map);
		return n;
	}

	@Override
	public int idDuplicateCheck(String userid) {  // id 중복 체크
		int n = sqlsession.selectOne("member_psw.idDuplicateCheck", userid);
		return n;
	}

	@Override
	public int registerMember(MemberVO mvo) {  // 회원가입(tbl_member)
		int n = sqlsession.insert("member_psw.registerMember", mvo);
		return n;
	}

	@Override
	public int registerMemberDetail(MemberDetailVO mdvo) {  // 회원가입(tbl_member_detail)
		int n = sqlsession.insert("member_psw.registerMemberDetail", mdvo);
		return n;
	}
	
	
	
	
}










