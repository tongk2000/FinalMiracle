package com.miracle.ksh.service;

import java.util.HashMap;
import java.util.List;

import com.miracle.ksh.model.VoteItemVO;
import com.miracle.ksh.model.VoteVO;

public interface InterVoteService {

	List<HashMap<String, String>> VoteListNoPaging(); //투표리스트를 띄워보자 (노 페이징)

	List<VoteItemVO> VoteItemList(); //투표문항을 띄워보자

	List<HashMap<String, String>> VoteEndListNoPaging(); //종료 투표리스트를 띄워보자 (노 페이징)

	int VoteAdd(HashMap<String, String> mapVote); //투표글을 작성해보자

	int VoteItemAdd(HashMap<String, Object> mapVoteItem); //투표문항을 넣어보자 (노 이미지)

	int VoteItemImageAdd(HashMap<String, Object> mapVoteItem); //투표문항을 넣어보자 (예스 이미지)

	int VoteLastIdx(); //막 추가된 투표글의 idx를 알아보자

	int VoteNumUpdate(String voteitem_idx); //해당하는 투표 문항에 득표 수를 올려보자

	int VoteTotalCount1(); //현재 투표 글의 전체 수를 알아보자

	List<HashMap<String, String>> VoteListYesPaging1(HashMap<String, String> map); //투표리스트를 띄워보자 (예스 페이징)

	List<HashMap<String, String>> VoteEndListYesPaging1(HashMap<String, String> map); //종료된 투표리스트를 띄워보자 (예스 페이징)

	int VoteEndTotalCount1(); //종료된 투표 글의 전체 수를 알아오자

	int VotedAdd(HashMap<String, String> mapVoted); //투표할 경우 기록 테이블에 남겨보자

	String VotedCheck(HashMap<String, String> mapVotedChk); //중복투표를 검사해보자

	List<HashMap<String, String>> VoteListYesPaging2(HashMap<String, String> map); //투표리스트를 띄워보자 (예스 페이징, 예스 검색)

	int VoteTotalCount2(HashMap<String, String> map); //현재 투표 글의 전체 수를 알아보자 (예스 검색)

	List<HashMap<String, String>> VoteEndListYesPaging2(HashMap<String, String> map); //종료된 투표리스트를 띄워보자 (예스 페이징, 예스 검색)

	int VoteEndTotalCount2(HashMap<String, String> map); //종료된 투표 글의 전체 수를 알아보자 (예스 검색)

	List<HashMap<String, String>> VoteMyListYesPaging1(HashMap<String, String> map); //자기가 쓴 투표리스트를 띄워보자 (예스 페이징, 노 검색)

	List<HashMap<String, String>> VoteMyListYesPaging2(HashMap<String, String> map); //자기가 쓴 투표리스트를 띄워보자 (예스 페이징, 예스 검색)

	int VoteDel(String idx); //투표글을 삭제해보자

	VoteVO VoteView(String idx); //투표글의 전체 내용을 가져와보자

	List<VoteItemVO> VoteItemView(String idx); //투표글의 문항들을 가져와보자

	int VoteItemViewCnt(String idx); //투표글의 문항들의 총 개수를 알아오자

	int VoteEdit(HashMap<String, String> mapVote); //투표글의 내용을 수정해보자

	int VoteItemEdit(HashMap<String, Object> mapVoteItem); //투표문항을 수정해보자

	int VoteItemImageEdit(HashMap<String, Object> mapVoteItem); //투표글의 내용을 수정해보자 (예스 이미지)

	List<HashMap<String, String>> VoteReadyListYesPaging1(HashMap<String, String> map); //시작전 투표리스트를 띄워보자 (예스 페이징, 노 검색)

	List<HashMap<String, String>> VoteReadyListYesPaging2(HashMap<String, String> map); //시작전 투표리스트를 띄워보자 (예스 페이징, 예스 검색)

	int VoteReadyTotalCount1(); //시작전 투표글의 전체 수를 알아오자 (노 검색)

	int VoteReadyTotalCount2(HashMap<String, String> map); //시작전 투표글의 전체 수를 알아오자 (예스 검색)

	int VoteMyTotalCount1(HashMap<String, String> map); //나의 투표글의 전체 수를 알아오자 (노 검색)

	int VoteMyTotalCount2(HashMap<String, String> map); //나의 투표글의 전체 수를 알아오자 (예스 검색)

	void VoteItemRestAdd(HashMap<String, Object> mapVoteItem); //수정시 문항을 더 넣고 싶을 경우 추가해보자

	void VoteItemRestDel(HashMap<String, Object> mapVoteItem); //수정시 문항이 초과될 경우 남은 문항을 없애보자

	int VoteItemMaxRest(); //수정시 추가될 문항의 idx를 구해보자


}
