<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">
  th {width: 15%; text-align: right; background-color: #F2F2F2;}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		var html = "";
		
		html += "<br/>";
		html += "<input type='text' name='items' class='form-control' style='width: 50%;' placeholder='1번 문항' />";
		html += "<br/>";
		html += "<input type='text' name='items' class='form-control' style='width: 50%;' placeholder='2번 문항' />";
		
		$("#divbeginitems").append(html);
		
		$('.summernote').summernote({
		      height: 300,          // 기본 높이값
		      minHeight: null,      // 최소 높이값(null은 제한 없음)
		      maxHeight: null,      // 최대 높이값(null은 제한 없음)
		      focus: true,          // 페이지가 열릴때 포커스를 지정함
		      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
		    });

		$("#spinnerOqty").spinner({
		spin: function( event, ui ) {
  	        if( ui.value > 10 ) {
  	          $( this ).spinner( "value", 2 ); 
  	          return false;
  	        } 
  	        else if ( ui.value < 2 ) {
  	          $( this ).spinner( "value", 10 );
  	          return false;
  	        }
  	      }
  	    });
		
		
		$("#spinnerOqty").bind("spinstop", function(){
			// 스핀너는 이벤트가 "change" 가 아니라 "spinstop" 이다.
			var html = "";
			
			var spinnerOqtyVal = $("#spinnerOqty").val();
			
			if(spinnerOqtyVal == "2") {
				$("#divitems").empty();
				return;
			}
			else
			{
				for(var i=3; i<=parseInt(spinnerOqtyVal); i++) {
					html += "<br/>";
					html += "<input type='text' name='items' class='form-control' style='width: 50%;' placeholder='"+i+"번 문항' />";
				}
				
				$("#divitems").empty();
				$("#divitems").append(html);
			}
		});
		
		$( "#datepicker1, #datepicker2" ).datepicker({
			dateFormat: 'yy-mm-dd'
		});
		
	}); // end of $(document).ready()-----------------------------------
	

	function goEdit() {
		// 유효성 검사는 생략함.
		
		var subject = document.getElementById("subject").value;
		var content = document.getElementById("content").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		var datepicker2 = document.getElementById("datepicker2").value;
		
		if(subject.trim() == "" || content.trim() == "" || datepicker1.trim() == "" || datepicker2.trim() == ""){
			swal("수정 실패!", "모든 항목에 빈 칸 없이 넣어주세요.", "error");
			return;
		} else {
			/* if(confirm("투표를 수정하시겠습니까?")){
				var frm = document.EditFrm;
				
				frm.submit();
			} */
			
			swal({
			  title: "수정 여부",
			  text: "투표를 수정하시겠습니까?",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonClass: "btn-warning",
			  confirmButtonText: "수정",
			  cancelButtonText: "취소",
			  closeOnConfirm: false,
			  closeOnCancel: true
			},
			function(isConfirm) {
			  if (isConfirm) {
				var frm = document.EditFrm;
					
				frm.submit();
			  }
			});
		}
	}
	
	function goImageFile(){
		
		var html = "";
		
		/* html += "<input type='file' name='addattach' class='btn btn-default' />"; */
		
		$("#divfileattach").prepend(html);
		
	}
	
</script>

<div style="width:100%; font-family: verdana;" align="center">
	<h1 style="margin: 2%;">투표 수정</h1>
	
	 <%-- >>>> 파일첨부하기
	 	       enctype="multipart/form-data" 을 해주어야만 파일첨부가 된다. --%>
	<form class="form-inline" name="EditFrm" action="<%= request.getContextPath() %>/voteEditEnd.mr" method="post" enctype="multipart/form-data" >
		<table id="table" class="table table-bordered" style="width: 80%; margin-top: 50px;">
			<tr>
				<th style="vertical-align: middle;">제목명</th>
				<td colspan="2">
					<div style="width: 100%;">
					  <input type="text" name="subject" id="subject" class="form-control" style="width: 100%;" value="${votevo.subject}" placeholder="제목을 입력하세요" />
					</div> 
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">내용</th>
				<td colspan="2">
				    <div style="width: 100%;">
						<%-- <input type="text" name="content" id="content" class="form-control" value="${votevo.content}" /> --%>
						<textarea name="content" id="content" class="summernote">
						<c:forEach var="vote" items="${votevo}" varStatus="status">
							${vote.content}
						</c:forEach>
						</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">날짜</th>
				<td>
					<div style="width: 100%;">
						<input type="text" id="datepicker1" name="datepicker1" class="form-control" style="width: 100%;" value="${votevo.startdate}" placeholder="시작날짜를 입력하세요 (클릭)" readonly="readonly">
					</div>
					<div style="width: 100%;">
						<input type="text" id="datepicker2" name="datepicker2" class="form-control" style="width: 100%;" value="${votevo.enddate}" placeholder="종료날짜를 입력하세요 (클릭)" readonly="readonly">
					</div>
				</td>
			</tr>
         	<tr>
         		<th style="vertical-align: middle;">문항</th>
         		<td colspan="2">
         		    <label for="spinnerOqty">문항 수 : </label>
  		            <input id="spinnerOqty" value="2" style="width: 30px; height: 20px;">
  		            <br/>
					
					<div id="divbeginitems"></div>
         		    <div id="divitems"></div>
         		    <div id="divfileattach"></div>
         		</td>
         	</tr>
		</table>
		<br/>
		
		<input type="hidden" name="idx" value="${idx}" />
		<input type="hidden" name="gobackURL" value="${gobackURL}" />
		
		<c:forEach var="itemvo" items="${voteitemvo}">
			<input type="hidden" name="itemidx" value="${itemvo.idx}" />
		</c:forEach>
		
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goEdit();">투표수정</button>
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'">투표목록</button> 
	
	</form>
</div>