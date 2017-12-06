<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">
  th {width: 25%;}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		var html = "";
		
		html += "<br/>";
		html += "<input type='text' name='items' class='form-control' style='width: 300px;' />";
		/* html += "<button type='button' onClick='goImageFile();'>이미지추가</button> <div id='addattach'></div>"; */
		html += "<br/>";
		html += "<input type='text' name='items' class='form-control' style='width: 300px;' />";
		/* html += "<button type='button' onClick='goImageFile();'>이미지추가</button> <div id='addattach'></div>"; */
		
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
				for(var i=2; i<parseInt(spinnerOqtyVal); i++) {
					html += "<br/>";
					html += "<input type='text' name='items' class='form-control' style='width: 300px;' />";
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
			alert("모든 항목에 빈 칸 없이 넣어주세요.");
			return
		} else {
			if(confirm("투표를 수정하시겠습니까?")){
				var frm = document.EditFrm;
				
				frm.submit();
			}
		}
	}
	
	function goReset() {
		var addFrm = document.addFrm;
		addFrm.reset();
		$("#result").empty();
	}
	
	function goImageFile(){
		
		var html = "";
		
		/* html += "<input type='file' name='addattach' class='btn btn-default' />"; */
		
		$("#divfileattach").prepend(html);
		
	}
	
</script>

<div>
	<h3 style="width: 60%; padding-top: 20px;">투표 수정</h3>
	
	 <%-- >>>> 파일첨부하기
	 	       enctype="multipart/form-data" 을 해주어야만 파일첨부가 된다. --%>
	<form name="EditFrm" action="<%= request.getContextPath() %>/voteEditEnd.mr" method="post" enctype="multipart/form-data" >
		<table id="table" class="table table-bordered" style="width: 70%; margin-top: 50px;">
			<tr>
				<th>제목명</th>
				<td>
					<div style="width: 30%;">
					  <input type="text" name="subject" id="subject" class="form-control" value="${votevo.subject}" />
					</div> 
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				    <div style="width: 100%;">
						<%-- <input type="text" name="content" id="content" class="form-control" value="${votevo.content}" /> --%>
						<textarea name="content" id="content" class="summernote">${votevo.content}</textarea>
					</div>
				</td>
			</tr>
			<tr>
				<th>시작날짜</th>
				<td>
					<div style="width: 50%;">
						<input type="text" id="datepicker1" name="datepicker1" value="${votevo.startdate}" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<th>종료날짜</th>
				<td>
					<div style="width: 50%;">
						<input type="text" id="datepicker2" name="datepicker2" value="${votevo.enddate}" readonly="readonly">
					</div>
				</td>
			</tr>
         	<tr>
         		<th>문항</th>
         		<td>
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
		
		<c:forEach var="itemvo" items="${voteitemvo}">
			<input type="hidden" name="itemidx" value="${itemvo.idx}" />
		</c:forEach>
		
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goEdit();">투표수정</button>
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goReset();">초기화</button>
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'">투표목록</button> 
	
	</form>
</div>