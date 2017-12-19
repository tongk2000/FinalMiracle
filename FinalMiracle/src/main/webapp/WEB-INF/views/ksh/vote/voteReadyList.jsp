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
			swal("검색어를 입력하세요");
			return;
		} else {
			frm.submit();
		}
	}
	
	function goDel(idx){
		
		/* if(confirm("투표를 삭제하시겠습니까?")){
			var frm = document.idxFrm;
			
			frm.idx.value = idx;
			
			frm.action = "voteDel.mr";
			frm.submit();
		} */
		
		swal({
		  title: "투표 삭제 여부",
		  text: "투표를 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		    if (willDelete) {
		    	var frm = document.idxFrm;
				
				frm.idx.value = idx;
				
				frm.action = "voteDel.mr";
				frm.submit();
			}
		  	else {
		    	return;
		  }
		});
		
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
			swal("빈 칸은 입력할 수 없습니다.");
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
	
	function showUserInfo(userid) {
		var form_data = { "userInfo" : userid };
		$.ajax({
			url: "freeUserInfo.mr",
			type: "GET",
			data: form_data,  // url 요청페이지로 보내는 ajax 요청 데이터
			dataType: "JSON", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
			success: function(data) {				
				var html = "";
				
				var imgPath = data.infoImg;
				html += "<div style='float: right;'><img src='<%= request.getContextPath() %>/resources/images/" + imgPath + "' style='width: 100px; height: 100px;' /></div>" + "<br/>"
					 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
					 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/>"
					 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
					 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/>"
					 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "</span><br/>"
					 +  "<span style='font-weight: bold;'>이메일 : </span>" + "<a href=\"javascript:goEmail('"+data.infoEmail+"');\">" + data.infoEmail + "</a><br/><br/>"
					 +  "<span style='font-weight: bold;'>소개 : </span>" + data.infoProfile ;
				
				$("#InfoModalBody").html(html);
				$("#InfoModal").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				swal("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
	
	function goEmail(email){
		
		window.open("tmWriteEmail.mr?email="+email, "subwinpop", "left=500px, top=500px, width=800px, height=600px");
	}
	
	function goEdit(idx){
		var frm = document.idxFrm;
		
		frm.idx.value = idx;
		frm.action = "voteEdit.mr";
		frm.submit();
	}
	
	
</script>

<form class="form-inline" id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/voteReadyList.mr" method="get" enctype="multipart/form-data">
<div style="padding-left: 1%; padding-right: 1%; border: solid 0px red; width: 100%; height: 840px; overflow-y: auto;">
	<h1>투표목록</h1>
	
	<div style="margin-top: 20px;">
		<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'">진행중 투표</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteReadyList.mr'">시작전 투표</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteEndList.mr'">종료된 투표</button>&nbsp;
		<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteMyList.mr'">나의 투표</button>&nbsp; --%>
		<a href="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'" class="btn btn-primary">진행중 투표</a>&nbsp;
		<a href="javascript:location.href='<%= request.getContextPath() %>/voteReadyList.mr'" class="btn btn-primary">시작전 투표</a>&nbsp;
		<a href="javascript:location.href='<%= request.getContextPath() %>/voteEndList.mr'" class="btn btn-primary">종료된 투표</a>&nbsp;
		<a href="javascript:location.href='<%= request.getContextPath() %>/voteMyList.mr'" class="btn btn-primary">나의 투표</a>&nbsp;
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
				<th style="width: 5%;">투표번호</th>
				<th style="width: 5%;">팀 / <br/>팀원번호</th>
				<th style="width: 10%;">글쓴이</th>
				<th style="width: 10%;">제목</th>
				<th style="width: 15%">내용</th>
				<th style="width: 5%;">시작날짜</th>
				<th style="width: 5%;">종료날짜</th>
				<th style="width: 10%;">문항</th>
				<th style="width: 10%;">비고</th>
				<th style="width: 25%;">댓글</th>
			</tr>
		</thead>
		
		<c:if test="${not empty voteReadyList}">
		<tbody>
			<c:forEach var="votevo" items="${voteReadyList}" varStatus="status">
				<c:set value="${votevo.IDX}" var="voteidx" />
				<tr>
					<td>${votevo.IDX}</td>
					<td>${votevo.FK_TEAM_IDX} / ${votevo.FK_TEAMWON_IDX}</td>
					<td>
						<img src="<%= request.getContextPath() %>/resources/files/${votevo.IMG}" width="30px" height="30px">
						<a href="javascript:showUserInfo('${votevo.USERID}')">${votevo.NAME}(${votevo.USERID})</a>
					</td>
					<td>${votevo.SUBJECT}</td>
					<td>${votevo.CONTENT}</td>
					<td>${votevo.STARTDATE}</td>
					<td>${votevo.ENDDATE}</td>
					<td>
						<c:set value="0" var="votesum" />
						<c:forEach var="voteitemvo" items="${voteItemList}" varStatus="status">
							<c:set value="${voteitemvo.fk_vote_idx}" var="voteitemidx" />
							<c:if test="${voteidx eq voteitemidx}">
								* ${voteitemvo.item} : ${voteitemvo.votenum}표<br/>
								<c:set var="votesum" value="${votesum + voteitemvo.votenum}" />
							</c:if>
						</c:forEach>
						<br/>
						참여한 인원 : <c:out value="${votesum}"/>명
					</td>
					<td>
						<c:if test="${voteidx eq sessionScope.idx}">
							<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteEdit.mr?idx=${votevo.IDX}'">투표수정</button>
							<button type="button" onClick="goDel('${votevo.IDX}');">투표삭제</button>&nbsp; --%>
							<a href="javascript:goEdit('${votevo.IDX}');" class="btn btn-info">투표수정</a>&nbsp;
							<a href="javascript:goDel('${votevo.IDX}');" class="btn btn-danger">투표삭제</a>&nbsp;
						</c:if>
					</td>
					<td>
						<textarea id="commcontent${votevo.IDX}" name="commcontent${votevo.IDX}" class="form-control" style="width: 80%; resize: none;" placeholder="타인을 비방하는 댓글은 삼가해주시기 바랍니다."></textarea>
						<%-- <button type="button" onClick="goCommAdd('${votevo.IDX}');">등록</button>&nbsp; --%>
						<a href="javascript:goCommAdd('${votevo.IDX}');" class="btn btn-default">댓글등록</a>&nbsp;
						<br/>
						<c:forEach var="votecommvo" items="${voteCommList}" varStatus="status">
							<c:set value="${votecommvo.FK_VOTE_IDX}" var="votecommidx" />
							<c:if test="${voteidx eq votecommidx}">
								<img src="<%= request.getContextPath() %>/resources/images/${votecommvo.IMG}" width="30px" height="30px">
								${votecommvo.NAME}(${votecommvo.COMMDATE})<br/>${votecommvo.CONTENT}&nbsp;&nbsp;
								<c:if test="${votecommvo.MEMIDX eq sessionScope.loginUser.idx}">
									<%-- <button type="button" onClick="goCommAdd('${votevo.IDX}', '${votecommvo.IDX}');">수정</button>&nbsp; --%>
									<%-- <button type="button" onClick="goCommDel('${votecommvo.COMMIDX}');">삭제</button> --%>
									<a href="javascript:goCommDel('${votecommvo.COMMIDX}');" class="btn btn-xs btn-danger">댓글삭제</a>&nbsp;
								</c:if>
								<br/>
							</c:if>
						</c:forEach>	
					</td>
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
	<div align="center" style="width: 100%;">
		${pagebar}
	</div>
	
	<!-- ==== 투표 검색창 ==== -->
	<div align="center" style="width: 100%;">
	
		<div style="float: left;">
			<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteAdd.mr'">투표작성</button> --%>
			<a href="javascript:location.href='<%= request.getContextPath() %>/voteAdd.mr'" class="btn btn-success">투표작성</a>&nbsp;
		</div>
		
		<select name="colname" id="colname" class="form-control">
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<!-- <option value="name">글쓴이</option> -->
		</select>
		<input type="text" name="search" id="search" size="40" class="form-control" placeholder="검색할 단어를 입력해주세요" />
		<a href="javascript:goSearch();" class="btn btn-default">검색</a>&nbsp;
	</div>
	

</div>
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

<form name="addCommFrm" action="<%= request.getContextPath() %>/voteCommAdd.mr" method="get" enctype="multipart/form-data">
	<input type="hidden" id="voteidx" name="voteidx" />
	<input type="hidden" id="comment" name="comment" />
	<input type="hidden" name="gobackURL" value="${gobackURL}" />
</form>

<form name="DelCommFrm" action="<%= request.getContextPath() %>/voteCommDel.mr" method="get" enctype="multipart/form-data">
	<input type="hidden" id="delidx" name="delidx" />
	<input type="hidden" name="gobackURL" value="${gobackURL}" />
</form>


<!-- 회원 상세정보 모달 창 -->
<!-- Modal -->
<div class="modal fade modal-center" id="InfoModal" role="dialog">
	<div class="modal-dialog modal-sm modal-center">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">회원 상세 정보</h4>
			</div>
			<div class="modal-body" id="InfoModalBody">
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>

	</div>
</div>