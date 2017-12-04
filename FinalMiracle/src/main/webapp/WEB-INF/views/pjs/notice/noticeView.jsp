<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글</title>
</head>
<body>
	<div>
		<div style="align: center;">
			<table>
				<thead>
					<tr>
						<th colspan="2">공지글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>유저 아이디 :</td>
						<td><img src="<%= request.getContextPath() %>/resources/images/${img}"> ${userid}</td>
					</tr>
					<tr>
						<td>제목 :</td>
						<td>${subject}</td>
					</tr>
					<tr>
						<td>내용 :</td>
						<td>${content}</td>
					</tr>
				</tbody>
			</table>
		</div>
</div>
</body>
</html>