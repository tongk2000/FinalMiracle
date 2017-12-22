<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<style type="text/css">

	.subjectstyle {font-weight: bold;
    	           color: navy;
    	           cursor: pointer; }
    	           
   	.addrInfo { font-weight: bold; }
  	
  	#table {border-collapse: collaps; width: 100%;}
  	#table th, #table td {padding: 5px; border: 1px solid lightgray;}
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
			swal("검색어를 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
	
	function goSearch2(){
		var frm = document.listFrm;
		var search = $("#search2").val();
		
		if(search.trim() == ""){
			swal("검색어를 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
	
	function goWithDraw(idx){
		var frm = document.idxFrm;
		
		/* if(confirm("탈퇴 요청을 승인하시겠습니까?")){
			frm.idx.value = idx;
			frm.method = "post";
			frm.action = "tmWithdrawEnd.mr";
			frm.submit();
		} */
		
		swal({
		  title: "탈퇴 요청",
		  text: "탈퇴 요청을 승인하시겠습니까?",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-danger",
		  confirmButtonText: "승인",
		  cancelButtonText: "취소",
		  closeOnConfirm: false,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  if (isConfirm) {
			frm.idx.value = idx;
			frm.method = "post";
			frm.action = "tmWithdrawEnd.mr";
			frm.submit();
		  }
		});
	}
	
	function goRestore(idx){
		var frm = document.idxFrm;
		
		/* if(confirm("해당 팀원을 복구시키겠습니까?")){
			frm.idx.value = idx;
			frm.method = "post";
			frm.action = "tmRestore.mr";
			frm.submit();
		} */
		
		swal({
		  title: "팀원 복구",
		  text: "해당 팀원을 복구시키겠습니까?",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-primary",
		  confirmButtonText: "복구",
		  cancelButtonText: "취소",
		  closeOnConfirm: false,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  if (isConfirm) {
		    frm.idx.value = idx;
			frm.method = "post";
			frm.action = "tmRestore.mr";
			frm.submit();
		  }
		});
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

</script>

<form class="form-inline" id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/tmWithdrawList.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 1%; padding-right: 1%; border: solid 0px red; width: 100%; height: 840px; overflow-y: auto; font-family: verdana;">
	<div style="width: 100%;">
		<div style="float: left; margin-top: 2%;">
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
		</div>
		<div style="float: right;">
			<h1>탈퇴 요청 목록</h1>
		</div>
	</div>

	<div style="margin-top: 7%;">
		<div style="float: right; margin-bottom: 1%">
			전체 <span style="color: red; font-weight: bold;">${totalCount1}</span>&nbsp;
			목록 수 : 
			<select name="sizePerPage1" id="sizePerPage1" class="form-control">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>
		</div>
	</div>
	
	<div style="width: 100%; margin-top: 6%;">
		<table id="table" class="table table-striped">
			<!-- <thead>
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
			</thead> -->
			
			<c:if test="${not empty reqwdList}">
			<tbody>
				<c:set var="i" value="0" />
				<c:set var="j" value="3" />
				<c:forEach var="req" items="${reqwdList}" varStatus="status">
					<c:if test="${i%j == 0 }">
					<tr>
					</c:if>
						<td style="width: 33%;">
							<div style="width: 100px; float: left; margin-left: 10px;">
								<br/><br/>
								<img src="<%= request.getContextPath() %>/resources/files/${req.IMG}" style="width:100px; heigth:100px; border-radius: 50%;">
							</div>
							<div style="float: left; margin-left: 10px; padding-top: 10px; padding-bottom: 10px;">
								<span style="font-weight: bold;">${req.NAME}(${req.USERID})</span><br/>
								<span class="addrInfo">가입일 : </span>${req.REGDATE}<br/>
								<span class="addrInfo">요청일 : </span>${req.DISDATE}<br/>
								<button type="button" class="btn btn-danger" id="btnWithDraw" name="btnWithDraw" onclick="goWithDraw('${req.IDX}');">탈퇴처리</button>
								<button type="button" class="btn btn-primary" id="btnWithDraw" name="btnWithDraw" onclick="goWithDrawCancle('${req.IDX}');">탈퇴취소</button>
							</div>
						</td>
					<c:if test="${i%j == j-1 }">
					</tr>
					</c:if>
					<c:set var="i" value="${i+1}" />
				</c:forEach>
			</tbody>
			</c:if>
			
			<c:if test="${empty reqwdList}">
			<tbody>
				<tr>
					<td colspan="3" style="padding: 15px; text-align: center;">요청 목록이 존재하지 않습니다.</td>
				</tr>
			</tbody>
			</c:if>
	
		</table>	
		<br/>
	</div>

	<div style="width: 100%;">
		<!-- ==== 페이지바 ==== -->
		<div align="center" style="float: left;">
			${pagebar1}
		</div>
		
		<!-- ==== 검색창 ==== -->
		<div align="center" style="float: right;">
			<select name="colname1" id="colname1" class="form-control">
				<option value="userid1">아이디</option>
				<option value="name1">성명</option>
				<!-- <option value="name">글쓴이</option> -->
			</select>
			<input type="text" name="search1" id="search1" size="40" class="form-control" placeholder="검색할 단어를 입력해주세요" />
			<button type="button" class="btn btn-default" onclick="goSearch1();">검색</button>
		</div>
	</div>

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
	<div style="width: 100%;">
		<div style="float: left; margin-top: 2%;">
			<button type="button" class="btn btn-primary" onClick="javascript:location.href='<%= request.getContextPath() %>/tmList.mr'">팀원 리스트</button>&nbsp;
			<button type="button" class="btn btn-primary" onClick="javascript:location.href='<%= request.getContextPath() %>/tmAddress.mr'">주소록</button>&nbsp;
			<c:if test="${teamwon_status.equals('1')}">	
				<button type="button" class="btn btn-danger" onClick="goWithdraw();">팀 탈퇴</button>&nbsp;
			</c:if>
			<c:if test="${teamwon_status.equals('2')}">
				<button type="button" class="btn btn-primary" onClick="goInvite();">팀원 초대</button>&nbsp;
				<button type="button" class="btn btn-primary" onClick="javascript:location.href='<%= request.getContextPath() %>/tmWithdrawList.mr'">팀원 탈퇴목록</button>&nbsp;
				<button type="button" class="btn btn-danger" onClick="javascript:location.href='<%= request.getContextPath() %>/tmDisband.mr'">팀 해체</button>&nbsp;
			</c:if>
		</div>
		<div style="float: right;">
			<h1>탈퇴 목록</h1>
		</div>
	</div>
	
	<div style="margin-top: 7%;">
		<div style="float: right; margin-bottom: 1%">
			전체 <span style="color: red; font-weight: bold;">${totalCount2}</span>&nbsp;
			목록 수 : 
			<select name="sizePerPage2" id="sizePerPage2" class="form-control">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>
		</div>
	</div>
	
	<div style="width: 100%; margin-top: 6%;">
		<table id="table" class="table table-striped">
			<!-- <thead>
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
			</thead> -->
			
			<c:if test="${not empty wdList}">
			<tbody>
				<c:set var="i" value="0" />
				<c:set var="j" value="3" />
				<c:forEach var="wd" items="${wdList}" varStatus="status">
					<c:if test="${i%j == 0 }">
					<tr>
					</c:if>
						<td style="width: 33%;">
							<div style="width: 100px; float: left; margin-left: 10px;">
								<br/><br/>
								<img src="<%= request.getContextPath() %>/resources/files/${wd.IMG}" style="width:100px; heigth:100px; border-radius: 50%;">
							</div>
							<div style="float: left; margin-left: 10px; padding-top: 10px; padding-bottom: 10px;">
								<span style="font-weight: bold;">${wd.NAME}(${wd.USERID})</span><br/>
								<span class="addrInfo">가입일 : </span>${wd.REGDATE}<br/>
								<span class="addrInfo">탈퇴일 : </span>${wd.REGDATE}<br/>
								<button type="button" class="btn btn-success" id="btnRestore" name="btnRestore" onclick="goRestore('${wd.IDX}');">복구</button>
							</div>
						</td>
					<c:if test="${i%j == j-1 }">
					</tr>
					</c:if>
					<c:set var="i" value="${i+1}" />
				</c:forEach>
			</tbody>
			</c:if>
			
			<c:if test="${empty wdList}">
			<tbody>
				<tr>
					<td colspan="3" style="padding: 15px; text-align: center;">탈퇴 목록이 존재하지 않습니다.</td>
				</tr>
			</tbody>
			</c:if>
	
		</table>	
		<br/>
	</div>

	<div style="width: 100%;">
		<!-- ==== 페이지바 ==== -->
		<div align="center" style="float: left;">
			${pagebar2}
		</div>
		
		<!-- ==== 검색창 ==== -->
		<div align="center" style="float: right;">
			<select name="colname2" id="colname2" class="form-control">
				<option value="userid2">아이디</option>
				<option value="name2">성명</option>
				<!-- <option value="name">글쓴이</option> -->
			</select>
			<input type="text" name="search2" id="search2" size="40" class="form-control" placeholder="검색할 단어를 입력해주세요" />
			<button type="button" class="btn btn-default" onclick="goSearch2();">검색</button>
		</div>
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