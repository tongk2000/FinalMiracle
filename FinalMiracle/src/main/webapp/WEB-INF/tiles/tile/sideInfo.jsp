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
<script type="text/javascript">
	$(document).ready(function(){
		$(document).tooltip();
		alarm();
		setTimeout(function(){
				alarm();	
		},1000); 
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
					$("#alarm").after(result);
				});	
			},
			error: function(){
				alert("=====================1111111===================");
			}
		});
	}
	$(function() {
	    $(document).tooltip();
	});
</script>

<ul style="list-style-type: none; margin: 0px; padding: 0px; text-align: left;">
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/doList.mr'" title="프로젝트" id="sideDoIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/01.png" class="iconPng sideIconPng" />
		<span class="toggleText">프로젝트</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/chatting.mr'" title="채팅" id="sideChattingIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/02.png" class="iconPng sideIconPng" />
		<span class="toggleText">채팅</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/commute.mr'" title="출퇴근" id="sideCommuteIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/03.png" class="iconPng sideIconPng" />
		<span class="toggleText">출퇴근</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/faqList.mr'" title="FAQ" id="sideFaqIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/04.png" class="iconPng sideIconPng" />
		<span class="toggleText">FAQ</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/noticeList.mr'" title="공지사항" id="sideNoticeIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/05.png" class="iconPng sideIconPng" />
		<span class="toggleText">공지사항</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/mindList.mr'" title="마음의소리" id="sideMindIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/06.png" class="iconPng sideIconPng" />
		<span class="toggleText">마음의소리</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'" title="자유게시판" id="sideFreeIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/07.png" class="iconPng sideIconPng" />
		<span class="toggleText">자유게시판</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'" title="투표게시판" id="sideVoteIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/08.png" class="iconPng sideIconPng" />
		<span class="toggleText">투표게시판</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/tmList.mr'" title="팀원관리" id="sideTeamwonIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/09.png" class="iconPng sideIconPng" />
		<span class="toggleText">팀원관리</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/googleMap.mr'" title="회사소개" id="sideCompayIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/16.png" class="iconPng sideIconPng" />
		<span class="toggleText">회사소개</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr'" title="메모" id="sideMemoIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/10.png" class="iconPng sideIconPng"/>
		<span class="toggleText">메모</span>
	</li>
	<li onclick="javascript:location.href='<%= request.getContextPath() %>/memoreceiver.mr'" title="쪽지" id="sideMassageIcon" class="iconTag sideBarLi">
		<img src="<%= request.getContextPath() %>/resources/images/icon/11.png" class="iconPng sideIconPng" />
		<span class="toggleText">쪽지</span>
	</li>
</ul>













