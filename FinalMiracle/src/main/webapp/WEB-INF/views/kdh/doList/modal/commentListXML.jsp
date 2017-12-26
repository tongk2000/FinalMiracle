<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<comments>
	<c:forEach var="fcvo" items="${map.folder_commentList}">
		<comment>
			<idx>${fcvo.idx}</idx>
			<userid>${fcvo.userid}</userid>
			<content>${fcvo.content}</content>
			<writeDate>${fcvo.writeDate}</writeDate>
		</comment>
	</c:forEach>
	<pageBar>${map.pvo.pageBar}</pageBar>
</comments>