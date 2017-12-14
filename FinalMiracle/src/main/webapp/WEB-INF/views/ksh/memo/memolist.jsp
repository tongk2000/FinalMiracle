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
  	#table {border-collapse: collaps; width: 100%;}
  	#table th, #table td {padding: 5px;}
  	#table th {background-color: #DDDDDD;}
	    
</style>

<script type="text/javascript">

	$(document).ready(function(){
		searchKeep();
		
		$("#sizePerPage").change(function(){
			goSizePerPage();
		});
		
		$("#period").change(function(){
			goPeriod();
		});
	
	});
	
	function searchKeep(){
		<c:if test="${(colname != 'null' && not empty colname) && (search != 'null' && not empty search)}"> /* colname과 search가 비어있지 않다라면 */
			$("#colname").val("${colname}");//검색시 컬럼명을 유지시켜보자
			$("#search").val("${search}");//검색어 대한 검색어를 유지시켜보자
		</c:if>
		$("#sizePerPage").val("${sizePerPage}");
		$("#period").val("${period}");
	}
	
	function goSizePerPage(){
		var frm = document.listFrm;
		
		frm.submit();
	}
	
	function goPeriod(){
		var frm = document.listFrm;
		
		frm.submit();
	}
	
	function goEdit(idx){
		var frm = document.idxFrm;
		
		frm.idx.value = idx;
		
		frm.action = "<%= request.getContextPath() %>/memoEdit.mr";
		frm.method = "get";
		frm.submit();
	}
	
	function goGarbage(idx){
		var frm = document.idxFrm;
		
		frm.idx.value = idx;
		
		frm.action = "<%= request.getContextPath() %>/memoGarbage.mr";
		frm.method = "get";
		frm.submit();
	}
	
	function goChkGarbage(){
		var frm = document.listFrm;
		
		frm.action = "<%= request.getContextPath() %>/memoChkGarbage.mr";
		frm.method = "get";
		frm.submit();
	}
	
	function goRestore(idx){
		var frm = document.idxFrm;
		
		frm.idx.value = idx;
		
		frm.action = "<%= request.getContextPath() %>/memoRestore.mr";
		frm.method = "get";
		frm.submit();
	}
	
	function goChkRestore(){
		var frm = document.listFrm;
		
		frm.action = "<%= request.getContextPath() %>/memoChkRestore.mr";
		frm.method = "get";
		frm.submit();
	}
	
	
	function goDel(idx){
		var frm = document.idxFrm;
		
		if(confirm("메모를 삭제하시겠습니까?")){
			frm.idx.value = idx;
			
			frm.action = "<%= request.getContextPath() %>/memoDel.mr";
			frm.method = "post";
			frm.submit();
		}

	}
	
	function goChkDel(){
		var frm = document.listFrm;
		
		if(confirm("선택된 메모들을 삭제하시겠습니까?")){
			
			frm.action = "<%= request.getContextPath() %>/memoChkDel.mr";
			frm.method = "post";
			frm.submit();
		}
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
	
	function allcheck(){
		cbox = listFrm.chk_memo;
	    if(cbox.length) {  // 여러 개일 경우
	        for(var i = 0; i<cbox.length;i++) {
	            cbox[i].checked=listFrm.chk_Allmemo.checked;
	        }
	    } else { // 한 개일 경우
	        cbox.checked=listFrm.chk_Allmemo.checked;
	    }
	}

</script>


<form id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/memoList.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 1%; padding-right: 1%; border: solid 0px red; width: 100%; height: 840px; overflow-y: auto;">
	<h1>메모목록</h1>
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=전체'">전체</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=중요'">중요</button>&nbsp;
		<c:forEach var="folder" items="${folderlist}" varStatus="status">
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=${folder}'">${folder}</button>&nbsp;
		</c:forEach>
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=휴지통'">휴지통</button>&nbsp;
		<br/>전체 <span style="color: red; font-weight: bold;">${totalCount}</span>&nbsp;
		목록 수 : 
		<select name="sizePerPage" id="sizePerPage">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
		</select>
		작성기간 : 
		<select name="period" id="period">
			<option value="-1">전체</option>
			<option value="7">일주일</option>
			<option value="30">1개월</option>
			<option value="90">3개월</option>
			<option value="180">6개월</option>
			<option value="365">1년</option>
		</select>
	</div>
	
	
	<table id="table">
		<thead>
			<tr>
				<th style="width: 5%;" align="center"><input type="checkbox" name="chk_Allmemo" onclick="allcheck();">선택</th>
				<th style="width: 5%;">메모번호</th>
				<th style="width: 5%;">회원번호</th>
				<th style="width: 5%;">팀원번호</th>
				<th style="width: 10%;">제목</th>
				<th style="width: 25%">내용</th>
				<th style="width: 5%;">분류</th>
				<th style="width: 15%;">작성일</th>
				<th style="width: 15%;">최종수정일</th>
				<th style="width: 10%;">비고</th>
			</tr>
		</thead>
		
		<c:if test="${not empty memoList}">
		<tbody>
			<c:forEach var="memovo" items="${memoList}" varStatus="status">
				<c:set var="groups" value="${memovo.groups}" />
				<tr>
					<td align="center"><input type="checkbox" name="chk_memo" value="${memovo.idx}"></td>
					<td>${memovo.idx}</td>
					<td>${memovo.fk_member_idx}</td>
					<td>${memovo.fk_teamwon_idx}</td>
					<td>${memovo.subject}</td>
					<td>${memovo.content}</td>
					<td>${memovo.groups}</td>
					<td>${memovo.regdate}</td>
					<td>${memovo.editdate}</td>
					<td>
						<c:if test="${memovo.groups ne '휴지통'}">
							<button type="button" onClick="goEdit('${memovo.idx}');">메모수정</button>&nbsp;
							<button type="button" onClick="goGarbage('${memovo.idx}');">휴지통</button>&nbsp;
						</c:if>
						<c:if test="${memovo.groups eq '휴지통'}">
							<button type="button" onClick="goRestore('${memovo.idx}');">메모복구</button>&nbsp;
							<button type="button" onClick="goDel('${memovo.idx}');">메모삭제</button>&nbsp;
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${empty memoList}">
		<tbody>
			<tr>
				<td colspan="10">메모 목록이 존재하지 않습니다.</td>
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
		<c:if test="${groups ne '휴지통'}">
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoAdd.mr'">메모작성</button>&nbsp;
			<button type="button" onClick="goChkGarbage();">선택휴지통</button>&nbsp;
		</c:if>
		<c:if test="${groups eq '휴지통'}">
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoAdd.mr'">메모작성</button>&nbsp;
			<button type="button" onClick="goChkRestore();">선택복구</button>&nbsp;
			<button type="button" onClick="goChkDel();">선택삭제</button>&nbsp;
		</c:if>
	</div>
	
	<input type="hidden" name="gobackURL" value="${gobackURL}">

</div>
</form>


<form name="idxFrm">
	<input type="hidden" name="idx" />
	<input type="hidden" name="gobackURL" value="${gobackURL}">
</form>