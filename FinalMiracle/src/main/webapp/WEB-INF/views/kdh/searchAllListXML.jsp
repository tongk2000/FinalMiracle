<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<searchAllList>
	<projectSize>${mapOfSearchAll.projectSearchAll.size()}</projectSize>
	<c:forEach var="project" items="${mapOfSearchAll.projectSearchAll}">
		<project>
			<subject>${project.subject}</subject>
			<idx>${project.idx}</idx>
			<category>${project.category}</category>
		</project>
	</c:forEach>
	
	<noticeSize>${mapOfSearchAll.noticeSearchAll.size()}</noticeSize>
	<c:forEach var="notice" items="${mapOfSearchAll.noticeSearchAll}">
		<notice>
			<subject>${notice.subject}</subject>
			<idx>${notice.idx}</idx>
		</notice>
	</c:forEach>
	
	<mindSize>${mapOfSearchAll.mindSearchAll.size()}</mindSize>
	<c:forEach var="mind" items="${mapOfSearchAll.mindSearchAll}">
		<mind>
			<subject>${mind.subject}</subject>
			<idx>${mind.idx}</idx>
		</mind>
	</c:forEach>
	
	<freeSize>${mapOfSearchAll.freeSearchAll.size()}</freeSize>
	<c:forEach var="free" items="${mapOfSearchAll.freeSearchAll}">
		<free>
			<subject>${free.subject}</subject>
			<idx>${free.idx}</idx>
		</free>
	</c:forEach>
</searchAllList>