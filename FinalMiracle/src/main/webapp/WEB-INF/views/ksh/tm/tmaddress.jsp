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
	
	function goSearch(){
		var frm = document.listFrm;
		var search = $("#search").val();
		
		if(search.trim() == ""){
			swal("검색어를 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
	
	function goWithdraw(){
		
		<%-- if(confirm("정말로 팀에서 탈퇴하시겠습니까?")){

			location.href="<%= request.getContextPath() %>/tmWithdraw.mr";
		} --%>
		
		swal({
		  title: "탈퇴 여부",
		  text: "정말로 탈퇴하시겠습니까?",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-danger",
		  confirmButtonText: "탈퇴",
		  cancelButtonText: "취소",
		  closeOnConfirm: false,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  if (isConfirm) {
			 location.href="<%= request.getContextPath() %>/tmWithdraw.mr";
		  }
		});
	}
	
	function goInvite(){
		var frm = document.inviteFrm;
		/* var inputemail = prompt("초대하고 싶은 팀원의 이메일을 입력해주세요.", "")
		
		if(inputemail != null){
			frm.email.value = inputemail;
			frm.action = "tmInvite.mr";
			frm.submit();
		} */
		
		swal({
		  title: "팀원 초대",
		  text: "초대하고 싶은 팀원의 이메일을 입력해주세요.",
		  type: "input",
		  showCancelButton: true,
		  closeOnConfirm: false,
		  inputPlaceholder: "메일 주소"
		}, function (inputValue) {
		  if (inputValue === false) return false;
		  if (inputValue === "") {
		    swal.showInputError("메일 주소가 입력되지 않았습니다.");
		    return false;
		  }
		    frm.email.value = inputValue;
			frm.action = "tmInvite.mr";
			frm.submit();
		});
	}
	
	function goDisband(){
		var frm = document.DisbandFrm;
		/* var password = prompt("팀장의 비밀번호를 입력해주세요.", "")
		
		if(password != null){
			frm.pwd.value = password;
			frm.method = "post";
			frm.action = "tmDisband.mr";
			frm.submit();
		} */
		
		swal({
		  title: "팀 해체",
		  text: "팀장의 비밀번호를 입력해주세요.",
		  type: "input",
		  inputType: "password",
		  showCancelButton: true,
		  closeOnConfirm: false,
		  inputPlaceholder: "비밀번호"
		}, function (inputValue) {
		  if (inputValue === false) return false;
		  if (inputValue === "") {
		    swal.showInputError("비밀번호가 입력되지 않았습니다.");
		    return false;
		  }
		    frm.pwd.value = inputValue;
			frm.method = "post";
			frm.action = "tmDisband.mr";
			frm.submit();
		});
	}
	
	function goEmail(email){
		
		window.open("tmWriteEmail.mr?email="+email, "subwinpop", "left=500px, top=500px, width=800px, height=600px");
	}

</script>


<form class="form-inline" id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/tmAddress.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 1%; padding-right: 1%; border: solid 0px red; width: 100%; height: 840px; overflow-y: auto;">
	<h1>주소록</h1>
	
	<div style="margin-top: 20px;">
		<button type="button" class="btn btn-primary" onClick="javascript:location.href='<%= request.getContextPath() %>/tmList.mr'">팀원 리스트</button>&nbsp;
		<button type="button" class="btn btn-primary" onClick="javascript:location.href='<%= request.getContextPath() %>/tmAddress.mr'">주소록</button>&nbsp;
		<c:if test="${teamwon_status.equals('1')}">	
			<button type="button" class="btn btn-danger" onClick="goWithdraw();">팀 탈퇴</button>&nbsp;
		</c:if>
		<c:if test="${teamwon_status.equals('2')}">
			<button type="button" class="btn btn-primary" onClick="goInvite();">팀원 초대</button>&nbsp;
			<button type="button" class="btn btn-primary" onClick="javascript:location.href='<%= request.getContextPath() %>/tmWithdrawList.mr'">팀원 탈퇴목록</button>&nbsp;
			<button type="button" class="btn btn-danger" onClick="goDisband();">팀 해체</button>&nbsp;
		</c:if>
		<br/>전체 <span style="color: red; font-weight: bold;">${totalCount}</span>&nbsp;
		목록 수 : 
		<select name="sizePerPage" id="sizePerPage" class="form-control">
			<option value="5">5</option>
			<option value="10">10</option>
			<option value="15">15</option>
			<option value="20">20</option>
		</select>
	</div>
	
	
	<table id="table">
		<thead>
			<tr>
				<th style="width: 5%;">팀원번호</th>
				<th style="width: 5%;">팀원아이디</th>
				<th style="width: 5%;">팀원이름</th>
				<th style="width: 10%;">생년월일</th>
				<th style="width: 10%;">연락처</th>
				<th style="width: 15%;">이메일</th>
				<th style="width: 5%;">우편번호</th>
				<th style="width: 25%;">주소</th>
				<th style="width: 20%;">소개글</th>
			</tr>
		</thead>
		
		<c:if test="${not empty tmAddrList}">
		<tbody>
			<c:forEach var="tmAddr" items="${tmAddrList}" varStatus="status">
				<tr>
					<td>${tmAddr.IDX}</td>
					<td>${tmAddr.USERID}</td>
					<td>${tmAddr.NAME}</td>
					<td>${tmAddr.BIRTH1}년 ${tmAddr.BIRTH2}월 ${tmAddr.BIRTH3}일</td>
					<td>${tmAddr.HP1}-${tmAddr.HP2}-${tmAddr.HP3}</td>
					<td><a href="javascript:goEmail('${tmAddr.EMAIL}');">${tmAddr.EMAIL}</a></td>
					<td>${tmAddr.POST1}-${tmAddr.POST2}</td>
					<td>${tmAddr.ADDR1}<br/>${tmAddr.ADDR2}</td>
					<td>${tmAddr.PROFILE}</td>
				</tr>
			</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${empty tmAddrList}">
		<tbody>
			<tr>
				<td colspan="10">팀원 목록이 존재하지 않습니다.</td>
			</tr>
		</tbody>
		</c:if>

	</table>	
	<br/>

	<!-- ==== 페이지바 ==== -->
	<div align="center" style="width: 100%;">
		${pagebar}
	</div>
	
	<!-- ==== 투표 검색창 ==== -->
	<div align="center" style="width: 100%;">
		<select name="colname" id="colname" class="form-control">
			<option value="userid">아이디</option>
			<option value="name">성명</option>
			<!-- <option value="name">글쓴이</option> -->
		</select>
		<input type="text" name="search" id="search" size="40" class="form-control" placeholder="검색할 단어를 입력해주세요" />
		<button type="button" class="btn btn-default" onclick="goSearch();">검색</button>
	</div>
	

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