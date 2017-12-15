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
	img {
		width:25px;
		height:25px;
	}
	table {
		border:1px solid blue;
		padding:5px;
	}
	tr {
		border:1px solid yellow;
		padding:5px;
	}
	th, td {
		border:1px solid black;
		padding:5px;
	}
	.selectLine {
    	background-color:gray;
    }
    .grayColor {
    	background-color:gray;
    	cursor: pointer;
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
	
</script>
<meta charset="UTF-8">
<title>쪽지</title>
</head>
<body>
	<div style="border:1px solid red; padding:5px;">
		<div style="border:1px solid green; padding:5px;" align="center">
			<div style="border:1px solid purple;">
				<a href="<%=request.getContextPath()%>/memoWrite.mr"><span style="color:red;">쪽지 쓰기</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memomemory.mr"><span style="color:red;">보낸 쪽지</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memoreceiver.mr"><span style="color:red;">받은 쪽지</span></a>
			</div>
			<div style="border:1px solid pink; padding:5px;">
				<table>
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
									<td><img src="<%=request.getContextPath()%>/resources/images/${sender.img}"> ${sender.name}</td>
									<td onClick="goView('${sender.idx}', '${userTeam.teamNum}');">${sender.subject}</td>
									<td>${sender.names}</td>
									<td>${sender.writedate}</td>
									<td>${sender.read}</td>
								</tr>
							</c:forEach>
						</c:if>	
					</tbody>
				</table>
			</div>
			<div style="border:1px solid black; padding-left:400px;">
				<button type="button" id="write">글쓰기</button>
				<button type="button" id="del">삭제</button>
			</div>
		</div>
		<div style="border:1px solid gray" align="center">
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