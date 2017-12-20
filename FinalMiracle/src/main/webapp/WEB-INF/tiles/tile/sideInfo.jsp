<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>

<ul style="list-style-type: none; margin: 0px; padding: 0px; text-align: center;">
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/doList.mr'" title="프로젝트" id="sideDoIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/01.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/chatting.mr'" title="채팅" id="sideChattingIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/02.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/commute.mr'" title="출퇴근" id="sideCommuteIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/03.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/faqList.mr'" title="FAQ" id="sideFaqIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/04.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/noticeList.mr'" title="공지사항" id="sideNoticeIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/05.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/mindList.mr'" title="마음의소리" id="sideMindIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/06.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'" title="자유게시판" id="sideFreeIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/07.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'" title="투표게시판" id="sideVoteIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/08.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/tmList.mr'" title="팀원관리" id="sideTeamwonIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/09.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/googleMap.mr'" title="회사소개" id="sideCompayIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/16.png" class="iconPng sideIconPng" />
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr'" title="메모" id="sideMemoIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/10.png" class="iconPng sideIconPng"/>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/memoreceiver.mr'" title="쪽지" id="sideMassageIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/11.png" class="iconPng sideIconPng" />
	</li>
</ul>
