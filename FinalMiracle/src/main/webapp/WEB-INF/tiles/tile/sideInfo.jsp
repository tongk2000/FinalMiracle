<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="side-info">
    <h3 class="side-title">side-info</h3>
    <ul>
      <li><a href="<%= request.getContextPath() %>/doList.mr">일정관리</a></li>
      <li><a href="#">채팅</a></li>
      <li><a href="<%= request.getContextPath() %>/commute.mr">출퇴근 체크</a></li>
      <li><a href="#">채팅</a></li>
      <li><a href="#">FAQ게시판</a></li>
      <li><a href="<%= request.getContextPath() %>/noticeList.mr">공지사항</a></li>
      <li><a href="<%= request.getContextPath() %>/mindList.mr">마음의소리</a></li>
      <li><a href="#">자유게시판</a></li>
      <li><a href="<%= request.getContextPath() %>/voteList.mr">투표</a></li>
      <li><a href="#">팀원관리</a></li>
      <li><a href="#">메모</a></li>
      <li><a href="#">쪽지</a></li>
    </ul>
</div>