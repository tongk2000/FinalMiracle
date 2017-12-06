package com.miracle.ksh.model;

import java.util.HashMap;
import java.util.List;

public interface InterMemoDAO {

	List<HashMap<String, String>> memoList1(HashMap<String, String> memoMap); //메모 리스트를 가져오자 (노 검색)
	
	List<HashMap<String, String>> memoList2(HashMap<String, String> memoMap); //메모 리스트를 가져오자 (예스 검색)

	int MemoTotalCount1(HashMap<String, String> memoMap); //메모 리스트의 총 개수를 가져오자 (노 검색)

	int MemoTotalCount2(HashMap<String, String> memoMap); //메모 리스트의 총 개수를 가져오자 (예스 검색)

	List<String> getfolderList(); //메모분류 리스트를 뽑아오자

	int MemoAdd(HashMap<String, String> memoMap); //메모를 써보자

	List<MemoVO> getMemoVO(String idx); //수정할 메모의 정보를 뽑아오자

	int MemoEdit(HashMap<String, String> memoMap); //메모를 수정해보자

	int MemoGarbage(String idx); //메모를 휴지통으로 넘겨보자

	int MemoRestore(String idx); //메모를 휴지통에서 복구해보자

	int MemoDel(String idx); //메모를 삭제해보자

	

}
