package com.miracle.pjs.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.miracle.pjs.model.MapVO;
import com.miracle.pjs.model.PjsinterDAO;
import com.miracle.pjs.util.MyUtil;

@Service
public class PjsserviceImpl implements PjsinterService {
	
	@Autowired
	private PjsinterDAO dao;

//==========================================================================================================================================================//	

	// === *** 공지사항 게시판 *** === //
	@Override
	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> map) {
		// 공지사항 게시판 페이징리스트를 가져오는 메소드
		List<HashMap<String, String>> list = dao.getNoticeList(map);
		return list;
	}
	@Override
	public int getNoticeCount(HashMap<String, String> map) {
		// 테이블의 행수를 반환
		int cnt = dao.getNoticeCount(map);
		return cnt;
	}
	@Override
	public List<String> getNoticeJSONList(HashMap<String, String> map) {
		// 공지사항 테이블에서 검색 시 json처리를 하기위한 메소드
		List<String> list = dao.getNoticeJSONList(map);
		return list;
	}
	
//==========================================================================================================================================================//	
	
	// === *** 마음의 소리 게시판 *** //
	@Override
	public List<HashMap<String, String>> getMindList(HashMap<String, String> map, String str_sizePerPage, String str_currentPage) {
		// 마음의 소리 게시판의 검색된 모든 리스트를 가져오는 메소드 
		int sizePerPage=0;
		int currentPage=0;
		try{
			sizePerPage = Integer.parseInt(str_sizePerPage);
			if(sizePerPage==0) 
				sizePerPage=5;
			if(sizePerPage!=10&&sizePerPage!=5&&sizePerPage!=3)
				sizePerPage=5;
		}
		catch(NumberFormatException e) {
			sizePerPage = 5;
		}
		if(str_currentPage==null || "".equals(str_currentPage)) {
			currentPage = 1;
		}
		else {
			currentPage = Integer.parseInt(str_currentPage);	
		}
		int totalCount = dao.getMindCount(map);
		int totalPage=(int)Math.ceil((double)totalCount/sizePerPage);
		int blockSize=3;
		int sNum = ((currentPage - 1)*sizePerPage)+1;
		int eNum = sNum + sizePerPage - 1;
		String pagebar = MyUtil.getPageBarWithSearch(sizePerPage, blockSize, totalPage, currentPage, map.get("searchType"), map.get("searchString"), null, "mindList.mr");
		map.put("sNum", String.valueOf(sNum));
		map.put("eNum", String.valueOf(eNum));
		
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("pagebar", pagebar);
	
		List<HashMap<String, String>> list = dao.getMindList(map);
		list.add(hashMap);
		return list;
	}
	
//==========================================================================================================================================================//	
	
	// === *** 구글맵  *** === //
	@Override
	public List<MapVO> getMap() {
		// 구글맵 테이블의 모든 정보를 가져온다.
		List<MapVO> list = dao.getMap();
		return list;
	}
	
//==========================================================================================================================================================//	

	// === *** 쪽지 *** === //

//==========================================================================================================================================================//	

}	
