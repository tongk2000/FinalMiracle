<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   
<style type="text/css">
	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 600px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 480px;}
	.long {width: 470px;}
	.short {width: 120px;} 	
	
	a{text-decoration: none;}	

</style>

<script type="text/javascript">
    function goWrite() {
    	var addWriteFrm = document.addWriteFrm;
    	addWriteFrm.submit();
    }
</script>

<div style="padding-left: 10%; border: solid 0px red;">
	<h1>글내용보기</h1>
	
	<table id="table">
		<tr>
			<th>글번호</th>
			<td>${freevo.idx}</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${freevo.userid}</td>
		</tr>
		<tr>
           	<th>제목</th>
           	<td>${freevo.subject}</td>
        	</tr>
		<tr>
			<th>내용</th>
			<td>${freevo.content}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${freevo.readCnt}</td>
		</tr>
		<tr>
			<th>등록일자</th>
			<td>${freevo.regDate}</td>
		</tr>		
		
	</table>
	
	<br/>
	
	<button type="button" onClick="javascript:location.href='${gobackURL}'">목록보기</button>
	<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/edit.action?seq=${boardvo.seq}'">수정</button>
	<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/del.action?seq=${boardvo.seq}'">삭제</button>
		
	<br/><br/>
	
</div>











