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
			<h1>주소록</h1>
		</div>
	</div>

	<div style="margin-top: 7%;">
		<div style="float: right; margin-bottom: 1%">
			전체 <span style="color: red; font-weight: bold;">${totalCount}</span>&nbsp;
			목록 수 : 
			<select name="sizePerPage" id="sizePerPage" class="form-control">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>
		</div>
	</div>
	
	<div style="width: 100%; margin-top: 6%;">
		<table id="table" class="table table-striped" style="table-layout: fixed;">
			<!-- <thead>
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
			</thead> -->
			
			<c:if test="${not empty tmAddrList}">
			<tbody>
				<c:set var="i" value="0" />
				<c:set var="j" value="3" />
				<c:forEach var="tmAddr" items="${tmAddrList}" varStatus="status">
					<c:if test="${i%j == 0 }">
					<tr>
					</c:if>
						<td style="width: 33%; word-break: break-all;">
							<div style="width: 100px; float: left; margin-left: 10px;">
								<br/><br/>
								<img src="<%= request.getContextPath() %>/resources/files/${tmAddr.IMG}" style="width:100px; heigth:100px; border-radius: 50%;">
							</div>
							<div style="width: 300px; float: left; margin-left: 10px; padding-top: 10px; padding-bottom: 10px; word-break: break-all;">
								<span style="font-weight: bold;">${tmAddr.NAME}(${tmAddr.USERID})</span><br/>
								<span class="addrInfo">생일 : </span>${tmAddr.BIRTH1}년 ${tmAddr.BIRTH2}월 ${tmAddr.BIRTH3}일<br/>
								<span class="addrInfo">연락처 : </span>${tmAddr.HP1}-${tmAddr.HP2}-${tmAddr.HP3}<br/>
								<span class="addrInfo">이메일 : </span><a href="javascript:goEmail('${tmAddr.EMAIL}');">${tmAddr.EMAIL}</a><br/>
								<span class="addrInfo">우편번호 : </span>${tmAddr.POST1}-${tmAddr.POST2}<br/>
								<span class="addrInfo">기본주소 : </span>${tmAddr.ADDR1}<br/><span class="addrInfo">상세주소 : </span>${tmAddr.ADDR2}<br/>
								<span class="addrInfo">소개글 : </span>${tmAddr.PROFILE}<br/>
							</div>
						</td>
					<c:if test="${i%j == j-1 }">
					</tr>
					</c:if>
					<c:set var="i" value="${i+1}" />
				</c:forEach>
			</tbody>
			</c:if>
			
			<c:if test="${empty tmAddrList}">
			<tbody>
				<tr>
					<td colspan="3" style="padding: 15px; text-align: center;">팀원 목록이 존재하지 않습니다.</td>
				</tr>
			</tbody>
			</c:if>
	
		</table>	
		<br/>
	</div>

	<div style="width: 100%;">
		<!-- ==== 페이지바 ==== -->
		<div align="center" style="float: left;">
			${pagebar}
		</div>
		
		<!-- ==== 투표 검색창 ==== -->
		<div align="center" style="float: right;">
			<select name="colname" id="colname" class="form-control">
				<option value="userid">아이디</option>
				<option value="name">성명</option>
				<!-- <option value="name">글쓴이</option> -->
			</select>
			<input type="text" name="search" id="search" size="40" class="form-control" placeholder="검색할 단어를 입력해주세요" />
			<button type="button" class="btn btn-default" onclick="goSearch();">검색</button>
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