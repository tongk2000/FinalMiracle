<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style type="text/css">
	table, th, td {border: solid gray 1px;}
	/* #table {border-collapse: collapse; width: 750px;} */
	
	.subjectstyle {font-weight: bold;
    	           color: navy;
    	           cursor: pointer; }
  	
  	/* ==== #142. 파일첨부가 되었으므로 테이블의 가로폭을 늘려보자 ==== */
  	#table {border-collapse: collaps; width: 920px;}
  	#table th, #table td {padding: 5px;}
  	#table th {background-color: #DDDDDD;}
	    
</style>

<script type="text/javascript">
	$(document).ready(function(){
				
	});
	
	
</script>

<div style="padding-left: 10%; border: solid 0px red;">
	<h1>투표목록</h1>
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="">진행중 투표</button>&nbsp;
		<button type="button" onClick="">종료된 투표</button>
	</div>
	
	<table id="table">
		<thead>
			<tr>
				<th style="width: 70px;" >투표번호</th>
				<th style="width: 360px;" >팀원번호</th>
				<th style="width: 70px;" >제목</th>
				<th style="width: 180px;" >내용</th>
				<th style="width: 70px;" >시작날짜</th>
				<th style="width: 70px;">종료날짜</th>
				<th style="width: 100px;">문항</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</tbody>
	</table>
	<br/>
	
	<form name="seqFrm">
		<input type="hidden" name="seq" />
		<input type="hidden" name="gobackURL" />
	</form>

	<!-- ==== 페이지바 ==== -->
	<div align="center" style="width: 70%; margin-left: 50px;">
		
	</div>
	
	<!-- ==== 투표 검색창 ==== -->
	<form name="searchFrm" action="" method="get">
		<select name="colname" id="colname">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<option value="name">성명</option>
		</select>
		<input type="text" name="search" id="search" size="40" />
		<button type="button" onclick="goSearch();">검색</button>
	</form>
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="">투표목록</button>&nbsp;
		<button type="button" onClick="">투표작성</button>
	</div>
	

</div>