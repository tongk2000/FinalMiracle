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
		
		$("#sizePerPage1").change(function(){
			goSizePerPage1();
		});
		
		$("#sizePerPage2").change(function(){
			goSizePerPage2();
		});
	
	});
	
	function searchKeep(){
		<c:if test="${(colname1 != 'null' && not empty colname1) && (search1 != 'null' && not empty search1)}"> /* colname과 search가 비어있지 않다라면 */
			$("#colname1").val("${colname1}");//검색시 컬럼명을 유지시켜보자
			$("#search1").val("${search1}");//검색어 대한 검색어를 유지시켜보자
		</c:if>
		<c:if test="${(colname2 != 'null' && not empty colname2) && (search2 != 'null' && not empty search2)}"> /* colname과 search가 비어있지 않다라면 */
			$("#colname2").val("${colname2}");//검색시 컬럼명을 유지시켜보자
			$("#search2").val("${search2}");//검색어 대한 검색어를 유지시켜보자
		</c:if>	
		
		$("#sizePerPage1").val("${sizePerPage1}");
		
		$("#sizePerPage2").val("${sizePerPage2}");
	}
	
	function goSizePerPage1(){
		var frm = document.listFrm;
		
		frm.submit();
	}
	
	function goSizePerPage2(){
		var frm = document.listFrm;
		
		frm.submit();
	}
	
	function goSearch1(){
		var frm = document.listFrm;
		var search = $("#search1").val();
		
		if(search.trim() == ""){
			alert("검색어를 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
	
	function goSearch2(){
		var frm = document.listFrm;
		var search = $("#search2").val();
		
		if(search.trim() == ""){
			alert("검색어를 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
	
	function goWithDraw(idx){
		var frm = document.idxFrm;
		
		if(confirm("탈퇴 요청을 승인하시겠습니까?")){
			frm.idx.value = idx;
			frm.method = "post";
			frm.action = "tmWithdrawEnd.mr";
			frm.submit();
		}
	}
	
	function goRestore(idx){
		var frm = document.idxFrm;
		
		if(confirm("해당 팀원을 복구시키겠습니까?")){
			frm.idx.value = idx;
			frm.method = "post";
			frm.action = "tmRestore.mr";
			frm.submit();
		}
	}
	
	function goWithdraw(idx){
		var frm = document.idxFrm;
		
		if(confirm("탈퇴 처리를 하시겠습니까?")){
			frm.idx.value = idx;
			frm.method = "post";
			frm.action = "tmWithdrawEnd.mr";
			frm.submit();
		}
	}
	
	function goWithDrawCancle(idx){
		var frm = document.idxFrm;
		
		frm.idx.value = idx;
		frm.method = "post";
		frm.action = "tmWithdrawCancel.mr";
		frm.submit();
	}
	
	function goInvite(){
		var frm = document.inviteFrm;
		var inputemail = prompt("초대하고 싶은 팀원의 이메일을 입력해주세요.", "")
		
		if(inputemail != null){
			frm.email.value = inputemail;
			frm.method = "get";
			frm.action = "tmInvite.mr";
			frm.submit();
		}
		
		
	}
	
	function goDisband(){
		var frm = document.DisbandFrm;
		var password = prompt("팀장의 비밀번호를 입력해주세요.", "")
		
		if(password != null){
			frm.pwd.value = password;
			frm.method = "post";
			frm.action = "tmDisband.mr";
			frm.submit();
		}

	}

</script>

<form id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/tmWithdrawList.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 1%; padding-right: 1%; border: solid 0px red; width: 100%; height: 840px; overflow-y: auto;">
	<h1>탈퇴 요청 목록</h1>
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/tmList.mr'">팀원 리스트</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/tmAddress.mr'">주소록</button>&nbsp;
		<c:if test="${teamwon_status.equals('1')}">	
			<button type="button" onClick="goWithdraw();">팀 탈퇴</button>&nbsp;
		</c:if>
		<c:if test="${teamwon_status.equals('2')}">
			<button type="button" onClick="goInvite();">팀원 초대</button>&nbsp;
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/tmWithdrawList.mr'">팀원 탈퇴목록</button>&nbsp;
			<button type="button" onClick="goDisband();">팀 해체</button>&nbsp;
		</c:if>
		<br/>전체 <span style="color: red; font-weight: bold;">${totalCount1}</span>&nbsp;
		목록 수 : 
		<select name="sizePerPage1" id="sizePerPage1">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
		</select>
	</div>
	
	
	<table id="table">
		<thead>
			<tr>
				<th style="width: 11%;">팀원번호</th>
				<th style="width: 11%;">팀번호</th>
				<th style="width: 11%;">회원번호</th>
				<th style="width: 11%;">아이디</th>
				<th style="width: 11%;">성명</th>
				<th style="width: 11%;">상태값</th>
				<th style="width: 11%;">가입날짜</th>
				<th style="width: 11%;">요청날짜</th>
				<th style="width: 12%;">비고</th>
			</tr>
		</thead>
		
		<c:if test="${not empty reqwdList}">
		<tbody>
			<c:forEach var="req" items="${reqwdList}" varStatus="status">
				<tr>
					<td>${req.IDX}</td>
					<td>${req.FK_TEAM_IDX}</td>
					<td>${req.FK_MEMBER_IDX}</td>
					<td>${req.USERID}</td>
					<td>${req.NAME}</td>
					<td>${req.STATUS}</td>
					<td>${req.REGDATE}</td>
					<td>${req.DISDATE}</td>
					<td>
						<button type="button" id="btnWithDraw" name="btnWithDraw" onclick="goWithDraw('${req.IDX}');">탈퇴처리</button><br/>
						<button type="button" id="btnWithDraw" name="btnWithDraw" onclick="goWithDrawCancle('${req.IDX}');">탈퇴취소</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${empty reqwdList}">
		<tbody>
			<tr>
				<td colspan="10">요청 목록이 존재하지 않습니다.</td>
			</tr>
		</tbody>
		</c:if>

	</table>	
	<br/>

	<!-- ==== 페이지바 ==== -->
	<div align="center" style="width: 70%; margin-left: 50px;">
		${pagebar1}
	</div>
	
	<!-- ==== 검색창 ==== -->
	<select name="colname1" id="colname1">
		<option value="userid1">아이디</option>
		<option value="name1">성명</option>
		<!-- <option value="name">글쓴이</option> -->
	</select>
	<input type="text" name="search1" id="search1" size="40" />
	<button type="button" onclick="goSearch1();">검색</button>

<br/><br/><br/>

	<h1>탈퇴 목록</h1>
	
	<div style="margin-top: 20px;">
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/tmList.mr'">팀원 리스트</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/tmAddress.mr'">주소록</button>&nbsp;
		<c:if test="${teamwon_status.equals('1')}">	
			<button type="button" onClick="goWithdraw();">팀 탈퇴</button>&nbsp;
		</c:if>
		<c:if test="${teamwon_status.equals('2')}">
			<button type="button" onClick="goInvite();">팀원 초대</button>&nbsp;
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/tmWithdrawList.mr'">팀원 탈퇴목록</button>&nbsp;
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/tmDisband.mr'">팀 해체</button>&nbsp;
		</c:if>
		<br/>전체 <span style="color: red; font-weight: bold;">${totalCount2}</span>&nbsp;
		목록 수 : 
		<select name="sizePerPage2" id="sizePerPage2">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
		</select>
	</div>
	
	
	<table id="table">
		<thead>
			<tr>
				<th style="width: 11%;">팀원번호</th>
				<th style="width: 11%;">팀번호</th>
				<th style="width: 11%;">회원번호</th>
				<th style="width: 11%;">아이디</th>
				<th style="width: 11%;">성명</th>
				<th style="width: 11%;">상태값</th>
				<th style="width: 11%;">가입날짜</th>
				<th style="width: 11%;">요청날짜</th>
				<th style="width: 12%;">비고</th>
			</tr>
		</thead>
		
		<c:if test="${not empty wdList}">
		<tbody>
			<c:forEach var="wd" items="${wdList}" varStatus="status">
				<tr>
					<td>${wd.IDX}</td>
					<td>${wd.FK_TEAM_IDX}</td>
					<td>${wd.FK_MEMBER_IDX}</td>
					<td>${wd.USERID}</td>
					<td>${wd.NAME}</td>
					<td>${wd.STATUS}</td>
					<td>${wd.REGDATE}</td>
					<td>${wd.DISDATE}</td>
					<td><button type="button" id="btnRestore" name="btnRestore" onclick="goRestore('${wd.IDX}');">복구</button></td>
				</tr>
			</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${empty wdList}">
		<tbody>
			<tr>
				<td colspan="10">탈퇴 목록이 존재하지 않습니다.</td>
			</tr>
		</tbody>
		</c:if>

	</table>	
	<br/>

	<!-- ==== 페이지바 ==== -->
	<div align="center" style="width: 70%; margin-left: 50px;">
		${pagebar2}
	</div>
	
	<!-- ==== 검색창 ==== -->
	<select name="colname2" id="colname2">
		<option value="userid2">아이디</option>
		<option value="name2">성명</option>
		<!-- <option value="name">글쓴이</option> -->
	</select>
	<input type="text" name="search2" id="search2" size="40" />
	<button type="button" onclick="goSearch2();">검색</button>
	

</div>

</form>

<form name="idxFrm">
	<input type="hidden" name="idx" />
	<input type="hidden" name="gobackURL" value="${gobackURL}">
</form>

<form name="inviteFrm">
	<input type="hidden" name="email" />
</form>

<form name="DisbandFrm">
	<input type="hidden" name="pwd" />
</form>