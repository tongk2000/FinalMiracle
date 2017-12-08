<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>


<%  
    // === 서버 IP 주소 알아오기 === ==채팅을 위해 서버 아이피를 알아옴== //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress(); 
	int portnumber = request.getServerPort();
	
	String serverName = "http://"+serverIP+":"+portnumber;

%>


<div class="side-info">
    <h3 class="side-title">side-info</h3>
    <ul>
      <li><a href="<%= request.getContextPath() %>/doList.mr">일정관리</a></li>
      <li><a href="<%=serverName%><%= request.getContextPath() %>/chating.mr">채팅</a></li>
      <li><a href="<%= request.getContextPath() %>/commute.mr">출퇴근 체크</a></li>
      <li><a href="<%= request.getContextPath() %>/chatting.mr">채팅</a></li>
      <li><a href="<%= request.getContextPath() %>/faqList.mr">FAQ게시판</a></li>
      <li><a href="<%= request.getContextPath() %>/noticeList.mr">공지사항</a></li>
      <li><a href="<%= request.getContextPath() %>/mindList.mr">마음의소리</a></li>
      <li><a href="<%= request.getContextPath() %>/freeList.mr">자유게시판</a></li>
      <li><a href="<%= request.getContextPath() %>/voteList.mr">투표</a></li>
      <li><a href="<%= request.getContextPath() %>/tmList.mr">팀원관리</a></li>
      <li><a href="<%= request.getContextPath() %>/memoList.mr">메모</a></li>
      <li><a href="#">쪽지</a></li>
    </ul>
</div>