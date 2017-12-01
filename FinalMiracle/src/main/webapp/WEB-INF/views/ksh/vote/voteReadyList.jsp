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
		searchKeep();
		
		$("#sizePerPage").change(function(){
			goSizePerPage();
		});
	});
	
	function searchKeep(){
		<c:if test="${(colname != 'null' && not empty colname) && (search != 'null' && not empty search)}"> /* colname과 search가 비어있지 않다라면 */
			$("#colname").val("${colname}");//검색시 컬럼명을 유지시켜보자
			$("#search").val("${search}");//검색어 대한 검색어를 유지시켜보자
		</c:if>
		$("#sizePerPage").val("${sizePerPage}");
	}
	
	function goSearch(){
		var frm = document.listFrm;
		var search = $("#search").val();
		
		if(search.trim() == ""){
			alert("검색어를 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
	
	function goDel(idx){
		
		if(confirm("투표를 삭제하시겠습니까?")){
			var frm = document.idxFrm;
			
			frm.idx.value = idx;
			
			frm.action = "voteDel.mr";
			frm.submit();
		}
		
	}
	
	function goSizePerPage(){
		var frm = document.listFrm;
		
		frm.submit();
	}
	
	
</script>

<form id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/voteReadyList.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 10%; border: solid 0px red;">
	<h1>투표목록</h1>
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'">진행중 투표</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteReadyList.mr'">시작전 투표</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteEndList.mr'">종료된 투표</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteMyList.mr'">나의 투표</button>&nbsp;
		<br/>전체 <span style="color: red; font-weight: bold;">${totalCount}</span>&nbsp;
		목록 수 : 
		<select name="sizePerPage" id="sizePerPage">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
		</select>
	</div>
	
	
	<table id="table">
		<thead>
			<tr>
				<th style="width: 100px;">투표번호</th>
				<th style="width: 100px;">팀번호</th>
				<th style="width: 100px;">팀원번호</th>
				<th style="width: 200px;">제목</th>
				<th style="width: 360px;">내용</th>
				<th style="width: 100px;">시작날짜</th>
				<th style="width: 100px;">종료날짜</th>
				<th style="width: 150px;">문항</th>
				<th style="width: 150px;">비고</th>
				<th style="width: 300px;">차트</th>
			</tr>
		</thead>
		
		<c:if test="${not empty voteReadyList}">
		<tbody>
			<c:forEach var="votevo" items="${voteReadyList}" varStatus="status">
				<c:set value="${votevo.IDX}" var="voteidx" />
				<tr>
					<td>${votevo.IDX}</td>
					<td>${votevo.FK_TEAM_IDX}</td>
					<td>${votevo.FK_TEAMWON_IDX}</td>
					<td>${votevo.SUBJECT}</td>
					<td>${votevo.CONTENT}</td>
					<td>${votevo.STARTDATE}</td>
					<td>${votevo.ENDDATE}</td>
					<td>
						<c:forEach var="voteitemvo" items="${voteItemList}" varStatus="status">
							<c:set value="${voteitemvo.fk_vote_idx}" var="voteitemidx" />
							<c:if test="${voteidx eq voteitemidx}">
								* ${voteitemvo.item} : ${voteitemvo.votenum}표<br/>
							</c:if>
						</c:forEach>
					</td>
					<td>
						<%-- <c:if test="${voteidx eq sessionScope.idx}"> --%>
							<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteEdit.mr?idx=${votevo.IDX}'">투표수정</button>
							<button type="button" onClick="goDel('${votevo.IDX}');">투표삭제</button>&nbsp;
						<%-- </c:if> --%>
					</td>
					<td></td>
				</tr>
			</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${empty voteReadyList}">
		<tbody>
			<tr>
				<td colspan="10">투표 목록이 존재하지 않습니다.</td>
			</tr>
		</tbody>
		</c:if>

	</table>	
	<br/>
	
	<!-- ==== 페이지바 ==== -->
	<div align="center" style="width: 70%; margin-left: 50px;">
		${pagebar}
	</div>
	
	<!-- ==== 투표 검색창 ==== -->
		<select name="colname" id="colname">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<!-- <option value="name">글쓴이</option> -->
		</select>
		<input type="text" name="search" id="search" size="40" />
		<button type="button" onclick="goSearch();">검색</button>
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteAdd.mr'">투표작성</button>&nbsp;
	</div>
	

</div>
</form>

<form name="choiceFrm" action="<%= request.getContextPath() %>/voteChoice.mr" method="get" enctype="multipart/form-data">
	<input type="hidden" name="vote_idx"/>
	<input type="hidden" name="teamwon_idx"/>
	<input type="hidden" name="voteitem_idx"/>
	<input type="hidden" name="gobackURL" />
</form>

<form name="idxFrm">
	<input type="hidden" name="idx" />
	<input type="hidden" name="gobackURL" value="${gobackURL}">
</form>