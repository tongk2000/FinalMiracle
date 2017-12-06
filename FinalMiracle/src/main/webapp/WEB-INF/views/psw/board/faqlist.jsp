<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style type="text/css">
	table, th, td {border: solid gray 1px;}
	#table {border-collapse: collapse; width: 750px;}
	
	.subjectstyle {font-weight: bold;
    	           color: navy;
    	           cursor: pointer; }
    	           
	    
</style>

 
<script type="text/javascript">
	
	

</script>

<div style="padding-left: 10%; border: 1px solid red;">

	<h1>자주 묻는 질문</h1>
	
	<div>
		<table id="table">
		    <thead>
				<tr>
					<th style="width: 70px;" >글번호</th>
					<th style="width: 360px;" >제목</th>
					<th style="width: 180px;" >게시된 날짜</th>
					<th style="width: 70px;" >조회수</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach var="faq" items="${faqList}" varStatus="status"> 
					<tr>						
						<td>${faq.idx}</td>
						<td>${faq.subject}</td>
						<td>${faq.regDate}</td>
						<td>${faq.readCnt}</td>
					</tr>
				</c:forEach>
			</tbody>
			
		</table>
	</div>
	
	<br/>
	<!-- 
	<form name="seqFrm">
		<input type="hidden" name="seq" />
		<input type="hidden" name="gobackURL" />
	</form>
	 -->
	

	
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/faqList.mr'">글목록</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/faqAdd.mr'">글쓰기</button>
	</div>

</div>







