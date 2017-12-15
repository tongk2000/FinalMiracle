package com.miracle.ksh.model;

import java.util.HashMap;
import java.util.List;

public interface InterMemoDAO {

	List<HashMap<String, String>> memoList1(HashMap<String, String> memoMap); //메모 리스트를 가져오자 (노 검색)
	
	List<HashMap<String, String>> memoList2(HashMap<String, String> memoMap); //메모 리스트를 가져오자 (예스 검색)

	int MemoTotalCount1(HashMap<String, String> memoMap); //메모 리스트의 총 개수를 가져오자 (노 검색)

	int MemoTotalCount2(HashMap<String, String> memoMap); //메모 리스트의 총 개수를 가져오자 (예스 검색)

	List<String> getfolderList(String fk_member_idx); //메모분류 리스트를 뽑아오자

	int MemoAdd(HashMap<String, String> memoMap); //메모를 써보자

	List<MemoVO> getMemoVO(String idx); //수정할 메모의 정보를 뽑아오자

	int MemoEdit(HashMap<String, String> memoMap); //메모를 수정해보자

	int MemoGarbage(String idx); //메모를 휴지통으로 넘겨보자

	int MemoRestore(String idx); //메모를 휴지통에서 복구해보자

	int MemoDel(String idx); //메모를 삭제해보자

	int MemoGarbage(HashMap<String, String> map); //선택된 메모들을 휴지통으로 넘겨보자

	int MemoRestore(HashMap<String, String> map); //휴지통에 있는 선택된 메모들을 복구시켜보자

	int MemoDel(HashMap<String, String> map); //휴지통에 있는 선택된 메모들을 삭제시켜보자

	int MemoUpdateGroups(HashMap<String, String> map); //선택된 메모들의 분류를 변경시켜보자

	

}
