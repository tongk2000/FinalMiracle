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
				<a href="<%=request.getContextPath()%>/memoWrite.mr"><span style="color:red;">쪽지 쓰기</span></a>
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
							<th>보낸이</th>
							<th>제목</th>
							<th>내용</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty list}"> <!-- // idx, receiver, rreadcount, readdate, subject, content , sender, writedate, name, img -->
							<tr><td colspan="5">보낸 쪽지가 없습니다.</td></tr>
						</c:if>
						<c:if test="${not empty list}">
							<c:forEach var="receiver" items="${list}" varStatus="status">
								<tr>
									<td>${status.count}<input type="hidden" value="${receiver.idx}"/></td>
									<td>${receiver.name}</td>
									<td>${receiver.subject}</td>
									<td>${receiver.content}</td>
									<c:if test="${receiver.readdate==null}">
										<td>안읽음</td>
									</c:if>
									<c:if test="${receiver.readdate!=null}">
										<td>읽음 ${receiver.readdate}</td>
									</c:if>
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