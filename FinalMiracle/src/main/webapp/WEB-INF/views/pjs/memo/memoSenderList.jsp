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
</style>
<script>

</script>
<meta charset="UTF-8">
<title>쪽지</title>
</head>
<body>
	<div style="border:1px solid red; padding:5px;]" class="container">
		<div style="border:1px solid green; padding:5px;" align="center">
			<div style="border:1px solid purple;">
			<a href="<%=request.getContextPath()%>/memoreceiver.mr"><span style="color:red;">쪽지 쓰기</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memomemory.mr"><span style="color:red;">보낸 쪽지</span></a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="<%=request.getContextPath()%>/memoreceiver.mr"><span style="color:red;">받은 쪽지</span></a>
			</div>
			<div style="border:1px solid pink; padding:5px;">
				<table>
					<thead>
						<tr style="background-color:black; color:white;">
							<th>번호</th>
							<th>아이디</th>
							<th>제목</th>
							<th>내용</th>
							<th>보낸 시간</th>
							<!-- <th>상태</th> 몇명 읽었는지 0:모두읽음 1:1명안읽음-->
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}">
							<tr><td colspan="5">보낸 쪽지가 없습니다.</td></tr>
						</c:if>
						<c:if test="${not empty list}"> <!-- RNO, IDX, SUBJECT, CONTENT, SENDER, SSTATUS, NAME, TEAMNUM, IMG, writedate -->
							<c:forEach var="sender" items="${list}" varStatus="status">
								<tr>
									<td>${status.count}<input type="hidden" value="${sender.idx}"/></td>
									<td><img src="<%=request.getContextPath()%>/resources/images/${sender.img}"> ${sender.name}</td>
									<td>${sender.subject}</td>
									<td>${sender.content}</td>
									<td>${sender.writedate}</td>
								</tr>
							</c:forEach>
						</c:if>	
					</tbody>
				</table>
			</div>
		</div>
		<div style="border:1px solid gray" align="center">
			${pagebar}
		</div>
	</div>
</body>
</html>