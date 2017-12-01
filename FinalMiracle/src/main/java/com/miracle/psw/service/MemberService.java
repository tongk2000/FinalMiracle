package com.miracle.psw.service;

import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.miracle.psw.model.InterMemberDAO;
import com.miracle.psw.model.MemberDetailVO;
import com.miracle.psw.model.MemberVO;

@Service
public class MemberService implements InterMemberService {

	@Autowired  // DI
	private InterMemberDAO dao;

	@Override
	public int loginEnd(HashMap<String, String> map) {  // 로그인 여부 알아오기
		int n = dao.loginEnd(map);
		return n;
	}

	@Override
	public MemberVO getLoginMember(String userid) {  // 로그인한 회원 정보 알아오기
		MemberVO loginUser = dao.getLoginMember(userid);
		return loginUser;
	}

	@Override
	public String getUserid(HashMap<String, String> map) {  // id 찾기
		String userid = dao.getUserid(map);
		return userid;
	}

	@Override
	public int getUserExists(HashMap<String, String> map) { // pw 찾기
		int n = dao.getUserExists(map);
		return n;
	}

	@Override
	public int updatePwd(HashMap<String, String> map) {  // pwd 변경하기
		int n = dao.updatePwd(map);
		return n;
	}

	@Override
	public boolean idDuplicateCheck(String userid) {  // id 중복체크
		int n = dao.idDuplicateCheck(userid);
		
		if(n == 1) {
			return false;
		} else {
			return true;
		}
	}

	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	@Override
	public int registerMember(MemberVO mvo, MemberDetailVO mdvo) throws Throwable {  // 회원가입(insert tbl_member, tbl_member_detail)
		int n = dao.registerMember(mvo);
		int m = dao.registerMemberDetail(mdvo);
		
		return (n + m);
	}

	
	
	
	

	

	
	
}
