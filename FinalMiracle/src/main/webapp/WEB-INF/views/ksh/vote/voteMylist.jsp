<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="<%= request.getContextPath() %>/resources/js/highcharts.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/modules/exporting.js"></script>    

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
		
		$("#votekind").change(function(){
			goVoteKind();
		});
		
		$("#sizePerPage").change(function(){
			goSizePerPage();
		});
	});
	
	function searchKeep(){
		<c:if test="${(colname != 'null' && not empty colname) && (search != 'null' && not empty search)}">
			$("#colname").val("${colname}");//검색시 컬럼명을 유지시켜보자
			$("#search").val("${search}");//검색어 대한 검색어를 유지시켜보자
		</c:if>
		$("#votekind").val("${votekind}");
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
	
	function goVoteKind(){
		var frm = document.listFrm;
		
		frm.submit();
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
		    var frm = document.idxFrm;
			
			frm.idx.value = idx;
			
			frm.action = "voteDel.mr";
			frm.submit();
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
	
	function callChart(idx){
		var data_form = {"idx":idx};
		
		$.ajax({
			url: "voteCallChart.mr",
			type: "GET",
			data: data_form,
			dataType: "JSON",
			success: function(data){
				var processed_json = new Array();   
                $.getJSON('http://localhost:9090/miracle/voteCallChart.mr?idx='+idx, function(data) {
	                    // Populate series
	                    for (i = 0; i < data.length; i++){
	                        processed_json.push([data[i].item, data[i].votenum]);
	                    }
	                 
	                    // draw chart
	                    $('#chartbody').highcharts({
	                    chart: {
	                        type: "column"
	                    },
	                    title: {
	                        text: "투표 차트 결과"
	                    },
	                    xAxis: {
	                        type: 'category',
	                        allowDecimals: false,
	                        title: {
	                            text: "문항 목록"
	                        }
	                    },
	                    yAxis: {
	                        title: {
	                            text: "득표 수"
	                        }
	                    },
	                    series: [{
		                    name: '득표 수',
	                        data: processed_json
	                    }]
	                });
                });
                /* $("#chartModal").modal(); */
			}, error: function(request, status, error){
				swal("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			}
		});
	}
	
	function goVote(idx, fidx, itemidx, gobackURL){
		var frm = document.choiceFrm;
		
		frm.vote_idx.value = idx;
		frm.teamwon_idx.value = fidx;
		frm.voteitem_idx.value = itemidx;
		frm.gobackURL.value = gobackURL;
		
		frm.submit();
	}
	
	
</script>

<form class="form-inline" id="listFrm" name="listFrm" action="<%= request.getContextPath() %>/voteMyList.mr" method="get" enctype="multipart/form-data" style="font-family: verdana;">
<div style="padding-left: 1%; padding-right: 1%; border: solid 0px red; width: 100%; height: 840px; overflow-y: auto;">
	<div style="width: 100%;">
		<div style="float: left; margin-top: 2%;">
			<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'">진행중 투표</button>&nbsp;
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteReadyList.mr'">시작전 투표</button>&nbsp;
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteEndList.mr'">종료된 투표</button>&nbsp;
			<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteMyList.mr'">나의 투표</button>&nbsp; --%>
			<a href="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'" class="btn btn-primary">진행중 투표</a>&nbsp;
			<a href="javascript:location.href='<%= request.getContextPath() %>/voteReadyList.mr'" class="btn btn-primary">시작전 투표</a>&nbsp;
			<a href="javascript:location.href='<%= request.getContextPath() %>/voteEndList.mr'" class="btn btn-primary">종료된 투표</a>&nbsp;
			<a href="javascript:location.href='<%= request.getContextPath() %>/voteMyList.mr'" class="btn btn-primary">나의 투표</a>&nbsp;
		</div>
		<div style="float: right;">
			<h1>투표목록</h1>
		</div>
	</div>
	
	<div style="margin-top: 7%;">
		<div style="float: left; margin-bottom: 1%;">
			<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteAdd.mr'">투표작성</button> --%>
			<a href="javascript:location.href='<%= request.getContextPath() %>/voteAdd.mr'" class="btn btn-success">투표작성</a>&nbsp;
		</div>
		<div style="float: right; margin-bottom: 1%;">
			전체 <span style="color: red; font-weight: bold;">${totalCount}</span>&nbsp;
			목록 수 : 
			<select name="sizePerPage" id="sizePerPage" class="form-control">
				<option value="5">5</option>
				<option value="10">10</option>
				<option value="15">15</option>
				<option value="20">20</option>
			</select>
			&nbsp;투표 상태 : 
			<select name="votekind" id="votekind" class="form-control">
				<option value="ing">진행중</option>
				<option value="ready">시작전</option>
				<option value="end">종료</option>
			</select>
			<c:set value="${votekind}" var="votekind" />
		</div>
	</div>
	
	<div style="width: 100%; margin-top: 6%;">
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
			
			<c:if test="${not empty voteMyList}">
			<tbody>
				<c:forEach var="votevo" items="${voteMyList}" varStatus="status">
					<c:set value="${votevo.IDX}" var="voteidx" />
					<tr>
						<td>${votevo.IDX}</td>
						<td>${votevo.FK_TEAM_IDX} / ${votevo.FK_TEAMWON_IDX}</td>
						<td>
							<img src="<%= request.getContextPath() %>/resources/files/${votevo.IMG}" width="30px" height="30px">
							${votevo.NAME}(${votevo.USERID})
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
									<c:if test="${votekind eq 'ing'}">
										<input type="radio" name="voteitem_info" value="${voteitemvo.item}">${voteitemvo.item}&nbsp;${voteitemvo.votenum}표
										<%-- <button type="button" onClick="goVote('${votevo.IDX}', '${votevo.FK_TEAMWON_IDX}', '${voteitemvo.idx}', '${gobackURL}');">선택</button> --%>
										<a href="javascript:goVote('${votevo.IDX}', '${votevo.FK_TEAMWON_IDX}', '${voteitemvo.idx}', '${gobackURL}');" class="btn btn-xs btn-default">선택</a>&nbsp;
										<br/>
										<c:set var="votesum" value="${votesum + voteitemvo.votenum}" />
									</c:if>
									<c:if test="${votekind eq 'ready'}">
										＊ ${voteitemvo.item}
										<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteChoice.mr'">선택</button> --%>
									</c:if>
									<c:if test="${votekind ne 'ing'}">
										＊ ${voteitemvo.item} : ${voteitemvo.votenum}표
										<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteChoice.mr'">선택</button> --%>
										<br>
										<c:set var="votesum" value="${votesum + voteitemvo.votenum}" />
									</c:if>
								</c:if>
							</c:forEach>
							<br/>
							참여한 인원 : <c:out value="${votesum}"/>명
						</td>
						<td>
							<c:if test="${votekind eq 'ready'}">
								<%-- <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/voteEdit.mr?idx=${votevo.IDX}'">투표수정</button> --%>
								<a href="javascript:location.href='<%= request.getContextPath() %>/voteEdit.mr?idx=${votevo.IDX}'" class="btn btn-info">투표수정</a>&nbsp;
								<br>
							</c:if>
							<c:if test="${votekind eq 'end'}">
								<button class="btn btn-info" type="button" data-toggle="modal" data-target="#chartModal" onclick="callChart('${votevo.IDX}')">결과보기</button>
								<br>
							</c:if>
								<%-- <button type="button" onClick="goDel('${votevo.IDX}');">투표삭제</button>&nbsp; --%>
								<a href="javascript:goDel('${votevo.IDX}');" class="btn btn-danger">투표삭제</a>&nbsp;
						</td>
						<td>
							<textarea id="commcontent${votevo.IDX}" name="commcontent${votevo.IDX}" class="form-control" style="width: 80%; resize: none;" placeholder="타인을 비방하는 댓글은 삼가해주시기 바랍니다."></textarea>
							<%-- <button type="button" onClick="goCommAdd('${votevo.IDX}');">등록</button>&nbsp; --%>
							<a href="javascript:goCommAdd('${votevo.IDX}');" class="btn btn-default">등록</a>&nbsp;
							<br/>
							<c:forEach var="votecommvo" items="${voteCommList}" varStatus="status">
								<c:set value="${votecommvo.FK_VOTE_IDX}" var="votecommidx" />
								<c:if test="${voteidx eq votecommidx}">
									<img src="<%= request.getContextPath() %>/resources/images/${votecommvo.IMG}" width="30px" height="30px">
									${votecommvo.NAME}(${votecommvo.COMMDATE})<br/>${votecommvo.CONTENT}&nbsp;&nbsp;
									<c:if test="${votecommvo.MEMIDX eq sessionScope.loginUser.idx}">
										<%-- <button type="button" onClick="goCommAdd('${votevo.IDX}', '${votecommvo.IDX}');">수정</button>&nbsp; --%>
										<%-- <button type="button" onClick="goCommDel('${votecommvo.COMMIDX}');">삭제</button> --%>
										<a href="javascript:goCommDel('${votecommvo.COMMIDX}');" class="btn btn-xs btn-danger">×</a>&nbsp;
									</c:if>
									<br/>
								</c:if>
							</c:forEach>	
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</c:if>
			
			<c:if test="${empty voteMyList}">
			<tbody>
				<tr>
					<td colspan="10">투표 목록이 존재하지 않습니다.</td>
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
				<option value="subject">제목</option>
				<option value="content">내용</option>
				<!-- <option value="name">글쓴이</option> -->
			</select>
			<input type="text" name="search" id="search" size="40" class="form-control" placeholder="검색할 단어를 입력해주세요" />
			<a href="javascript:goSearch();" class="btn btn-default">검색</a>&nbsp;
		</div>
	</div>
	
	<input type="hidden" name="votekind" value="${votekind}" />
</div>
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

<form name="choiceFrm" action="<%= request.getContextPath() %>/voteChoice.mr" method="get" enctype="multipart/form-data">
	<input type="hidden" name="vote_idx"/>
	<input type="hidden" name="teamwon_idx"/>
	<input type="hidden" name="voteitem_idx"/>
	<input type="hidden" name="gobackURL" value="${gobackURL}" />
</form>


<div class="modal fade" id="chartModal" role="dialog" style="font-family: verdana;">
	<div class="modal-dialog modal-lg">

<!-- Modal content-->
	<div class="modal-content">
	    <div class="modal-header">
	      <button type="button" class="close" data-dismiss="modal">&times;</button>
	      <h4 class="modal-title">투표 결과</h4>
	    </div>
	    <div class="modal-body" id="chartbody" align="center">
	    </div>
	    <div class="modal-footer">
	      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	    </div>
	  </div>
	  
	</div>
</div>