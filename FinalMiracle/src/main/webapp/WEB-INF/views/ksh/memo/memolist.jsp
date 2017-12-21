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
		
		$("#upfolder").change(function(){
			
			var folder = $("#upfolder").val();
			var arr_chk = document.getElementsByName("chk_memo");
			var chkbool = false;
			var html = "";
			
			if(folder == "새분류"){
				html += "<input id='newfolder' name='newfolder' style='width: 200px;' class='form-control' placeholder='추가할 분류를 입력하세요' />"
				html += "<button type=\"button\" class='form-control' onClick=\"goNewFolder();\">확인</button>"
				
				$("#folderdiv").append(html);
			} else if(folder == "") {
				$("#folderdiv").empty();
				
				return;
			}
			else {
				$("#folderdiv").empty();
				
				for(var i=0;i<arr_chk.length;i++){
		            if(arr_chk[i].checked == true) {
		                chkbool = true;
		                break;
		            }
				}
				
				if(!chkbool){
					swal("메모를 선택하지 않으셨습니다.", "", "info");
					return false;
				} else {
					var frm = document.listFrm;
					
					frm.action = "<%= request.getContextPath() %>/memoUpdateFolder.mr";
					frm.method = "post";
					frm.submit();
				}
			}
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
		var arr_chk = document.getElementsByName("chk_memo");
		var chkbool = false;
		var frm = document.listFrm;		
		
		for(var i=0;i<arr_chk.length;i++){
            if(arr_chk[i].checked == true) {
                chkbool = true;
                break;
            }
		}
		
		if(!chkbool){
			swal("메모를 선택하지 않으셨습니다.", "", "info");
			return false;
		} else {
			frm.action = "<%= request.getContextPath() %>/memoChkGarbage.mr";
			frm.method = "get";
			frm.submit();
		}
	}
	
	function goRestore(idx){
		var frm = document.idxFrm;
		
		frm.idx.value = idx;
		
		frm.action = "<%= request.getContextPath() %>/memoRestore.mr";
		frm.method = "get";
		frm.submit();
	}
	
	function goChkRestore(){
		var arr_chk = document.getElementsByName("chk_memo");
		var chkbool = false;
		var frm = document.listFrm;
		
		for(var i=0;i<arr_chk.length;i++){
            if(arr_chk[i].checked == true) {
                chkbool = true;
                break;
            }
		}
		
		if(!chkbool){
			swal("메모를 선택하지 않으셨습니다.", "", "info");
			return false;
		} else {
			frm.action = "<%= request.getContextPath() %>/memoChkRestore.mr";
			frm.method = "get";
			frm.submit();
		}
	}
	
	
	function goDel(idx){
		var frm = document.idxFrm;
		
		<%-- if(confirm("메모를 삭제하시겠습니까?")){
			frm.idx.value = idx;
			
			frm.action = "<%= request.getContextPath() %>/memoDel.mr";
			frm.method = "post";
			frm.submit();
		} --%>
		
		swal({
		  title: "메모 삭제 여부",
		  text: "메모를 삭제하시겠습니까?",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-danger",
		  confirmButtonText: "삭제",
		  cancelButtonText: "취소",
		  closeOnConfirm: false,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  if (isConfirm) {
		    frm.idx.value = idx;
			
			frm.action = "<%= request.getContextPath() %>/memoDel.mr";
			frm.method = "post";
			frm.submit();
		  }
		});

	}
	
	function goChkDel(){
		var arr_chk = document.getElementsByName("chk_memo");
		var chkbool = false;
		var frm = document.listFrm;
		
		<%-- if(confirm("선택된 메모들을 삭제하시겠습니까?")){
			
			for(var i=0;i<arr_chk.length;i++){
	            if(arr_chk[i].checked == true) {
	                chkbool = true;
	                break;
	            }
			}
			
			if(!chkbool){
				swal("메모를 선택하지 않으셨습니다.", "", "info");
				return false;
			} else {
				frm.action = "<%= request.getContextPath() %>/memoChkDel.mr";
				frm.method = "post";
				frm.submit();
			}
		} --%>
		
		swal({
		  title: "선택 삭제 여부",
		  text: "선택된 메모들을 삭제하시겠습니까?",
		  type: "warning",
		  showCancelButton: true,
		  confirmButtonClass: "btn-danger",
		  confirmButtonText: "삭제",
		  cancelButtonText: "취소",
		  closeOnConfirm: false,
		  closeOnCancel: true
		},
		function(isConfirm) {
		  if (isConfirm) {
		    for(var i=0;i<arr_chk.length;i++){
	            if(arr_chk[i].checked == true) {
	                chkbool = true;
	                break;
	            }
			}
			
			if(!chkbool){
				swal("메모를 선택하지 않으셨습니다.", "", "info");
				return false;
			} else {
				frm.action = "<%= request.getContextPath() %>/memoChkDel.mr";
				frm.method = "post";
				frm.submit();
			}
		  }
		});
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
	
	function goNewFolder(){
		var frm = document.listFrm;
		var folder = $("#newfolder").val();
		
		if(folder == ""){
			swal("새롭게 만드실 분류를 입력해주세요.", "", "info");
		} else {		
			frm.action = "<%= request.getContextPath() %>/memoCreateFolder.mr";
			frm.method = "post";
			frm.submit();
		}

	}

</script>


<form class="form-inline" id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/memoList.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 1%; padding-right: 1%; border: solid 0px red; width: 100%; height: 840px; overflow-y: auto; font-family: verdana; float: left;">
	<div style="width: 100%;">
		<div style="float: left; margin-top: 2%; overflow-x: auto;">
			<a href="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=전체'" class="btn btn-primary">전체</a>&nbsp;
			<a href="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=중요'" class="btn btn-primary">중요</a>&nbsp;
			<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=전체'">전체</button>&nbsp;
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=중요'">중요</button>&nbsp; --%>
			<c:forEach var="folder" items="${folderlist}" varStatus="status">
				<a href="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=${folder}'" class="btn btn-primary">${folder}</a>&nbsp;
				<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=${folder}'">${folder}</button>&nbsp; --%>
			</c:forEach>
			<a href="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=휴지통'" class="btn btn-primary">휴지통</a>&nbsp;
			<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoList.mr?folder=휴지통'">휴지통</button>&nbsp; --%>
		</div>
		
		<div style="float: right; text-align: right;">
			<h2>${folder}</h2>
		</div>
	</div>
	<br/><br/>
	<div style="width: 100%; margin-top: 3%;">
		<div style="float: left;">
		<c:if test="${groups ne '휴지통'}">
			전체선택 <input type="checkbox" name="chk_Allmemo" onclick="allcheck();">&nbsp;
			<a href="javascript:location.href='<%= request.getContextPath() %>/memoAdd.mr'" class="btn btn-success">메모작성</a>&nbsp;
			<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoAdd.mr'">메모작성</button>&nbsp; --%>
			<a href="javascript:goChkGarbage();" class="btn btn-warning">선택휴지통</a>&nbsp;
			<!-- <button type="button" onClick="goChkGarbage();">선택휴지통</button>&nbsp; -->
			<select name="upfolder" id="upfolder" class="form-control">
				<option value="">이동할 분류 선택</option>
				<option value="전체">전체</option>
				<option value="중요">중요</option>
				<c:forEach var="folder" items="${folderlist}" varStatus="status">
					<option value="${folder}">${folder}</option>
				</c:forEach>
				<option value="새분류">새분류</option>
			</select>
			&nbsp;&nbsp;
		</c:if>
		<c:if test="${groups eq '휴지통'}">
			전체선택 <input type="checkbox" name="chk_Allmemo" onclick="allcheck();">&nbsp;
			<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/memoAdd.mr'">메모작성</button>&nbsp;
			<button type="button" onClick="goChkRestore();">선택복구</button>&nbsp;
			<button type="button" onClick="goChkDel();">선택삭제</button>&nbsp; --%>
			<a href="javascript:location.href='<%= request.getContextPath() %>/memoAdd.mr'" class="btn btn-success">메모작성</a>&nbsp;
			<a href="javascript:goChkRestore();" class="btn btn-success">메모복구</a>&nbsp;
			<a href="javascript:goChkDel();" class="btn btn-danger">메모삭제</a>&nbsp;
			&nbsp;&nbsp;
		</c:if>
		</div>
		<div id="folderdiv" style="float: left;"></div>
		
		<div style="float: right;">
			전체 : <span style="color: red; font-weight: bold;">${totalCount}</span>&nbsp;&nbsp;
			목록 수 : 
			<select name="sizePerPage" id="sizePerPage" class="form-control">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>&nbsp;&nbsp;
			작성기간 : 
			<select name="period" id="period" class="form-control">
				<option value="-1">전체</option>
				<option value="7">일주일</option>
				<option value="30">1개월</option>
				<option value="90">3개월</option>
				<option value="180">6개월</option>
				<option value="365">1년</option>
			</select>
		</div>
	</div>
	
	<br/>
	
	<%-- <div style="width: 100%; margin-top: 3%;">
		<table id="table" style="width: 100%;">
			<thead>
				<tr>
					<th style="width: 5%;" align="center"><input type="checkbox" name="chk_Allmemo" onclick="allcheck();">선택</th>
					<th style="width: 5%;">메모번호</th>
					<th style="width: 5%;">회원번호</th>
					<th style="width: 5%;">팀원번호</th>
					<th style="width: 10%;">제목</th>
					<th style="width: 25%">내용</th>
					<th style="width: 5%;">분류</th>
					<th style="width: 13%;">작성일</th>
					<th style="width: 13%;">최종수정일</th>
					<th style="width: 14%;">비고</th>
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
								<a href="javascript:goEdit('${memovo.idx}');" class="btn btn-info">메모수정</a>&nbsp;
								<a href="javascript:goGarbage('${memovo.idx}');" class="btn btn-warning">휴지통</a>&nbsp;
							</c:if>
							<c:if test="${memovo.groups eq '휴지통'}">
								<button type="button" onClick="goRestore('${memovo.idx}');">메모복구</button>&nbsp;
								<button type="button" onClick="goDel('${memovo.idx}');">메모삭제</button>&nbsp;
								<a href="javascript:goRestore('${memovo.idx}');" class="btn btn-success">메모복구</a>&nbsp;
								<a href="javascript:goDel('${memovo.idx}');" class="btn btn-danger">메모삭제</a>&nbsp;
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
	</div> --%>
	
	<c:if test="${not empty memoList}">
		<c:forEach var="memovo" items="${memoList}" varStatus="status">
			<div style="width: 100%; height: auto; margin-top: 2%; border: 1px solid lightgray;">
				<div style="width: 5%; float: left; text-align: center; padding-top: 1%;">
					<img src="<%= request.getContextPath() %>/resources/images/memo.png" style="width: 50px; height: 50px;">
					<br/><br/><br/>
					<input type="checkbox" name="chk_memo" value="${memovo.idx}">
				</div>
				<div style="width: 95%; float: left; text-align: left; padding-top: 1%;">
					<div style="width: 95%; height: 20%; font-size: 15pt;">
						${memovo.subject}
					</div>
					<div style="width: 95%; height: 10%; font-size: 9pt; color:gray; vertical-align: center; margin-top: 1%;">
						분류 : ${memovo.groups}　|　작성일 : ${memovo.regdate}　|　최종수정일 : ${memovo.editdate}
					</div>
					<div style="width: 95%; margin-top: 2%;">
						${memovo.content}
					</div>
				</div>
				<div style="float: right; text-align: left; margin-bottom: 3%;">
					<c:if test="${memovo.groups ne '휴지통'}">
						<%-- <button type="button" onClick="goEdit('${memovo.idx}');">메모수정</button>&nbsp;
						<button type="button" onClick="goGarbage('${memovo.idx}');">휴지통</button>&nbsp; --%>
						<a href="javascript:goEdit('${memovo.idx}');" class="btn btn-info">메모수정</a>&nbsp;
						<a href="javascript:goGarbage('${memovo.idx}');" class="btn btn-warning">휴지통</a>&nbsp;
					</c:if>
					<c:if test="${memovo.groups eq '휴지통'}">
						<%-- <button type="button" onClick="goRestore('${memovo.idx}');">메모복구</button>&nbsp;
						<button type="button" onClick="goDel('${memovo.idx}');">메모삭제</button>&nbsp; --%>
						<a href="javascript:goRestore('${memovo.idx}');" class="btn btn-success">메모복구</a>&nbsp;
						<a href="javascript:goDel('${memovo.idx}');" class="btn btn-danger">메모삭제</a>&nbsp;
					</c:if>
				</div>
				<br/>　<br/>　<br/>
			</div>
		</c:forEach>
	</c:if>
	<c:if test="${empty memoList}">
		<div style="width: 100%; height: auto; margin-top: 2%; padding: 50px; border: 1px solid lightgray;">
				메모가 존재하지 않습니다.
		</div>
	</c:if>
	

	<div align="center" style="width: 100%; margin-top: 3%;">
		<!-- ==== 페이지바 ==== -->
		<div align="left" style="float: left;">
			${pagebar}
		</div>
	
		<!-- ==== 투표 검색창 ==== -->
		<div style="float: right;">
			<select name="colname" id="colname" class="form-control">
				<option value="subject">제목</option>
				<option value="content">내용</option>
				<!-- <option value="name">글쓴이</option> -->
			</select>
			<input type="text" name="search" id="search" size="40" class="form-control" placeholder="검색할 단어를 입력해주세요" />
			<!-- <button type="button" onclick="goSearch();">검색</button> -->
			<a href="javascript:goSearch();" class="btn btn-default">검색</a>&nbsp;
		</div>
	</div>
	
	<br/><br/><br/><br/><br/>
	
	<input type="hidden" name="gobackURL" value="${gobackURL}">

</div>
</form>


<form name="idxFrm">
	<input type="hidden" name="idx" />
	<input type="hidden" name="gobackURL" value="${gobackURL}">
</form>