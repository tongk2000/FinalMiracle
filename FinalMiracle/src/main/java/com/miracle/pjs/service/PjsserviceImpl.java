package com.miracle.pjs.service;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.miracle.pjs.model.PjsinterDAO;

@Service
public class PjsserviceImpl implements PjsinterService {
	@Autowired
	private PjsinterDAO dao;

	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> map) {
		// 공지사항 게시판 페이징리스트를 가져오는 메소드
		List<HashMap<String, String>> list = dao.getNoticeList(map);
		return list;
	}/*=======================================================================================================================================================*/
	@Override
	public int getTotalCount(HashMap<String, String> map) {
		// 테이블의 행수를 반환
		int cnt = dao.getCount(map);
		return cnt;
	}/*=======================================================================================================================================================*/

}
