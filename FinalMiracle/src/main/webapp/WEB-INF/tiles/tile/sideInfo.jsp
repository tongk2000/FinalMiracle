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

<style type="text/css">

</style>

<script type="text/javascript">
   $(function() {
       $(document).tooltip();
   });
</script>

<ul style="list-style-type: none; margin: 0px; padding: 0px; text-align: center;">
	<li><a href="#" title="전체메뉴"><img src="<%= request.getContextPath() %>/resources/images/icon/15.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/doList.mr" title="일정관리"><img src="<%= request.getContextPath() %>/resources/images/icon/01.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%-- <%=serverName%> --%><%= request.getContextPath() %>/chatting.mr" title="채팅"><img src="<%= request.getContextPath() %>/resources/images/icon/02.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/commute.mr" title="출퇴근"><img src="<%= request.getContextPath() %>/resources/images/icon/03.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/faqList.mr" title="FAQ"><img src="<%= request.getContextPath() %>/resources/images/icon/04.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/noticeList.mr" title="공지사항"><img src="<%= request.getContextPath() %>/resources/images/icon/05.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/mindList.mr" title="마음의소리"><img src="<%= request.getContextPath() %>/resources/images/icon/06.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/freeList.mr" title="자유게시판"><img src="<%= request.getContextPath() %>/resources/images/icon/07.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/voteList.mr" title="투표게시판"><img src="<%= request.getContextPath() %>/resources/images/icon/08.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/tmList.mr" title="팀원관리"><img src="<%= request.getContextPath() %>/resources/images/icon/09.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/googleMap.mr" title="회사소개"><img src="<%= request.getContextPath() %>/resources/images/icon/16.png" style="width:35px; heigth:35px;" /></a></li>
	<li><a href="<%= request.getContextPath() %>/memoList.mr" title="메모"><img src="<%= request.getContextPath() %>/resources/images/icon/10.png" style="width:35px; heigth:35px;"/></a></li>
	<li><a href="<%= request.getContextPath() %>/memoreceiver.mr" title="쪽지"><img src="<%= request.getContextPath() %>/resources/images/icon/11.png" style="width:35px; heigth:35px;" /></a></li>
</ul>
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
