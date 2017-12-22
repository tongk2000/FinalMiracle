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
		border:1px solid blue;
		padding:5px;
		border-radius:30px;
	}
	
	tr {
		border:1px solid yellow;
		padding:5px;
	}
	th, td {
		border:1px solid black;
		padding:5px;
		text-align:center;
		font-family:verdana;
	} */
	.selectLine {
    	background-color:#eaeaea;
    }
    .grayColor {
    	background-color:#eaeaea;
    	cursor: pointer;
    }
   /*  th {
    	font-size:12pt;
    	background-color:#337ab7;
    	color:white;
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
</style>
<script>
	function goView(idx, teamNum){
		var frm = document.view;
		frm.idx.value = idx;
		frm.teamNum.value = teamNum;
		frm.action = "memoReceiverView.mr";
		frm.method = "get";
		frm.submit();
	}
	$(document).ready(function(){
		$("tr:has(td)").click(function(){ // tr중에서 td를 가지고 있는 tr
			var bool = $(this).hasClass("selectLine"); // 한번 더 클릭하면 클래스 삭제
			if(bool) {
				$(this).removeClass("selectLine");
			}
			else {
				$(this).addClass("selectLine");
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
			<%-- location.href="<%=request.getContextPath()%>/memoreceiverDel.mr?idx="+idx; --%>
			var frm = document.del;
			frm.idx.value=idx;
			frm.action="memoreceiverDel.mr";
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
	
</script>
<meta charset="UTF-8">
<title>쪽지</title>
</head>
<body>
	<div style="border:0px solid red; padding:5px;" class="container">
		<div style="border:0px solid green; padding:5px;" align="center">
			<div style="border:0px solid purple;">
				<a href="<%=request.getContextPath()%>/memoWrite.mr"><span style="color:red;">쪽지 쓰기</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memomemory.mr"><span style="color:red;">보낸 쪽지</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memoreceiver.mr"><span style="color:red;">받은 쪽지</span></a>
			</div>
			<div style="border:0px solid pink; padding:5px;">
				<div class="near_by_hotel_wrapper">
				<div class="near_by_hotel_container">
				  <table class="table no-border custom_table dataTable no-footer dtr-inline">
				    <thead style="background-color:#1f5c87;">
				  		<tr style="background-color:#1f5c87; color:white;">
							<th>번호</th>
							<th>보낸사람</th>
							<th>제목</th>
							<th>받은사람</th>
							<th>상태</th>
							<th>읽은 시간</th>
						</tr>
				    </thead>
				    <tbody>
				       <c:if test="${empty list}"> <!-- // idx, receiver, rreadcount, readdate, subject, content , sender, writedate, name, img -->
							<tr><td colspan="5">보낸 쪽지가 없습니다.</td></tr>
						</c:if>
						<c:if test="${not empty list}">
							<c:forEach var="receiver" items="${list}" varStatus="status">
								<tr class="line">
									<td>${status.count}<input type="hidden" value="${receiver.idx}"/></td>
									<td><img src="<%=request.getContextPath()%>/resources/images/${receiver.img}" class="imgs"> ${receiver.sender}</td>
									<td onClick="goView('${receiver.idx}', '${userTeam.teamNum}');">${receiver.subject}</td>
									<td style="padding-left:10px;">${receiver.receiver}</td>
									<c:if test="${receiver.rreadcount == 0}">
										<td>안읽음</td>
									</c:if>
									<c:if test="${receiver.rreadcount > 0}">
										<td>읽음 </td>
									</c:if>
									<c:if test="${receiver.readdate == null}">
										<td>1</td>
									</c:if>
									<c:if test="${receiver.readdate != null}">
										<td>${receiver.readdate}</td>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>
				    </tbody>
				  </table>
				</div>
				</div>
				<%-- <table>
					<thead style="background-color:#337ab7;">
						<tr style="background-color:#337ab7;">
							<th>번호</th>
							<th>보낸사람</th>
							<th>제목</th>
							<th>받은사람</th>
							<th>상태</th>
							<th>읽은 시간</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}"> <!-- // idx, receiver, rreadcount, readdate, subject, content , sender, writedate, name, img -->
							<tr><td colspan="5">보낸 쪽지가 없습니다.</td></tr>
						</c:if>
						<c:if test="${not empty list}">
							<c:forEach var="receiver" items="${list}" varStatus="status">
								<tr class="line">
									<td>${status.count}<input type="hidden" value="${receiver.idx}"/></td>
									<td><img src="<%=request.getContextPath()%>/resources/images/${receiver.img}" class="imgs"> ${receiver.sender}</td>
									<td onClick="goView('${receiver.idx}', '${userTeam.teamNum}');">${receiver.subject}</td>
									<td>${receiver.receiver}</td>
									<c:if test="${receiver.rreadcount == 0}">
										<td>안읽음</td>
									</c:if>
									<c:if test="${receiver.rreadcount > 0}">
										<td>읽음 </td>
									</c:if>
									<c:if test="${receiver.readdate == null}">
										<td>1</td>
									</c:if>
									<c:if test="${receiver.readdate != null}">
										<td>${receiver.readdate}</td>
									</c:if>
								</tr>
							</c:forEach>
						</c:if>	
					</tbody>
				</table> --%>
			</div>
			<div style="border:0px solid black; padding-left:190px;">
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
</html>


