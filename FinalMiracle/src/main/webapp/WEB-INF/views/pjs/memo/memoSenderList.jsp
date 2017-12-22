<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE>
<html>
<head>
<style>
	.imgs {
		width:30px;
		height:30px;
	}
	/* table {
		border-top:1px solid blue;
		padding:5px;
		border-radius:50px;
	}
	tr {
		border-bottom:1px solid yellow;
		padding:5px;
	}
	th, td {
		border:1px solid black;
		padding:5px;
		font-family:verdana;
	} */
	.selectLine {
    	background-color:#eaeaea;
    }
    .grayColor {
    	background-color:#eaeaea;
    	cursor: pointer;
    }
   /*  th{
    	font-size:12pt;
    	background-color:#337ab7;
    } */
    .near_by_hotel_wrapper{
	background:#f5f5f5;
	}
.custom_table {
    border-collapse: separate;
    border-spacing: 0 10px;
    margin-top: -3px;
}
.custom_table thead tr th {
	padding: 0px 8px;
	font-size: 16px;
	border: 0 none ;
	border-top: 0 none ;
}
.custom_table tbody tr {
    -moz-box-shadow: 0 2px 3px #e0e0e0;
    -webkit-box-shadow: 0 2px 3px #e0e0e0;
    box-shadow: 0 2px 3px #e0e0e0;
}
.near_by_hotel_wrapper table tr td {
	border-right: 1px solid #d2d1d1;
}

.custom_table tbody tr td {
	background: #fff none repeat scroll 0 0;
	border-top: 0 none;
	margin-bottom: 20px;
	padding: 10px 8px;
	font-size: 16px;
}
.near_by_hotel_wrapper table tr td {
    border-right: 1px solid #d2d1d1;
}
.modal.modal-center {
  text-align: center;
}
@media screen and (min-width: 400px) { 
  .modal.modal-center:before {
    display: inline-block;
    vertical-align: middle;
    content: " ";
    height: 100%;
  }
}
.modal-dialog.modal-center {
  display: inline-block;
  text-align: left;
  vertical-align: middle; 
}	
</style>
<script>
	function goView(idx, teamNum){
		var frm = document.view;
		frm.idx.value = idx;
		frm.teamNum.value = teamNum;
		frm.action = "memoSenderView.mr";
		frm.method = "get";
		frm.submit();
	}
	$(document).ready(function(){
		$("tr:has(td)").click(function(){ // tr중에서 td를 가지고 있는 tr
			var bool = $(e.target).parent().hasClass("selectLine"); 
			if(bool) {
				$(e.target).parent().removeClass("selectLine");
			}
			else {
				$(e.target).parent().addClass("selectLine");
			}
		});
		$("#del").click(function(){
			var cnt=0;
			var idx = new Array();
			$(".selectLine").each(function(){
				idx[cnt] = $(this).find("input").val();
				cnt++;
			});
			alert(idx);
			<%--  location.href="<%=request.getContextPath()%>/memoReceiverView.mr?idx="+idx;  get방식으로만 전송할 수 있다. --%> 
			var frm = document.del;
			frm.idx.value=idx;
			frm.action="memosenderDel.mr";
			frm.method="post";
			frm.submit();
		});
		$("#write").click(function(){
			window.location.href="<%=request.getContextPath()%>/memoWrite.mr";
		});
		$(".line").hover(function(){ 
			$(this).addClass("grayColor");
		},function(){
			$(this).removeClass("grayColor");
		});
	});
	function goUserInfo(userid) {
		var form_data = { "userInfo" : userid };
		$.ajax({
			url: "freeUserInfo.mr",
			type: "GET",
			data: form_data,  // url 요청페이지로 보내는 ajax 요청 데이터
			dataType: "JSON", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
			success: function(data) {				
				var html = "";
				
				var imgPath = data.infoImg;
				html += "<div style='font-family: verdana; font-size: 10pt; border: 2px dotted #E8E8E8; border-radius: 20px; background-color: #F0F0F0; padding: 5px;'><div style='float: right;'><img src='<%= request.getContextPath() %>/resources/files/" + imgPath + "' style='width: 80px; height: 80px; border-radius: 50px;' /></div>" + "<br/>"
					 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
					 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
					 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "</span><br/>"
					 +  "<span style='font-weight: bold;'>이메일 : </span>" + data.infoEmail + "<br/><br/>"
					 +  "<span style='font-weight: bold;'>소개 : </span>" + data.infoProfile +"</div>" ;
				
				$(".modal-body").html(html);
				$("#userinfo").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
	
</script>
<meta charset="UTF-8">
<title>쪽지</title>
</head>
<body>
	<div style="border:0px solid red; padding:5px;">
		<div style="border:0px solid green; padding:5px;" align="center">
			<div style="border:0px solid purple;" style="border-top:1px solid lightgray; border-bottom:1px solid lightgray;">
				<a href="<%=request.getContextPath()%>/memoWrite.mr"><span style="color:red;">쪽지 쓰기</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memomemory.mr"><span style="color:red;">보낸 쪽지</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memoreceiver.mr"><span style="color:red;">받은 쪽지</span></a>
			</div>
			<div style="border:0px solid pink; padding:5px;">
				<div class="near_by_hotel_wrapper">
				<div class="near_by_hotel_container">
				  <table class="table no-border custom_table dataTable no-footer dtr-inline" style="width:90%;">
				    <thead>
				      	<tr style="background-color:#1f5c87; color:white;" >
							<th>번호</th>
							<th>보낸사람</th>
							<th>제목</th>
							<th>받은사람</th>
							<th>보낸 시간</th>
							<th>상태</th>
							<!-- <th>상태</th> 몇명 읽었는지 0:모두읽음 1:1명안읽음-->
						</tr>
				    </thead>
				    <tbody>
				      <c:if test="${empty list}">
							<tr><td colspan="5">보낸 쪽지가 없습니다.</td></tr>
						</c:if>
						<c:if test="${not empty list}"> <!-- RNO, IDX, SUBJECT, CONTENT, SENDER, SSTATUS, NAME, TEAMNUM, IMG, writedate -->
							<c:forEach var="sender" items="${list}" varStatus="status">
								<tr class="line">
									<td width="10%"><input type="checkbox" value="${sender.idx}"><input type="hidden" value="${sender.idx}"/></td>
									<td width="15%" onClick="goUserInfo('${sender.sender}')"><img src="<%=request.getContextPath()%>/resources/images/${sender.img}" class="imgs"> ${sender.name}</td>
									<td onClick="goView('${sender.idx}', '${userTeam.teamNum}');" width="20%">${sender.subject}</td>
									<td width="30%">${sender.names}</td>
									<td width="20%">${sender.writedate}</td>
									<td width="5%">${sender.read}</td>
								</tr>
							</c:forEach>
						</c:if>	
				    </tbody>
				  </table>
				</div>
				</div>
				<%-- <table>
					<thead>
						<tr style="background-color:black; color:white;" >
							<th>번호</th>
							<th>보낸사람</th>
							<th>제목</th>
							<th>받은사람</th>
							<th>보낸 시간</th>
							<th>상태</th>
							<!-- <th>상태</th> 몇명 읽었는지 0:모두읽음 1:1명안읽음-->
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr><td colspan="5">보낸 쪽지가 없습니다.</td></tr>
						</c:if>
						<c:if test="${not empty list}"> <!-- RNO, IDX, SUBJECT, CONTENT, SENDER, SSTATUS, NAME, TEAMNUM, IMG, writedate -->
							<c:forEach var="sender" items="${list}" varStatus="status">
								<tr class="line">
									<td><input type="checkbox" value="${sender.idx}"><input type="hidden" value="${sender.idx}"/></td>
									<td><img src="<%=request.getContextPath()%>/resources/images/${sender.img}" class="imgs"> ${sender.name}</td>
									<td onClick="goView('${sender.idx}', '${userTeam.teamNum}');">${sender.subject}</td>
									<td>${sender.names}</td>
									<td>${sender.writedate}</td>
									<td>${sender.read}</td>
								</tr>
							</c:forEach>
						</c:if>	
					</tbody>
				</table> --%>
			</div>
			<div style="border:0px solid black; float:right; margin-top:-15px; margin-right:80px; ">
				<button type="button" id="write" class="btn btn-default">글쓰기</button>
				<button type="button" id="del" class="btn btn-default">삭제</button>
			</div>
		</div>
		<div style="border:0px solid gray" align="center">
			${pagebar}
		</div>
	</div>
	<form name="view">
		<input type="hidden" name="idx">
		<input type="hidden" name="teamNum">
	</form>
	<form name="del">
		<input type="hidden" name="idx">
	</form>
</body>
<div class="modal fade modal-center" id="userinfo" role="dialog">
	<div class="modal-dialog modal-sm modal-center">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">회원 상세 정보</h4>
			</div>
			<div class="modal-body">
			<p></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</html>