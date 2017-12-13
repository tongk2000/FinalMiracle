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
		html += "<br/>";
		html += "<input type='text' name='items' class='form-control' style='width: 300px;' />";
		
		$("#divbeginitems").append(html);
		
		$('.summernote').summernote({
	      height: 300,          // 기본 높이값
	      minHeight: null,      // 최소 높이값(null은 제한 없음)
	      maxHeight: null,      // 최대 높이값(null은 제한 없음)
	      focus: true,          // 페이지가 열릴때 포커스를 지정함
	      lang: 'ko-KR',         // 한국어 지정(기본값은 en-US)
/* 	      
	      callbacks: { // 콜백을 사용
              // 이미지를 업로드할 경우 이벤트를 발생
			    onImageUpload: function(files, editor, welEditable) {
				    sendFile(files[0], this);
				}
			}
 */
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
	

	function goAdd() {
		var subject = document.getElementById("subject").value;
		var content = document.getElementById("content").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		var datepicker2 = document.getElementById("datepicker2").value;
		
		if(subject.trim() == "" || content.trim() == "" || datepicker1.trim() == "" || datepicker2.trim() == ""){
			alert("모든 항목에 빈 칸 없이 넣어주세요.");
			return
		} else {
			if(confirm("투표를 추가하시겠습니까?")){
				var frm = document.addFrm;
				
				frm.submit();
			}
		}
		
		
	}
/* 	
	function sendFile(file, editor) {
        // 파일 전송을 위한 폼생성
 		data = new FormData();
 	    data.append("uploadFile", file);
 	    $.ajax({ // ajax를 통해 파일 업로드 처리
 	        data : data,
 	        type : "POST",
 	        url : "tmImageUpload.mr",
 	        cache : false,
 	        contentType : false,
 	        processData : false,
 	        success : function(data) { // 처리가 성공할 경우
                // 에디터에 이미지 출력
 	        	$(editor).summernote('editor.insertImage', data.path);
 	        }
 	    });
 	} 
*/
	
</script>

<div>
	<h3 style="width: 60%; padding-top: 20px;">투표 등록</h3>
	
	 <%-- >>>> 파일첨부하기
	 	       enctype="multipart/form-data" 을 해주어야만 파일첨부가 된다. --%>
	<form name="addFrm" action="<%= request.getContextPath() %>/voteAddEnd.mr" method="post" enctype="multipart/form-data" >
		<table id="table" class="table table-bordered" style="width: 70%; margin-top: 50px;">
			<tr>
				<th>제목명</th>
				<td>
					<div style="width: 30%;">
					  <input type="text" name="subject" id="subject" class="form-control" />
					</div> 
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
				    <div style="width: 100%">
					   <textarea name="content" id="content" class="summernote"></textarea>
					</div>
				</td>
			</tr>
			<tr>
				<th>시작날짜</th>
				<td>
					<div style="width: 50%;">
						<input type="text" id="datepicker1" name="datepicker1" readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<th>종료날짜</th>
				<td>
					<div style="width: 50%;">
						<input type="text" id="datepicker2" name="datepicker2" readonly="readonly">
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
		
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goAdd();">투표등록</button>
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="javascript:location.href='<%= request.getContextPath() %>/voteList.mr'">투표목록</button> 
	
	</form>
</div>