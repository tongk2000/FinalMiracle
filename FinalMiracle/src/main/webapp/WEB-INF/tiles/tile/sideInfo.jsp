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
<<<<<<< HEAD

<style type="text/css">

</style>

=======
<<<<<<< HEAD
=======

>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
<script type="text/javascript">
<<<<<<< HEAD
   $(function() {
       $(document).tooltip();
   });
=======
	$(document).ready(function(){
		$(document).tooltip();
		alarm();
		setTimeout(function(){
			alarm();	
		},10000); 
	});
	function alarm() {
		var data_form={"idx":"${sessionScope.teamInfo.team_idx}","userid":"${sessionScope.loginUser.userid}"};
		$.ajax({
			url:"alarm.mr",
			type:"get",
			data:data_form,
			dataType:"json",
			success: function(data) {
				$.each(data, function(entryIndex, entry){
					var wordstr = entry.alarm;
					var result = "";
						result = "<span style='color:red;'>"+wordstr+"</span>";
					$("#alarm").after(wordstr);
				});	
			},
			error: function(){
				alert("=====================1111111===================");
			}
		});
	}
=======
<<<<<<< HEAD
%>
=======
%>
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git

<style type="text/css">

</style>

<script type="text/javascript">
   $(function() {
       $(document).tooltip();
   });
</script>

<div class="side-info">
      
<<<<<<< HEAD

=======
=======
<script type="text/javascript">
	$(function() {
	    $(document).tooltip();
	});
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
</script>
<div class="side-info">
<<<<<<< HEAD
      

    <ul style="list-style-type: none; margin: 0px; padding: 0px;">
=======
<<<<<<< HEAD
=======
      
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git

<<<<<<< HEAD
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
    <ul style="list-style-type: none; margin: 0px; padding: 0px;">
<<<<<<< HEAD
=======
<<<<<<< HEAD
      <li><a href="<%= request.getContextPath() %>/doList.mr" title="메인 페이지"><img src="<%= request.getContextPath() %>/resources/images/icon/00.png" style="width:50px; heigth:50px;" /></a></li>
=======
=======
    <ul style="list-style-type: none; margin: 0px; padding: 0px;">
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
      <li><a href="<%= request.getContextPath() %>/doList.mr" title="일정관리"><img src="<%= request.getContextPath() %>/resources/images/icon/01.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%-- <%=serverName%> --%><%= request.getContextPath() %>/chatting.mr" title="채팅"><img src="<%= request.getContextPath() %>/resources/images/icon/02.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/commute.mr" title="출퇴근"><img src="<%= request.getContextPath() %>/resources/images/icon/03.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/faqList.mr" title="FAQ"><img src="<%= request.getContextPath() %>/resources/images/icon/04.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/noticeList.mr" title="공지사항"><img src="<%= request.getContextPath() %>/resources/images/icon/05.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/mindList.mr" title="마음의소리"><img src="<%= request.getContextPath() %>/resources/images/icon/06.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/freeList.mr" title="자유게시판"><img src="<%= request.getContextPath() %>/resources/images/icon/07.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/voteList.mr" title="투표게시판"><img src="<%= request.getContextPath() %>/resources/images/icon/08.png" style="width:50px; heigth:50px;" /></a></li>
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
      <li><a href="<%= request.getContextPath() %>/tmList.mr" title="팀원관리"><img src="<%= request.getContextPath() %>/resources/images/icon/09.png" style="width:50px; heigth:50px;" /></a></li>
<<<<<<< HEAD
      <li><a href="<%= request.getContextPath() %>/memoList.mr" title="메모"><img src="<%= request.getContextPath() %>/resources/images/icon/10.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/memoreceiver.mr" title="쪽지"  ><img src="<%= request.getContextPath() %>/resources/images/icon/11.png" style="width:50px; heigth:50px;" id="alarm"/></a></li>
=======
<<<<<<< HEAD
      <%-- <li><a href="<%= request.getContextPath() %>/memoList.mr" title="메모"><img src="<%= request.getContextPath() %>/resources/images/icon/10.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/memoreceiver.mr" title="쪽지"  ><img src="<%= request.getContextPath() %>/resources/images/icon/11.png" style="width:50px; heigth:50px;" id="alarm"/></a></li> --%>
=======
      <li><a href="<%= request.getContextPath() %>/memoList.mr" title="메모"><img src="<%= request.getContextPath() %>/resources/images/icon/10.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/memoreceiver.mr" title="쪽지" ><img src="<%= request.getContextPath() %>/resources/images/icon/11.png" style="width:50px; heigth:50px;" id="alarm" /></a></li>
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
      <li style="margin-left:20px;"><a href="<%= request.getContextPath() %>/googleMap.mr" title="회사소개">회사</a></li>
      <li><a href="<%= request.getContextPath() %>/memoList.mr" title="메모"><img src="<%= request.getContextPath() %>/resources/images/icon/10.png" style="width:40px; heigth:40px; margin-left: 5px; margin-top: 5px; margin-bottom: 5px;"/></a></li>
      <li><a href="<%= request.getContextPath() %>/memoreceiver.mr" title="쪽지"><img src="<%= request.getContextPath() %>/resources/images/icon/11.png" style="width:50px; heigth:50px;" /></a></li>
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
      <li><a href="<%= request.getContextPath() %>/tmList.mr" title="팀원관리"><img src="<%= request.getContextPath() %>/resources/images/icon/09.png" style="width:50px; heigth:50px;" /></a></li>
      <%-- <li><a href="<%= request.getContextPath() %>/memoList.mr" title="메모"><img src="<%= request.getContextPath() %>/resources/images/icon/10.png" style="width:50px; heigth:50px;" /></a></li>
      <li><a href="<%= request.getContextPath() %>/memoreceiver.mr" title="쪽지"  ><img src="<%= request.getContextPath() %>/resources/images/icon/11.png" style="width:50px; heigth:50px;" id="alarm"/></a></li> --%>
      <li style="margin-left:20px;"><a href="<%= request.getContextPath() %>/googleMap.mr" title="회사소개">회사</a></li>
      <li><a href="<%= request.getContextPath() %>/memoList.mr" title="메모"><img src="<%= request.getContextPath() %>/resources/images/icon/10.png" style="width:40px; heigth:40px; margin-left: 5px; margin-top: 5px; margin-bottom: 5px;"/></a></li>
      <li><a href="<%= request.getContextPath() %>/memoreceiver.mr" title="쪽지"><img src="<%= request.getContextPath() %>/resources/images/icon/11.png" style="width:50px; heigth:50px;" /></a></li>
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
>>>>>>> branch 'master' of https://github.com/tongk2000/FinalMiracle.git
    </ul>
</div>
