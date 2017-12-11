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
	
	function goVote(idx, fidx, itemidx, gobackURL){
		var frm = document.choiceFrm;
		
		frm.vote_idx.value = idx;
		frm.teamwon_idx.value = fidx;
		frm.voteitem_idx.value = itemidx;
		frm.gobackURL.value = gobackURL;
		
		frm.submit();
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
	
	function goCommAdd(idx){
		var commcontent = document.getElementById("commcontent"+idx).value;
		var frm = document.addCommFrm;
		
		//alert(idx + commcontent);
		
		if(commcontent.trim() == ""){
			alert("빈 칸은 입력할 수 없습니다.");
			return;
		} else {
			frm.voteidx.value = idx;
			frm.comment.value = commcontent;

			frm.submit();
		}

	}
	
	
	function goCommDel(idx){
		var frm = document.DelCommFrm;
		
		frm.delidx.value = idx;

		frm.submit();
	}
	
</script>

<form id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/voteList.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 10%; border: solid 0px red; width: 100%; height: 100%; overflow-y: auto;">
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
				<th style="width: 5%;">투표번호</th>
				<th style="width: 5%;">팀번호</th>
				<th style="width: 5%;">팀원번호</th>
				<th style="width: 10%;">제목</th>
				<th style="width: 20%">내용</th>
				<th style="width: 5%;">시작날짜</th>
				<th style="width: 5%;">종료날짜</th>
				<th style="width: 10%;">문항</th>
				<th style="width: 10%;">비고</th>
				<th style="width: 25%;">댓글</th>
			</tr>
		</thead>
		
		<c:if test="${not empty voteList}">
		<tbody>
			<c:forEach var="votevo" items="${voteList}" varStatus="status">
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
								<input type="radio" name="voteitem_info" value="${voteitemvo.item}">${voteitemvo.item}&nbsp;${voteitemvo.votenum}표
								<button type="button" onClick="goVote('${votevo.IDX}', '${votevo.FK_TEAMWON_IDX}', '${voteitemvo.idx}', '${gobackURL}');">선택</button>
								<br>
							</c:if>
						</c:forEach>	
					</td>
					<td>
						<%-- <c:if test="${votevo.FK_TEAMWON_IDX eq sessionScope.idx}"> --%>
							<button type="button" onClick="goDel('${votevo.IDX}');">투표삭제</button>&nbsp;
						<%-- </c:if> --%>
					</td>
					<td>
						<input type="text" id="commcontent${votevo.IDX}" name="commcontent${votevo.IDX}" size="35px;" />
						<button type="button" onClick="goCommAdd('${votevo.IDX}');">등록</button>&nbsp;
						<br/>
						<c:forEach var="votecommvo" items="${voteCommList}" varStatus="status">
							<c:set value="${votecommvo.FK_VOTE_IDX}" var="votecommidx" />
							<c:if test="${voteidx eq votecommidx}">
								${votecommvo.NAME}(${votecommvo.USERID}) : ${votecommvo.CONTENT}
								<c:if test="${votecommvo.MEMIDX eq sessionScope.loginUser.idx}">
									<%-- <button type="button" onClick="goCommAdd('${votevo.IDX}', '${votecommvo.IDX}');">수정</button>&nbsp; --%>
									<button type="button" onClick="goCommDel('${votecommvo.COMMIDX}');">삭제</button>
								</c:if>
								<br/>
							</c:if>
						</c:forEach>	
					</td>
				</tr>
			</c:forEach>
		</tbody>
		</c:if>
		
		<c:if test="${empty voteList}">
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

<form name="addCommFrm" action="<%= request.getContextPath() %>/voteCommAdd.mr" method="get" enctype="multipart/form-data">
	<input type="hidden" id="voteidx" name="voteidx" />
	<input type="hidden" id="comment" name="comment" />
	<input type="hidden" name="gobackURL" value="${gobackURL}" />
</form>

<form name="DelCommFrm" action="<%= request.getContextPath() %>/voteCommDel.mr" method="get" enctype="multipart/form-data">
	<input type="hidden" id="delidx" name="delidx" />
	<input type="hidden" name="gobackURL" value="${gobackURL}" />
</form>

<form name="choiceFrm" action="<%= request.getContextPath() %>/voteChoice.mr" method="get" enctype="multipart/form-data">
	<input type="hidden" name="vote_idx"/>
	<input type="hidden" name="teamwon_idx"/>
	<input type="hidden" name="voteitem_idx"/>
	<input type="hidden" name="gobackURL" value="${gobackURL}" />
</form>

<form name="idxFrm">
	<input type="hidden" name="idx" />
	<input type="hidden" name="gobackURL" value="${gobackURL}">
</form>
